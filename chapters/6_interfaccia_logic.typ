#import "../config/variables.typ": *
#import "../config/thesis-config.typ": gl, glpl, img, path
#pagebreak(to: "odd")

= Realizzazione del sistema di estrazione basato su coordinate spaziali<cap:interfaccia>

#text(style: "italic")[
  Questo capitolo descrive l'approccio utilizzato al momento della conclusione del progetto, basato sulle coordinate spaziali del testo all'interno dei documenti. Inoltre descrive i test di regressione utilizzati per tenere traccia della bontà dello svolgimento del progetto.
]

== Creazione interfaccia grafica
La scelta di OCR e pdftotext come motori di estrazione è stata guidata da un requisito preciso: entrambi supportano la modalità bounding box, come descritto nella @cap:introduzione-teorica.\   
Sfruttare questa caratteristica ha reso necessario definire un metodo per associare a ogni template una posizione probabile dei campi da estrarre.\
L'interfaccia grafica è stata sviluppata per rispondere a due esigenze principali:
+ Estrarre i dati di un DDT specifico e visualizzarne i risultati attraverso un'interfaccia dedicata, anziché tramite terminale, soddisfacendo i casi d'uso di visualizzazione descritti nella @cap:analisi-requisiti;
+ Creare il template di un determinato layout associato ad un determinato fornitore.
Alla @fig:estrazione-ddt e alla @fig:costruzione-template sono disponibili le immagini d'esempio dell'interfaccia, rispettivamente per l'estrazione dei risultati di un DDT e per la creazione di un template.

#img(
  "example/estrazione-ddt.png",
  caption: [Interfaccia per l'estrazione di un DDT.],
  alt: "L'immagine rappresenta l'interfaccia per l'estrazione di un DDT. Dà la possibilità di caricare un PDF, selezionare il template e premere il pulsante per l'estrazione. È visibile la parte in cui verrà mostrato il risultato.",
)<fig:estrazione-ddt>

#img(
  "example/costruzione-template.png",
  caption: [Interfaccia iniziale per la costruzione di un template.],
  alt: "L'immagine rappresenta l'inizio dell'interfaccia per costruire un template. In essa sono compresi tutti i casi d'uso principali descritti nell'Analisi dei Requisiti relativi alla costruzione del template.",
)<fig:costruzione-template>

Per l'utilizzo e la condivisione del progetto, è stato costruito un Dockerfile, la cui versione finale è disponibile nel @cod:Dockerfile.

#figure(caption: "Dockerfile per la containerizzazione del progetto.")[
  #show raw: set text(size: 0.85em)
  ```Dockerfile
  FROM python:3.12-slim

  # Installa dipendenze di sistema per OCR e PDF
  RUN apt-get update && apt-get install -y --no-install-recommends \
      poppler-utils \
      tesseract-ocr \
      tesseract-ocr-ita \
      ocrmypdf \
      && rm -rf /var/lib/apt/lists/*

  # Copia SOLO i requirements e installa le dipendenze Python
  WORKDIR /app
  COPY requirements.txt .
  RUN pip install --no-cache-dir -r requirements.txt

  # Copia TUTTO il codice (i moduli verranno montati come volume per hot‑reload)
  COPY . .

  # Crea cartelle necessarie
  RUN mkdir -p template_json examples/Esempi_DB examples/results/json examples/results/txt

  EXPOSE 5000

  # Comando di avvio: Flask in debug con percorso template_json
  CMD ["flask", "run", "--host=0.0.0.0", "--port=5000", "--debug"]
  ```
]<cod:Dockerfile>

Una volta definita la containerizzazione del progetto, l'attenzione si è spostata sulla componente più complessa dell'interfaccia: la creazione dei template.

=== Interfaccia grafica per la creazione del template
Mentre l'interfaccia per l'estrazione richiede solamente di scegliere il PDF, il fornitore associato e di premere il pulsante di estrazione per ottenere i risultati, l'interfaccia per la costruzione del template è molto più complessa.\
Alla @fig:esempio-template è disponibile un esempio di un template per il corpo del documento, non rendo disponibile la completa visualizzazione per ragioni di riservatezza aziendale.\
L'interfaccia richiede che venga disegnato per ogni campo un rettangolo, infatti nell'esempio sono disegnati i rettangoli "Intestazione colonne", "Primo codice", "Prima descrizione", "Prima unità" e "Prima quantità".

