#import "../config/thesis-config.typ": glpl, gl, img, path
#import "../config/variables.typ": *
#pagebreak(to:"odd")

= Introduzione teorica<cap:introduzione-teorica>
#text(style: "italic", [
    In questo capitolo descrivo quali tecnologie esistono per approcciare i problemi da risolvere nel progetto, quali sono gli aspetti teorici alla base, quali strumenti sono stati scelti, e sulla base di quali criteri.
])
#v(1em)

== Criteri per scegliere le tecnologie
Come menzionato nella @cap:competenze e nella @cap:vincoli, l'azienda usa principalmente framework PHP, ma non mi ha obbligato all'aderenza a uno stack tecnologico specifico, bensì a trovare una soluzione al problema da loro posto. \
Il criterio da rispettare è quello di non utilizzare alcun OCR a pagamento, in quanto l'intero progetto verte sul trovare una soluzione evitando l'utilizzo di API a pagamento, escludendo la possibilità di scegliere alcune tecnologie simili a Mistral come AWS Textract. \
Il lavoro è stato svolto principalmente in una #gl("repository", display: "repository") separata, quindi non mi sono collegato direttamente al progetto principale ma ho lavorato in totale autonomia, e questo ha guidato molto le mie scelte concernenti le tecnologie.

== Tecnologie
Le principali tecnologie sono suddivise nelle sottosezioni che seguono.\
Fa però eccezione Python@python, che considero una tecnologia trasversale grazie alla sua versatilità e alla possibilità di essere utilizzato sia lato frontend sia lato backend attraverso le librerie disponibili. \
Per la realizzazione degli algoritmi, l'organizzazione delle idee e, più in generale, per rendere più rapido lo sviluppo e il testing dei DDT messi a disposizione dall'azienda, ho scelto di utilizzarlo, anche grazie alla mia esperienza pregressa con questa tecnologia. \
Segue la suddivisione delle tecnologie in base al loro utilizzo.

#img(
    "technologies/python.png",
    caption: [Logo Python],
    alt: "",
    width: 15%
)

=== Frontend

Per la struttura e la presentazione dell'interfaccia web, le alternative che ho considerato sono HTML@html con CSS@css e JavaScript@javascript, Tailwind CSS@tailwind, Streamlit@streamlit, Blade@blade e Qt@qt. \
HTML e CSS rappresentano la scelta naturale per la costruzione dell'interfaccia: HTML descrive la struttura della pagina, mentre CSS ne gestisce la presentazione. \
Tailwind CSS è stato invece escluso in quanto, pur semplificando la scrittura degli stili tramite classi predefinite, avrebbe reso più difficile mantenere un foglio di stile esterno, il quale è più adatto al contesto dato che permette di mantenere gli stili separati dalla struttura e più facilmente manutenibili. Inoltre, evitarlo permette di non aggiungere dipendenze inutili, non avendo come priorità la costruzione di una UI complessa. \
Streamlit è una libreria Python che permette di creare interfacce web con pochissime righe di codice, ma ho deciso di scartarla in quanto viola i principi di accessibilità impedendo l'uso diretto dei tag HTML e la creazione di gerarchie di intestazioni corrette. \
Blade, il template engine nativo di Laravel, avrebbe introdotto una dipendenza da Laravel non giustificata, dato che il frontend è già coperto da HTML e CSS. \
Qt è una libreria che permette di creare applicazioni desktop, ma richiede un display server (X11 o Wayland) per il rendering dell'interfaccia grafica, assente nei container Docker standard. Sebbene esistano workaround tramite esposizione del socket X11 dell'host, la soluzione risulta dipendente dall'ambiente e non portabile, violando il vincolo relativo all'uso di Docker. \
Per quanto riguarda la logica lato client, JavaScript è la prima scelta per qualsiasi applicazione web che necessiti di interattività. \
È stato utilizzato nella sua forma vanilla, senza alcun framework aggiuntivo, in quanto la parte JavaScript dell'applicazione è limitata alla modellazione di figure per indicare la posizione dei campi nei DDT e ad alcune chiamate API, non richiedendo strutture più complesse.

#figure(
    caption: [Loghi tecnologie frontend],
    stack(
        dir: ttb,
        spacing: 1em,
        grid(
            columns: 2,
            align: center + horizon,
            column-gutter: 3em,
            box(image(path + "technologies/html_css_js.png", width: 60%, alt: "")),
            box(image(path + "technologies/tailwind.png", width: 40%, alt: "")),
        ),
        grid(
            columns: 3,
            align: center + horizon,
            column-gutter: 3em,
            box(image(path + "technologies/streamlit.png", width: 60%, alt: "")),
            box(image(path + "technologies/qt.png", width: 40%, alt: "")),
            box(image(path + "technologies/laravel.webp", width: 60%, alt: "")),
        ),
    )
)

