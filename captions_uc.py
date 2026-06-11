import re
import sys
from pathlib import Path

def compute_uc_code(counters, level):
    """Genera il codice UC in base ai contatori dei livelli."""
    # level 4 -> UC1, level 5 -> UC1.1, level 6 -> UC1.1.1, level 7 -> UC1.1.1.1
    depth = level - 4  # 0-indexed depth
    parts = [counters[l] for l in range(4, 4 + depth + 1)]
    return "UC" + ".".join(str(p) for p in parts)

def process_file(input_path: Path, output_path: Path):
    content = input_path.read_text(encoding="utf-8")
    lines = content.splitlines(keepends=True)

    # Contatori per livelli 4-7
    counters = {4: 0, 5: 0, 6: 0, 7: 0}

    # Heading regex: cattura livello (numero di =), titolo e label opzionale
    heading_re = re.compile(r'^(={4,7})\s+(.+?)(?:<[^>]+>)?\s*$')

    # Caption regex dentro #img(
    caption_re = re.compile(r'(\s*caption:\s*\[)UC[\d.]+:\s*(.+?)(\])')

    result = []
    i = 0
    last_uc_code = None
    last_uc_title = None

    while i < len(lines):
        line = lines[i]
        stripped = line.rstrip('\n')

        m = heading_re.match(stripped)
        if m:
            level = len(m.group(1))
            title = m.group(2).strip()

            if 4 <= level <= 7:
                # Incrementa il contatore del livello corrente
                counters[level] += 1
                # Azzera tutti i livelli inferiori
                for l in range(level + 1, 8):
                    counters[l] = 0

                last_uc_code = compute_uc_code(counters, level)
                last_uc_title = title

            result.append(line)
            i += 1
            continue

        # Se siamo dentro un #img( e c'è una caption, aggiornala
        if last_uc_code and caption_re.search(stripped):
            new_line = caption_re.sub(
                lambda mo: f"{mo.group(1)}{last_uc_code}: {last_uc_title}{mo.group(3)}",
                stripped
            )
            result.append(new_line + '\n')
            i += 1
            continue

        result.append(line)
        i += 1

    output_path.write_text("".join(result), encoding="utf-8")
    print(f"File scritto in: {output_path}")

if __name__ == "__main__":
    input_path = Path("chapters/3_requirements.typ")
    output_path = Path("chapters/3_requirements.typ")

    if not input_path.exists():
        print(f"Errore: file non trovato: {input_path}", file=sys.stderr)
        sys.exit(1)

    process_file(input_path, output_path)