#img(
  "example/esempio-template.png",
  caption: [Esempio corpo template.],
  alt: "",
)<fig:esempio-template>

Per quanto la creazione di un template sia, soprattutto per le prime volte, molto laboriosa e lunga (nel peggiore dei casi sono da inserire 23 rettangoli oltre ad altre indicazioni utili) questo permette di avere un template solido disponibile per ogni PDF successivo.\
Tuttavia, la sola costruzione del template non è sufficiente, per una serie di problemi:
- È necessario gestire i dati non letti correttamente dagli OCR;
- È necessario gestire i rettangoli disegnati male;
- È necessario gestire l'inclinazione dei DDT o la loro rotazione di 90 oppure 270 gradi (@cap:inclinazione);
- È necessario gestire i fornitori con diversi template (@cap:fornitori-template);
- È necessario controllare che l'estrazione di più DDT avvenga correttamente (@cap:test);
- È necessario controllare i risultati degli OCR (@cap:risultati-ocr).
Per gli errori degli OCR e quelli umani nel disegno dei rettangoli non esiste soluzione automatica.

==== Inclinazione dei DDT<cap:inclinazione>
Il problema dell'inclinazione dei DDT è stato risolto tramite un'applicazione accurata del preprocessing su ogni DDT, prima di passare il PDF processato all'OCR.\
Questa parte si compone di tre fasi principali:
+ Riconoscimento della rotazione di 90 oppure 270 gradi del PDF e corrispettiva rotazione;
+ Riconoscimento dell'inclinazione tramite deskewing, descritto nella @cap:librerie-supporto, e conseguente rotazione dei gradi necessari;
+ Applicazione dell'offset dell'ancora.

Quest'ultima è una tecnica ideata per correggere ulteriormente inclinazioni o piccoli spostamenti di template, serve per riposizionare i rettangoli disegnati nel template nella posizione di cui ci si aspetta comparirà nel nuovo caso.\
Infatti, nel caso in cui il template sia rimasto identico, ma il PDF caricato presenti uno spostamento di alcuni pixel verso destra rispetto all'esempio originale, la posizione precedente dei rettangoli impedisce la corretta estrazione dei campi.\
Questo metodo invece trova la parola scelta come ancora, e corregge, rispetto alla precedente posizione indicata dal rettangolo dell'ancora, tutti i rettangoli in modo da allineare al nuovo DDT caricato.\
Nel @cod:anchor-offset e @cod:anchor-rects sono mostrate le funzioni che calcolano l'offset rispetto all'ancora e lo applicano in ogni rettangolo.

#figure(caption: "Calcolo dell'offset rispetto all'ancora.")[
  #show raw: set text(size: 0.85em)
  ```py
  def apply_anchor_offset(
      parser: TemplateBasedParser,
      ocr_page1: list[Word],
  ) -> tuple[float, float]:
      """Calcola l'offset rispetto all'ancora"""
      ancora: AnchorConfig = parser.require_template()["ancora"]
      if not ancora.get("parola"):
          return 0.0, 0.0

      x_expected: float = (ancora["xmin"] + ancora["xmax"]) / 2
      y_expected: float = (ancora["ymin"] + ancora["ymax"]) / 2

      x_found, y_found = parser.find_anchor(ocr_page1)
      if x_found is None or y_found is None:
          return 0.0, 0.0

      dx: float = x_found - x_expected
      dy: float = y_found - y_expected
      parser.apply_offset_rects(dx, dy)
      return dx, dy
  ```
]<cod:anchor-offset>

#figure(caption: "Applicazione dell'offset ai rettangoli.")[
  #show raw: set text(size: 0.85em)
  ```py
  def translate_obj(obj: Any, dx: float, dy: float) -> None:
      """Applica ricorsivamente un offset (dx, dy) a tutte le coordinate rettangolari (xmin/xmax, ymin/ymax, y_start/y_end, x_start, riga_1_top) presenti in una struttura dati annidata"""
      if isinstance(obj, dict):
          if "xmin" in obj:
              obj["xmin"] += dx
              obj["xmax"] += dx
          if "ymin" in obj:
              obj["ymin"] += dy
              obj["ymax"] += dy
          if "y_start" in obj:
              obj["y_start"] += dy
          if "y_end" in obj:
              obj["y_end"] += dy
          if "x_start" in obj:
              obj["x_start"] += dx
          if obj.get("riga_1_top") is not None:
              obj["riga_1_top"] += dy
          for v in obj.values():
              translate_obj(v, dx, dy)
      elif isinstance(obj, list):
          for item in obj:
              translate_obj(item, dx, dy)
  ```
]<cod:anchor-rects>

