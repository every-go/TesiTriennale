import re
from pathlib import Path
from typing import Set, Dict, List, Tuple

def parse_glossary_terms(glossary_file: Path) -> Dict[str, Dict[str, str]]:
    """
    Parsa il file del glossario e estrae i termini con le loro varianti.
    Ritorna un dizionario: key -> {short, long, description}
    """
    content = glossary_file.read_text(encoding='utf-8')
    
    # Rimuovi i blocchi commentati /* ... */
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    
    terms = {}
    
    # Pattern per trovare ogni termine nel glossary
    pattern = r'\(\s*key:\s*"([^"]+)",\s*short:\s*\[([^\]]+)\],\s*long:\s*\[([^\]]+)\],\s*description:\s*\[([^\]]*)\]'
    
    matches = re.finditer(pattern, content, re.DOTALL)
    
    for match in matches:
        key = match.group(1)
        short = match.group(2).strip()
        long = match.group(3).strip()
        description = match.group(4).strip()
        
        terms[key] = {
            'short': short,
            'long': long,
            'description': description
        }
    
    return terms

def get_all_variants(terms: Dict[str, Dict[str, str]]) -> List[Tuple[str, str]]:
    """
    Genera tutte le varianti di ogni termine (short e long).
    Ritorna lista di tuple (variante_testo, key) ordinate per lunghezza decrescente.
    """
    variants = []
    
    for key, data in terms.items():
        short = data['short'].strip()
        long = data['long'].strip()
        
        # Aggiungi sia short che long
        variants.append((short, key))
        variants.append((long, key))
    
    # Ordina per lunghezza decrescente per matchare prima i termini più lunghi
    variants.sort(key=lambda x: len(x[0]), reverse=True)
    
    return variants

def find_typst_files(root_file: Path, visited: Set[Path], exclude_files: Set[str]) -> Set[Path]:
    """
    Trova ricorsivamente tutti i file .typ inclusi partendo dal file principale.
    """
    if visited is None:
        visited = set()
    
    if exclude_files is None:
        exclude_files = set()
    
    # Risolvi il path assoluto
    root_file = root_file.resolve()
    
    if root_file in visited or not root_file.exists():
        return visited
    
    # Salta se il file è nella lista di esclusione
    if root_file.name in exclude_files:
        return visited
    
    visited.add(root_file)
    
    content = root_file.read_text(encoding='utf-8')
    
    # Pattern per trovare #include "percorso.typ" o #import "percorso.typ"
    include_pattern = r'#(?:include|import)\s+"([^"]+)"'
    
    matches = re.finditer(include_pattern, content)
    
    for match in matches:
        relative_path = match.group(1)
        # Risolvi il percorso relativo rispetto al file corrente
        included_file = (root_file.parent / relative_path).resolve()
        
        if included_file.suffix == '.typ':
            find_typst_files(included_file, visited, exclude_files)
    
    return visited

def remove_existing_glossary_references(file_path: Path) -> Tuple[int, str]:
    """
    Rimuove tutti i riferimenti #gl() e #glpl() esistenti, 
    sostituendoli con il testo che era dentro.
    Ritorna il numero di rimozioni effettuate.
    """
    content = file_path.read_text(encoding='utf-8')
    original_content = content
    
    # Pattern per matchare #gl("key") o #glpl("key")
    pattern = r'#gl(?:pl)?\("([^"]+)"[^)]*\)'
    
    def replace_with_key(match):
        key = match.group(1)
        return f"GLOSSARY_KEY_{key}"
    
    # Sostituisci con placeholder
    content = re.sub(pattern, replace_with_key, content)
    
    removals = original_content.count('#gl(') + original_content.count('#glpl(')
    
    return removals, content

def restore_original_text(content: str, terms: Dict[str, Dict[str, str]]) -> str:
    """
    Sostituisce i placeholder GLOSSARY_KEY_xxx con il testo short del glossario.
    """
    for key, data in terms.items():
        placeholder = f"GLOSSARY_KEY_{key}"
        short_text = data['short'].strip()
        content = content.replace(placeholder, short_text)
    
    return content