=== Backend

Per la creazione delle API REST, le alternative considerate sono Flask@flask e FastAPI@fastapi.\
Flask è un microframework Python che adotta un approccio minimalista: non impone strutture predefinite e lascia allo sviluppatore la libertà di aggiungere solo i componenti necessari, rendendolo ideale per progetti dove la semplicità e la rapidità di sviluppo sono prioritarie.\
FastAPI offre funzionalità aggiuntive come la validazione automatica dei dati e una tipizzazione forte tramite type hints, caratteristiche utili per API esposte a traffico elevato o a terzi.\
Tuttavia, le API realizzate in questo progetto hanno una struttura semplice e non richiedono validazione complessa dei dati in ingresso, rendendo queste funzionalità superflue rispetto alla semplicità e alla velocità di configurazione offerta da Flask, motivazione per cui è stato scelto quest'ultimo.

#figure(
    caption: [Loghi tecnologie backend],
    stack(
        dir: ttb,
        spacing: 1em,
        grid(
            columns: 2,
            align: center + horizon,
            column-gutter: 3em,
            box(image(path + "technologies/flask.svg", width: 60%, alt: "")),
            box(image(path + "technologies/fastapi.webp", width: 60%, alt: "")),
        ),
    )
)

=== Deployment

Per il #gl("deployment", display: "deployment") dell'applicazione, Docker è stato selezionato come scelta obbligata in virtù del vincolo aziendale descritto nei requisiti alla @cap:requirements-list, che ne richiede esplicitamente l'utilizzo. \
Alternative come Podman@podman o Kubernetes@kubernetes non sono state prese in considerazione proprio per questo motivo. \
Docker rappresenta comunque la soluzione più adatta al contesto, in quanto è una piattaforma che permette di sviluppare e distribuire applicazioni in modo rapido e facilmente configurabile, gestendo l'infrastruttura nello stesso modo in cui viene gestita l'applicazione, riducendo il divario fra l'ambiente di sviluppo e quello di produzione.

#img(
    "technologies/docker.png",
    caption: [Logo Docker],
    alt: "",
    width: 25%
)

=== Librerie di supporto<cap:librerie-supporto>

Diverse librerie svolgono funzioni specifiche e di supporto alla pipeline.

Pillow@pillow è la libreria Python standard per la manipolazione delle immagini. È utilizzata in tutto il progetto per aprire, convertire e modificare le pagine dei DDT durante le fasi di preprocessing e OCR.

NumPy@numpy è la libreria fondamentale per il calcolo numerico in Python. Viene impiegata per la gestione degli array di pixel nelle fasi di elaborazione delle immagini, interfacciandosi con i motori OCR e con OpenCV.

pdf2image@pdf2image è una libreria che converte le pagine di un PDF in immagini raster. È utilizzata per rendere i documenti elaborabili dai motori OCR e per la visualizzazione nell'interfaccia web al momento della creazione di un template.

img2pdf@img2pdf è una libreria che converte immagini PNG o JPEG in un file PDF senza perdita di qualità, riassemblando le pagine elaborate nella fase di deskew e rimozione dei barcode.

pdftotext e pdfinfo sono strumenti a riga di comando parte della suite Poppler@poppler, invocati tramite subprocess. pdftotext estrae il testo nativo di un PDF con le coordinate di ogni parola (modalità `-bbox`), permettendo di evitare l'estrazione solo tramite OCR sui documenti digitali; pdfinfo restituisce invece i metadati del file, tra cui il numero di pagine.

OpenCV@opencv è una libreria di computer vision e image processing. Nel progetto svolge due ruoli distinti: il rilevamento e la rimozione di QR code e la segmentazione delle parole per riga tramite proiezione verticale dell'istogramma dei pixel nei wrapper del motore PaddleOCR.

pyzbar@pyzbar è una libreria Python per rilevare e decodificare barcode monodimensionali e QR code nelle immagini. Viene utilizzata in combinazione con OpenCV nella fase di rimozione dei codici a barre prima dell'OCR.