==== Fornitori con diversi template<cap:fornitori-template>
Non tutti i fornitori usano lo stesso template, ma alcuni ne utilizzano più di uno, e il problema era scegliere, per ogni DDT, quale template utilizzare.\
Questa scelta segue questa fase:
+ Se è disponibile un solo template, viene scelto quello, altrimenti viene selezionato il migliore fra quelli disponibili;
+ Per scegliere il migliore fra quello disponibile, viene scelto il template la cui ancora è più vicina al rettangolo definito in sede di creazione del template.
Per questo la scelta dell'ancora è fondamentale.\
È importante usare, se disponibili, parole mai utilizzate, in modo che l'algoritmo riconosca che il template con un'ancora non trovata è impossibile che sia il template corretto.\
Il codice è disponibile nel @cod:best-template.

#figure(caption: "Selezione del miglior template tra le varianti.")[
  #show raw: set text(size: 0.85em)
  ```py
  def select_best_template(
      templates_dir: str,
      variants: list[str],
      ocr_words_by_page: list[list[Word]],
  ) -> tuple[str, TemplateBasedParser] | None:
      if not variants:
          return None
      if len(variants) == 1:
          return _load_single_variant(variants[0], templates_dir, ocr_words_by_page[0])
      return _evaluate_variants(variants, templates_dir, ocr_words_by_page[0])


  def _load_single_variant(
      variant_name: str,
      templates_dir: str,
      ocr_page1: list[Word],
  ) -> tuple[str, TemplateBasedParser]:
      parser: TemplateBasedParser = TemplateBasedParser()
      parser.assign_template(os.path.join(templates_dir, f"{variant_name}.json"))
      apply_anchor_offset(parser, ocr_page1)
      return variant_name, parser


  def _evaluate_variants(
      variants: list[str],
      templates_dir: str,
      ocr_page1: list[Word],
  ) -> tuple[str, TemplateBasedParser] | None:
      best_distance: float = float("inf")
      best_name: str | None = None
      best_parser: TemplateBasedParser = TemplateBasedParser()

      for variant_name in variants:
          result: TemplateCandidate | None = _score_variant(variant_name, templates_dir, ocr_page1)
          if result is None:
              continue
          if result["distance"] < best_distance:
              best_distance = result["distance"]
              best_name = result["name"]
              best_parser.assign_template(os.path.join(templates_dir, f"{variant_name}.json"))

      if best_name is None:
          return None

      apply_anchor_offset(best_parser, ocr_page1)
      return best_name, best_parser


  def _score_variant(
      variant_name: str,
      templates_dir: str,
      ocr_page1: list[Word],
  ) -> TemplateCandidate | None:
      try:
          parser: TemplateBasedParser = TemplateBasedParser()
          parser.assign_template(os.path.join(templates_dir, f"{variant_name}.json"))
          ancora: AnchorConfig = parser.require_template()["ancora"]

          if not ancora.get("parola"):
              return None

          x_expected: float = (ancora["xmin"] + ancora["xmax"]) / 2
          y_expected: float = (ancora["ymin"] + ancora["ymax"]) / 2

          x_found, y_found = parser.find_anchor(ocr_page1)
          if x_found is None or y_found is None:
              return None

          distance: float = ((x_found - x_expected) ** 2 + (y_found - y_expected) ** 2) ** 0.5
          return TemplateCandidate(name=variant_name, distance=distance)

      except Exception:
          return None
  ```
]<cod:best-template>

==== Test di regressione<cap:test>
Per gestire il problema di verificare che i template (o il template) del fornitore siano disegnati bene, ho ideato dei test di regressione, i quali avviano, sfruttando il multi-threading, l'estrazione di più DDT, permettendomi di visualizzare i risultati di estrazione degli articoli sinteticamente.\
Siccome era impossibile, per disponibilità di tempo, hardcodare i risultati corretti per tutti gli esempi disponibili, ho optato per un metodo più rapido.\
Per ogni PDF viene indicato in un file JSON il numero di articoli attesi: lo script verifica questo valore e considera l'estrazione corretta se il numero di articoli estratti corrisponde alle aspettative.\
Questo ha permesso di velocizzare notevolmente il ciclo di controllo, tuttavia rimane necessaria una verifica manuale a campione per ogni fornitore per controllare la correttezza dei dati estratti.\
Nel @cod:run-test è disponibile il codice che usavo per i test.