def is_in_heading(content: str, pos: int) -> bool:
    """
    Verifica se la posizione è dentro un heading (=, ==, ===, ecc.)
    """
    # Trova l'inizio della riga
    line_start = content.rfind('\n', 0, pos) + 1
    line_end = content.find('\n', pos)
    if line_end == -1:
        line_end = len(content)
    
    line = content[line_start:line_end]
    
    # Verifica se la riga inizia con = (heading)
    stripped = line.lstrip()
    if stripped.startswith('='):
        return True
    
    return False

def is_in_figure_caption(content: str, pos: int) -> bool:
    """
    Verifica se la posizione è dentro una caption di figure.
    """
    # Cerca l'ultimo #figure( prima della posizione
    figure_start = content.rfind('#figure(', 0, pos)
    if figure_start == -1:
        return False

    text_from_figure = content[figure_start:pos]

    caption_match = re.search(r'caption:\s*\[', text_from_figure)
    if not caption_match:
        return False

    # Conta bilanciamento parentesi quadre a partire dall'apertura della caption
    depth = 0
    for ch in text_from_figure[caption_match.end() - 1:]:
        if ch == '[':
            depth += 1
        elif ch == ']':
            depth -= 1
            if depth == 0:
                return False  # Caption già chiusa prima di pos

    return depth > 0  # Siamo ancora dentro la caption

def add_glossary_references(content: str, variants: List[Tuple[str, str]], file_name: str = "", dry_run: bool = True) -> Tuple[str, int]:
    """
    Aggiunge i riferimenti al glossario nel contenuto.
    Ritorna il contenuto modificato e il numero di sostituzioni.
    """
    modifications = 0
    additions_log = []
    
    # Per ogni variante (dal più lungo al più corto)
    for variant_text, key in variants:
        # Se è tutto maiuscolo (acronimo), usa word boundary più strict
        if variant_text.isupper() and len(variant_text) <= 10:
            # Per acronimi: deve essere isolato da spazi/punteggiatura
            pattern = re.compile(
                r'(?<![a-zA-ZàèéìòùÀÈÉÌÒÙ])' + re.escape(variant_text) + r'(?![a-zA-ZàèéìòùÀÈÉÌÒÙ])',
                re.IGNORECASE
            )
        else:
            # Per parole normali, usa word boundary standard
            pattern = re.compile(
                r'\b' + re.escape(variant_text) + r'\b',
                re.IGNORECASE
            )
        
        # Trova tutte le occorrenze
        matches = list(pattern.finditer(content))
        
        # Processa dall'ultima alla prima per non invalidare gli indici
        for match in reversed(matches):
            pos = match.start()
            matched_text = match.group(0)
            
            # Salta se dentro un heading
            if is_in_heading(content, pos):
                continue
            
            # Salta se dentro una caption di figure
            if is_in_figure_caption(content, pos):
                continue
            
            # Salta se dentro una label Typst <nome-label>
            label_start = content.rfind('<', 0, pos)
            if label_start != -1:
                label_end = content.find('>', label_start)
                if label_end != -1 and label_end >= pos:
                    label_content = content[label_start + 1:label_end]
                    if re.fullmatch(r'[\w-]+', label_content):
                        continue

            # Salta se dentro un riferimento Typst @nome-label
            ref_start = content.rfind('@', 0, pos)
            if ref_start != -1:
                between = content[ref_start + 1:pos]
                if re.fullmatch(r'[\w:\-]*', between):
                    continue
            
            # Salta se dentro un commento
            line_start = content.rfind('\n', 0, pos) + 1
            line_to_pos = content[line_start:pos]
            line_full = content[line_start:content.find('\n', pos) if content.find('\n', pos) != -1 else len(content)]
            
            if '//' in line_full:
                comment_pos = line_full.index('//')
                if comment_pos <= len(line_to_pos):
                    continue
            
            # Salta se dentro codice raw (backticks)
            if content.count('`', 0, pos) % 2 == 1:
                continue
            
            # Salta se dentro stringhe tra virgolette
            if content.count('"', 0, pos) % 2 == 1:
                continue
            
            # Sostituisci
            replacement = f'#gl("{key}")'
            content = content[:pos] + replacement + content[pos + len(matched_text):]
            modifications += 1
            
            # Log dell'aggiunta
            additions_log.append(f"'{matched_text}' -> #gl(\"{key}\")")
    
    # Stampa il log delle aggiunte
    if additions_log and dry_run:
        print(f"\n   📝 Aggiunte in {file_name}:")
        for log_entry in additions_log:
            print(f"      • {log_entry}")
    elif additions_log and not dry_run:
        print(f"\n   ✓ Aggiunte in {file_name}:")
        for log_entry in additions_log:
            print(f"      • {log_entry}")
    
    return content, modifications