deskew e scikit-image@scikit-image sono due librerie utilizzate per il raddrizzamento automatico delle pagine. deskew calcola l'angolo di inclinazione di un'immagine in scala di grigi, mentre scikit-image fornisce la funzione di rotazione che corregge l'immagine conservando le dimensioni originali.

=== OCR<cap:ocr>

Le tecnologie OCR prese in considerazione sono PaddleOCR@paddleocr, Surya@surya, EasyOCR@easyocr, OCRmyPDF@ocrmypdf, Tesseract-OCR@tesseract e DocTR@doctr.

PaddleOCR è una libreria sviluppata da Baidu, basata su reti neurali, che offre elevata accuratezza su documenti strutturati. Tuttavia, la sua configurazione risulta complessa e l'inferenza su CPU è particolarmente lenta, rendendola poco adatta a contesti senza accelerazione hardware dedicata.

Surya è una libreria moderna basata su modelli transformer, progettata per il riconoscimento di testo in documenti multi-lingua e multi-colonna. Come PaddleOCR, soffre di tempi di elaborazione elevati in assenza di GPU, e la sua integrazione richiede una gestione non banale delle dipendenze.

EasyOCR è una libreria Python basata su deep learning che supporta oltre 80 lingue, offrendo un'API semplice e diretta pur mantenendo una buona accuratezza su documenti stampati.

OCRmyPDF è uno strumento che aggiunge un layer di testo ricercabile a PDF scansionati, basandosi internamente su Tesseract. Dispone inoltre di una funzionalità di deskewing automatico, ovvero la correzione dell'inclinazione di documenti acquisiti con una leggera rotazione.

Tesseract-OCR è il motore OCR open source più diffuso, originariamente sviluppato da HP e attualmente mantenuto da Google, con supporto a numerose lingue e buona accuratezza su testo stampato pulito. Nel progetto non viene utilizzato come OCR ma per una funzione accessoria: il rilevamento dell'orientamento della pagina tramite OSD (Orientation and Script Detection), che permette di correggere rotazioni di 90° o 270° prima del preprocessing.

DocTR (Document Text Recognition) è una libreria sviluppata da Mindee, basata su architetture transformer e reti convoluzionali, progettata specificamente per il riconoscimento di testo in documenti. Offre una pipeline integrata che include rilevamento delle righe di testo ed estrazione delle parole con le rispettive coordinate normalizzate. È la tecnologia OCR scelta per il progetto: rispetto alle alternative, offre un buon equilibrio tra accuratezza su documenti stampati e restituisce direttamente le coordinate di ogni parola in un sistema normalizzato, compatibile con la struttura del motore di estrazione sviluppato.

Surya, EasyOCR, Tesseract-OCR e DocTR restituiscono le coordinate di ogni elemento di testo rilevato sotto forma di bounding box, un requisito chiave per l'approccio di estrazione adottato, basato sulla posizione spaziale delle parole nel documento.\
OCRmyPDF costituisce un caso particolare: per sua natura di strumento orientato alla produzione del PDF finale, utilizza internamente le coordinate prodotte da Tesseract per costruire il layer di testo, senza tuttavia esporle direttamente.\
Per i PDF nativi, le coordinate sono invece ricavate tramite pdftotext in modalità `-bbox`, come descritto nella @cap:librerie-supporto, evitando il ricorso all'OCR.

=== Gestore dell'ambiente virtuale

Per la gestione dell'ambiente virtuale Python è stato scelto uv@uv, in sostituzione del classico approccio tramite `python -m venv .venv` seguito da `pip install`.\
uv è un package manager e resolver per Python scritto in Rust, progettato per essere un sostituto diretto di pip e venv con prestazioni nettamente superiori: la risoluzione e l'installazione delle dipendenze avviene in tempi significativamente ridotti rispetto agli strumenti standard, grazie a un meccanismo di caching e alla parallelizzazione delle operazioni.\
L'interfaccia rimane volutamente simile a quella di pip, rendendo la migrazione immediata: i pacchetti vengono installati tramite `uv pip install`, mantenendo la stessa sintassi già nota.

=== Analisi statica

Per l'analisi statica del codice è stato scelto mypy@mypy in modalità strict, grazie alla conoscenza pregressa dello strumento.\
La modalità strict abilita il controllo più rigoroso dei type hint, rendendo obbligatoria l'annotazione di tutti i parametri e i valori di ritorno delle funzioni.\
Questo approccio garantisce una maggiore robustezza del codice e facilita il rilevamento precoce di errori di tipo durante lo sviluppo, prima ancora dell'esecuzione.