#figure(caption: "Esecuzione dei test di regressione in parallelo.")[
  #show raw: set text(size: 0.85em)
  ```py
  def _run_all_tests(
      tasks: list[tuple[str, int, str, str, str, int, int]],
      fornitore_stats: dict[str, SupplierStats],
      failed_keys_list: list[str],
  ) -> None:
      """Esegue tutti i test in parallelo e aggiorna le statistiche"""
      max_workers: int = min(4, len(tasks))
      with ThreadPoolExecutor(max_workers=max_workers) as executor:
          futures = {executor.submit(run_test_case, *task): task for task in tasks}
          for future in as_completed(futures):
              res: TestResult = future.result()
              print_result(res)
              with stats_lock:
                  update_stats(fornitore_stats, res)
              if not res["ok"]:
                  with failed_keys_lock:
                      failed_keys_list.append(res["key"])
  ```
]<cod:run-test>

==== Risultati dell'OCR<cap:risultati-ocr>
Per quanto i risultati dell'OCR non dipendessero direttamente dal mio lavoro, era necessario individuare un metodo per limitare il più possibile gli errori, soprattutto nei PDF digitali.\
Per ovviare a questo problema, ho sfruttato la tecnologia pdftotext, la quale estrae direttamente il testo nativo disponibile sul PDF.\
Siccome molti PDF presentavano testo nativo solo parzialmente, o ne erano del tutto privi, non era possibile affidarsi esclusivamente all'estrazione tramite testo nativo.\
Tuttavia, nelle situazioni in cui questo veniva estratto, il testo nativo è molto più affidabile dei risultati di un OCR e avevo bisogno di un metodo per preferirlo rispetto all'OCR.\
Per questo ho ideato il codice, disponibile nel @cod:merge-rects, che permette di unificare i risultati trovati dall'OCR e dal testo nativo, prediligendo quest'ultimo ove presente.

#figure(caption: "Unificazione dei risultati del testo nativo e dell'OCR.")[
  #show raw: set text(size: 0.85em)
  ```py
  def merge_rects(
      rects: list[Rect],
      native_words: list[Word],
      ocr_words: list[Word],
  ) -> list[Word]:
      """Unisce parole native e OCR all'interno dei rettangoli indicati. Le parole native hanno precedenza; le parole OCR vengono aggiunte solo se non già presenti. Restituisce la lista ordinata per (ymin, xmin)"""
      selected: list[Word] = []
      used_keys: set[str]  = set()

      _add_words_in_rects(rects, native_words, selected, used_keys)
      _add_words_in_rects(rects, ocr_words, selected, used_keys)
      _add_remaining_native(native_words, selected, used_keys)

      selected.sort(key=lambda w: (w["ymin"], w["xmin"]))
      return selected


  def _add_words_in_rects(
      rects: list[Rect],
      words: list[Word],
      output: list[Word],
      used_keys: set[str],
  ) -> None:
      """Aggiunge a output le parole che ricadono in almeno uno dei rettangoli, saltando i duplicati già presenti in used_keys"""
      for rect in rects:
          xmin = rect["xmin"]
          xmax = rect["xmax"]
          ymin = rect["ymin"]
          ymax = rect["ymax"]
          for w in words:
              if words_in_rect(xmin, xmax, ymin, ymax, [w]):
                  key: str = _word_key(w)
                  if key not in used_keys:
                      output.append(w)
                      used_keys.add(key)


  def _add_remaining_native(
      native_words: list[Word],
      output: list[Word],
      used_keys: set[str],
  ) -> None:
      """Aggiunge le parole native che non erano all'interno di nessun rettangolo"""
      for w in native_words:
          key: str = _word_key(w)
          if key not in used_keys:
              output.append(w)
              used_keys.add(key)
  ```
]<cod:merge-rects>

Un altro problema importante da risolvere era comprendere se l'estrazione errata degli articoli dipendesse dalla struttura della soluzione che avevo implementato oppure dall'OCR.\
Per fare questo ho ideato due passaggi:
+ Scrittura di un file .txt il quale associa ad ogni parola le coordinate `xmin, xmax, ymin, ymax` e la fonte di estrazione `source` (codice disponibile nel @cod:write-txt);
+ Visualizzazione grafica rispetto al PDF dei rettangoli (codice disponibile nel @cod:html-rects).