def process_file(file_path: Path, terms: Dict[str, Dict[str, str]], variants: List[Tuple[str, str]], dry_run: bool = True) -> Tuple[int, int]:
    """
    Processa un singolo file: rimuove vecchi riferimenti e ne aggiunge di nuovi.
    Ritorna (numero_rimozioni, numero_aggiunte).
    """
    # Step 1: Rimuovi riferimenti esistenti
    removals, content = remove_existing_glossary_references(file_path)
    
    # Step 2: Ripristina il testo originale dai placeholder
    content = restore_original_text(content, terms)
    
    # Step 3: Aggiungi nuovi riferimenti
    content, additions = add_glossary_references(content, variants, file_name=file_path.name, dry_run=dry_run)
    
    # Scrivi solo se non è dry run e ci sono state modifiche
    if not dry_run and (removals > 0 or additions > 0):
        file_path.write_text(content, encoding='utf-8')
        print(f"✓ {file_path.name}: rimossi {removals}, aggiunti {additions}")
    elif dry_run and (removals > 0 or additions > 0):
        print(f"[DRY RUN] {file_path.name}: rimuovere {removals}, aggiungere {additions}")
    
    return removals, additions

def main():
    # Configurazione
    GLOSSARY_FILE = Path("appendix/glossary/terms.typ").resolve()
    CHAPTERS_DIR = Path("chapters").resolve()  # Solo questa cartella
    
    DRY_RUN = False  # Cambia a False per applicare le modifiche
    
    if not GLOSSARY_FILE.exists():
        print(f"❌ File glossario non trovato: {GLOSSARY_FILE}")
        return
    
    if not CHAPTERS_DIR.exists():
        print(f"❌ Cartella chapters non trovata: {CHAPTERS_DIR}")
        return
    
    print("📖 Parsing glossario...")
    terms = parse_glossary_terms(GLOSSARY_FILE)
    print(f"   Trovati {len(terms)} termini nel glossario")
    
    print("\n🔍 Generazione varianti...")
    variants = get_all_variants(terms)
    print(f"   Totale varianti da cercare: {len(variants)}")
    for v, k in variants[:5]:
        print(f"   - '{v}' -> {k}")
    if len(variants) > 5:
        print(f"   ... e altre {len(variants) - 5}")
    
    print("\n📂 Ricerca file .typ nella cartella chapters/...")
    all_files = set(CHAPTERS_DIR.glob("**/*.typ"))
    print(f"   Trovati {len(all_files)} file .typ in chapters/")
    
    # Trova la directory base comune per i path relativi
    base_dir = Path.cwd()
    for f in sorted(all_files):
        try:
            rel_path = f.relative_to(base_dir)
            print(f"   - {rel_path}")
        except ValueError:
            print(f"   - {f.name}")
    
    print(f"\n{'🧪 [DRY RUN] ' if DRY_RUN else '✏️  '}Processing files...")
    total_removals = 0
    total_additions = 0
    
    for file_path in sorted(all_files):
        removals, additions = process_file(file_path, terms, variants, dry_run=DRY_RUN)
        total_removals += removals
        total_additions += additions
    
    print(f"\n{'[DRY RUN] ' if DRY_RUN else ''}Totale:")
    print(f"   Riferimenti rimossi: {total_removals}")
    print(f"   Riferimenti aggiunti: {total_additions}")
    
    if DRY_RUN:
        print("\n⚠️  Questo era un DRY RUN. Nessuna modifica è stata applicata.")
        print("   Cambia DRY_RUN = False nello script per applicare le modifiche.")
    else:
        print("\n✅ Modifiche applicate!")

if __name__ == "__main__":
    main()