Questo approccio permette di verificare nell'immediato l'attribuzione della colpa per un'estrazione errata verificata dall'esecuzione dei test.

#figure(caption: "Scrittura delle coordinate delle parole in formato testuale.")[
  #show raw: set text(size: 0.85em)
  ```py
  def _write_txt(txt_dir: Path, base_name: str, all_words: list[Word]) -> None:
      """Salva il file TXT con le coordinate di tutte le parole estratte"""
      coord_text: str = words_to_coord_text(remove_duplicates(all_words))
      txt_path: Path = txt_dir / f"{base_name}.txt"
      with open(txt_path, "w", encoding="utf-8") as f:
          f.write(coord_text)

  def words_to_coord_text(words: list[Word]) -> str:
      """Converte una lista di parole in testo formattato con coordinate, raggruppando le parole per riga (tolleranza ymin) e ordinandole per xmin. Formato di ogni token: testo(xmin,xmax,ymin,ymax,source)"""
      lines: list[list[Word]] = _group_words_into_lines(words)
      return _render_lines_to_text(lines)


  def _group_words_into_lines(words: list[Word]) -> list[list[Word]]:
      """Raggruppa le parole in righe in base alla prossimità verticale (ymin)"""
      lines: list[list[Word]] = []
      for w in words:
          placed: bool = False
          for line in lines:
              if abs(w["ymin"] - line[0]["ymin"]) <= _LINE_Y_TOLERANCE:
                  line.append(w)
                  placed = True
                  break
          if not placed:
              lines.append([w])
      lines.sort(key=lambda single_line: single_line[0]["ymin"])
      for line in lines:
          line.sort(key=lambda word: word["xmin"])
      return lines
  ```
]<cod:write-txt>

#figure(caption: "Generazione della visualizzazione HTML dei rettangoli.")[
  #show raw: set text(size: 0.85em)
  ```py
  def make_html(
      img: Image.Image,
      page_words: list[Word],
      y_offset: int,
      page_num: int,
      base_name: str,
  ) -> str:
      img_b64 = img_to_base64(img)

      rects_svg: list[str] = []
      for w in page_words:
          x1: float = w['xmin'] / 250 * 100
          y1: float = (w['ymin'] - y_offset) / 1000 * 100
          x2: float = w['xmax'] / 250 * 100
          y2: float = (w['ymax'] - y_offset) / 1000 * 100
          rw: float = x2 - x1
          rh: float = y2 - y1

          # Colore in base alla fonte
          if w.get('source') == 'native':
              fill = "rgba(0,255,0,0.10)"
              stroke = "green"
          else:
              fill = "rgba(255,0,0,0.10)"
              stroke = "red"

          tooltip: str = (
              f"{html_module.escape(w['text'])} [{w.get('source', '?')}] "
              f"| x:{w['xmin']}-{w['xmax']} y:{w['ymin']}-{w['ymax']}"
          )
          rects_svg.append(
              f'<rect x="{x1:.3f}%" y="{y1:.3f}%" width="{rw:.3f}%" height="{rh:.3f}%"'
              f' fill="{fill}" stroke="{stroke}" stroke-width="0.15%">'
              f'<title>{tooltip}</title></rect>'
          )

      rects_html: str = '\n'.join(rects_svg)

      return f"""<!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8">
    <title>{base_name} - Pagina {page_num}</title>
    <style>
      body {{ margin: 0; background: #333; display: flex; justify-content: center; padding: 20px; }}
      .container {{ position: relative; width: 900px; }}
      .container img {{ width: 100%; display: block; }}
      .container svg {{ position: absolute; top: 0; left: 0; width: 100%; height: 100%; }}
      rect {{ cursor: crosshair; }}
      rect:hover {{ fill: rgba(255,200,0,0.4); stroke: orange; }}
    </style>
  </head>
  <body>
    <div class="container">
      <img src="data:image/png;base64,{img_b64}">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none">
        {rects_html}
      </svg>
    </div>
  </body>
  </html>"""
  ```
]<cod:html-rects>


== Logica per l'estrazione dei campi
Una volta definito il template completo di un fornitore, si carica un PDF, si sceglie il fornitore adeguato e si visualizzano i risultati dell'estrazione.\
Come descritto nelle sezioni precedenti, viene effettuato il preprocessing del PDF, scelto il miglior template ed utilizzato per l'estrazione dei dati.\
Ogni template è composto da tre parti principali, le quali sono suddivise in ulteriori campi:
+ Intestazione:
  - Ancora;
  - DDT Numero;
  - DDT Data;
  - Ragione sociale, indirizzo e partita IVA fornitore;
  - Ragione sociale, indirizzo e partita IVA destinatario;
+ Corpo:
  - Riga campione;
  - Primo codice;
  - Prima descrizione;
  - Prima unità;
  - Prima quantità;
  - Primo riferimento codice ordine;
  - Intestazione colonne;
+ Appendice:
  - Numero colli;
  - Peso lordo;
  - Peso netto;
  - Note.

Il primo approccio che il mio algoritmo realizza, descritto nel @cod:words-in-rect, è trovare le parole che si trovano nel rettangolo disegnato e corretto dall'ancora.\
Per alcuni campi, come il numero del DDT, non esiste una regex precisa poiché il formato varia da fornitore a fornitore: in questi casi il valore viene estratto direttamente dalle parole trovate all'interno del rettangolo corrispondente.

#figure(caption: "Riconoscimento delle parole all'interno del rettangolo.")[
  #show raw: set text(size: 0.85em)
  ```py
  def words_in_rect(
      xmin: float,
      xmax: float,
      ymin: float,
      ymax: float,
      words: list[Word],
  ) -> list[Word]:
      """Restituisce le parole che si sovrappongono al rettangolo dato. Utilizza una tolleranza e un overlap predefinito"""
      found: list[Word] = []
      for w in words:
          overlap_x: float = (
              min(w["xmax"], xmax + TOLERANCE) - max(w["xmin"], xmin - TOLERANCE)
          )
          overlap_y: float = (
              min(w["ymax"], ymax + TOLERANCE) - max(w["ymin"], ymin - TOLERANCE)
          )
          if overlap_x <= 0 or overlap_y <= 0:
              continue
          word_w: float = w["xmax"] - w["xmin"]
          if word_w > 0 and (overlap_x / word_w) >= MIN_OVERLAP_RATIO:
              found.append(w)
      return found
  ```
]<cod:words-in-rect>

Tuttavia, alcuni campi hanno una regex che permette un controllo più sicuro per gestire meglio la correttezza dei dati estratti.
Questi campi sono:
- Data DDT: formati come dd/mm/yyyy, dd-mm-yyyy o ddmmyyyy (pattern \d{2}[/-]?\d{2}[/-]?\d{4});
- Numero colli: valore numerico intero (pattern \d+);
- Peso lordo e peso netto: valore numerico con eventuale parte decimale (pattern \d+([.,]\d+)?).

Inoltre, è stata ideata la configurazione delle parole chiave, un metodo per far conoscere all'algoritmo che un campo si trova sicuramente dopo una determinata parola.\
Le parole chiave vengono utilizzate per i seguenti campi:
- Codice;
- Descrizione;
- Unità;
- Quantità;
- Riferimento codice ordine.

Ad esempio, se si è a conoscenza del fatto che ad ogni articolo è associato un riferimento ad un codice ordine, e questo riferimento è definito dopo la scritta "Rif. Cod. Ord", si possono configurare queste ultime come parole chiave, istruendo l'algoritmo a considerare la parola solo se segue quelle indicate.\
Inoltre, è possibile specificare il tipo di quel preciso campo (tutta la riga, primo numero, prima sequenza alfanumerica).\
Il codice di estrazione tramite parola chiave è disponibile nel @cod:catch-after-keyword.

#figure(caption: "Estrazione del valore dopo una parola chiave.")[
  #show raw: set text(size: 0.85em)
```py
def catch_after_keyword(
    testo: str,
    parola_chiave: str,
    regex_cattura: str | None = None,
) -> str:
    """Estrae il testo che segue la parola chiave. Se regex_cattura è fornita, applica la regex al testo restante"""
    if not testo:
        return ""
    if not parola_chiave:
        return testo

    idx: int = testo.lower().find(parola_chiave.lower())
    if idx == -1:
        return ""
    resto: str = testo[idx + len(parola_chiave):].strip()
    if not resto:
        return ""
    if regex_cattura:
        m: re.Match[str] | None = re.search(regex_cattura, resto)
        if m:
            return m.group(1) if m.lastindex else m.group(0)
        return resto
    return resto.split()[0] if resto else resto
```
]<cod:catch-after-keyword>

Nel complesso, per facilitare la lettura dei file txt, è stato adottato un sistema di normalizzazione che fissa larghezza e altezza rispettivamente a 250 e 1000 unità.\
La funzionalità di debug visivo descritta nella @cap:risultati-ocr, introdotta nella seconda metà del progetto, si appoggia a questo sistema per posizionare correttamente i rettangoli sovrapposti al PDF.\
Ad esempio, se una parola si trova alla coordinata 125 di altezza della seconda pagina, nel txt viene segnata con coordinata 1125, evitando così sovrapposizioni di parole diverse di pagine diverse.\
Mentre l'estrazione dei campi dell'intestazione e dell'appendice è stata descritta nelle sezioni precedenti, la parte più complessa riguarda l'estrazione corretta degli articoli, poiché in alcuni casi la struttura è semplice e lineare, in altri la logica di estrazione risulta considerevolmente più articolata.\
In quelli a linea singola, ogni articolo è disposto come nella @table:example-corretto, dove ad ogni riga corrisponde un pezzo per ogni campo, in quelli multilinea ogni articolo è disposto come ad esempio nella @table:example-multiriga.

#figure(caption: "Esempio di disposizione a linea singola.")[
#table(
    columns: (auto, auto, auto, auto),
    table.header([Codice], [Descrizione], [Unità], [Quantità]),
    [XY], [ZY], [NR], [2],
    [YX], [YZ], [NR], [5],
)
]<table:example-corretto>

#figure(caption: "Esempio di disposizione multiriga.")[
#table(
    columns: (auto, auto, auto, auto),
    table.header([Codice], [Descrizione], [Unità], [Quantità]),
    [XY], [ZY], [NR], [2],
    table.cell(rowspan:2)[YX\ Z], table.cell(rowspan:2)[BB\ YZ], [], [],
    [NR], [5],
)
]<table:example-multiriga>

Inizialmente, l'approccio adottato per l'estrazione degli articoli si limitava a marcare la colonna di competenza di ciascun pezzo, senza considerare eventuali sovrapposizioni tra campi adiacenti.\
Questo approccio si è però rivelato inadeguato nei casi in cui un campo legato ad una colonna occupi spazio in un'altra colonna non pertinente, ed è stato pertanto sostituito, nel corso del progetto, da una logica di raggruppamento basata sulla distanza tra i pezzi di uno stesso articolo, calcolata a partire dalla posizione della quantità.\
Per ovviare a questo problema, innanzitutto l'utente deve segnalare se la quantità si trova in alto oppure in basso rispetto all'articolo, poi, in base a quello, come descritto nel @cod:quantity, si estrae in maniera differente.

#figure(caption: "Selezione della strategia di raggruppamento in base alla posizione della quantità.")[
#show raw: set text(size: 0.85em)
```py
def _group_lines_by_quantity(
        self,
        righe: list[PhysicalLineDict],
        prima_quantita_rect: Rect,
    ) -> list[PhysicalLineDict]:
        """Raggruppa le righe fisiche in gruppi articolo in base alla quantità"""
        if not righe:
            return []

        b: BodyConfig = self._template["body"]
        qta_in_alto: bool = b["quantita_in_alto"]
        primo_codice_rect: Rect = b["primo_codice"]
        parole_riepilogo: list[str] = self._load_words_summary()

        if qta_in_alto:
            return self._group_qty_on_top(righe, prima_quantita_rect, parole_riepilogo)
        return self._group_qty_on_bottom(righe, prima_quantita_rect, primo_codice_rect, parole_riepilogo)
```
]<cod:quantity>

Il codice per estrarre gli articoli se la quantità è situata in alto è presente nel @cod:quantity-top.\
La funzione scorre le righe fisiche del corpo del documento e identifica l'inizio di un nuovo articolo ogni volta che incontra una riga contenente un valore nella colonna della quantità.\
La verifica avviene tramite la funzione `has_quantity`, la quale controlla che nella colonna della quantità sia presente almeno un valore numerico adeguato (escludendo dunque numeri come 0.5), escludendo esplicitamente le parole contenenti lettere per evitare falsi positivi causati da codici o descrizioni che debordano nella colonna.\
Le righe successive senza quantità vengono aggregate al gruppo corrente, fino alla riga successiva con quantità che segna l'inizio del nuovo articolo.\
Il processo si interrompe anticipatamente se viene incontrata una parola di riepilogo configurata dall'utente, la quale segnala la fine della sezione degli articoli.

#figure(caption: "Raggruppamento articoli con quantità in alto.")[
#show raw: set text(size: 0.85em)
```py
def _group_qty_on_top(
        self,
        righe: list[PhysicalLineDict],
        prima_quantita_rect: Rect,
        parole_riepilogo: list[str],
    ) -> list[PhysicalLineDict]:
        """Raggruppa righe quando la quantità si trova nella riga superiore dell'articolo"""
        gruppi: list[PhysicalLineDict] = []
        gruppo_corrente: PhysicalLineDict | None = None
        gruppo_ha_qty: bool = False

        for riga in righe:
            if parole_riepilogo and contains_summary(riga["words"], parole_riepilogo):
                if gruppo_corrente is not None:
                    gruppi.append(gruppo_corrente)
                return gruppi

            ha_qty: bool = has_quantity(prima_quantita_rect, riga)

            if ha_qty:
                if gruppo_corrente is not None and not gruppo_ha_qty:
                    gruppo_corrente = self._make_group(riga)
                    gruppo_ha_qty = True
                else:
                    if gruppo_corrente is not None:
                        gruppi.append(gruppo_corrente)
                    gruppo_corrente = self._make_group(riga)
                    gruppo_ha_qty = True
            else:
                if gruppo_corrente is not None:
                    gruppo_corrente["words"].extend(riga["words"])
                    gruppo_corrente["ymax"] = max(gruppo_corrente["ymax"], riga["ymax"])
                else:
                    gruppo_corrente = self._make_group(riga)
                    gruppo_ha_qty = False

        if gruppo_corrente is not None:
            gruppi.append(gruppo_corrente)
        return gruppi
```
]<cod:quantity-top>

Il codice per estrarre gli articoli se la quantità si trova in basso si trova nel @cod:quantity-bottom.\
Le righe vengono accumulate in un buffer e il gruppo viene chiuso e salvato solo quando viene incontrata una riga con quantità, che rappresenta l'ultima riga dell'articolo.\
Un nuovo buffer viene aperto quando viene rilevata una riga contenente un valore nella colonna del codice, segnalando l'inizio di un nuovo articolo.\
Anche in questo caso, l'incontro con una parola di riepilogo interrompe anticipatamente il processo.

#figure(caption: "Raggruppamento articoli con quantità in basso.")[
#show raw: set text(size: 0.85em)
```py
def _group_qty_on_bottom(
        righe: list[PhysicalLineDict],
        prima_quantita_rect: Rect,
        primo_codice_rect: Rect,
        parole_riepilogo: list[str],
    ) -> list[PhysicalLineDict]:
        """Raggruppa righe quando la quantità si trova nell'ultima riga dell'articolo"""
        gruppi: list[PhysicalLineDict] = []
        buffer: list[PhysicalLineDict] = []
        buffer_has_qty: bool = False

        for riga in righe:
            ha_qty: bool = has_quantity(prima_quantita_rect, riga)

            if parole_riepilogo and contains_summary(riga["words"], parole_riepilogo):
                if buffer_has_qty:
                    gruppi.append(merge_buffer(buffer))
                elif ha_qty:
                    gruppi.append(riga)
                return gruppi

            if has_code(primo_codice_rect, riga) and buffer:
                if buffer_has_qty:
                    gruppi.append(merge_buffer(buffer))
                buffer = []
                buffer_has_qty = False

            buffer.append(riga)
            buffer_has_qty = buffer_has_qty or ha_qty

            if ha_qty:
                gruppi.append(merge_buffer(buffer))
                buffer = []
                buffer_has_qty = False

        if buffer and buffer_has_qty:
            gruppi.append(merge_buffer(buffer))
        return gruppi
```
]<cod:quantity-bottom>

Questo approccio, pur richiedendo un lavoro iniziale di configurazione per ogni fornitore, permette di gestire in modo robusto la grande varietà di layout presenti nei DDT reali, limitando al minimo l'intervento manuale sulle estrazioni successive.

Quanto descritto in questo capitolo ha rappresentato il nucleo operativo del progetto; i suoi esiti, insieme a un'analisi delle criticità e delle prospettive di sviluppo, sono discussi nella @cap:conclusioni.