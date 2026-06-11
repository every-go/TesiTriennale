#import "../config/thesis-config.typ": glpl, gl, img, path
#import "../config/variables.typ": *
#pagebreak(to:"odd")

= Introduzione teorica<cap:introduzione-teorica>
#text(style: "italic", [
    In questo capitolo descrivo quali tecnologie esistono per approcciare i problemi da risolvere nel progetto, quali sono gli aspetti teorici alla base, quali strumenti sono stati scelti, e sulla base di quali criteri.
])
#v(1em)

== Criteri per scegliere le tecnologie
Come menzionato nella sezione @cap:competenze e nella sezione @cap:vincoli, l'azienda usa principalmente framework PHP, ma non mi ha obbligato all'aderenza ad uno stack tecnologico specifico, ma più al trovare una soluzione al problema da loro posto. \
Il criterio da rispettare è però quello di non utilizzare alcun OCR a pagamento, in quanto l'intero progetto verte sul trovare una soluzione evitando l'utilizzo di API a pagamento, escludendomi la possibilità di scelta di alcune tecnologie simili a Mistral come AWS Extract. \
Il mio lavoro svolto è stato principalmente in una #gl("repository", display: "repository") separata, quindi non mi sono 'collegato' direttamente al progetto principale ma ho lavorato in totale autonomia, e questo ha guidato molto le mie scelte concernenti le tecnologie.

== Tecnologie possibili
Andrò a suddividere le principali tecnologie possibili in varie sottosezioni.\
Fa però eccezione Python@python, che considero una tecnologia trasversale grazie alla sua versatilità e alla possibilità di essere utilizzato sia lato frontend sia lato backend attraverso le librerie disponibili. \
Per la realizzazione degli algoritmi, l'organizzazione delle idee e, più in generale, per rendere più rapido lo sviluppo e il testing dei DDT messi a disposizione dall'azienda, ho scelto di utilizzarlo, anche grazie alla mia esperienza pregressa con questa tecnologia. \
Segue la suddivisione delle tecnologie in base al loro utilizzo.

#img(
    "technologies/python.png",
    caption: [Logo Python],
    alt: "",
    width: 15%,
    height: 15%
)

=== Frontend

Per la struttura e la presentazione dell'interfaccia web, le alternative che ho considerato sono HTML@html con CSS@css e JavaScript@javascript, Tailwind CSS@tailwind, Streamlit@streamlit, Blade@blade e Qt@qt. \
HTML e CSS rappresentano la scelta naturale per la costruzione dell'interfaccia: HTML descrive la struttura della pagina, mentre CSS ne gestisce la presentazione. \
Tailwind CSS è stato invece scartato in quanto, pur semplificando la scrittura degli stili tramite classi predefinite, avrebbe reso più difficile mantenere un foglio di stile esterno, più adatto al contesto dato che permette di mantenere gli stili separati dalla struttura e più facilmente manutenibili. Inoltre, evitarlo mi permette di non aggiungere dipendenze inutili, non avendo come priorità la costruzione di una UI complessa. \
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

Per il #gl("deployment", display: "deployment") dell'applicazione, Docker@docker è stato selezionato come scelta obbligata in virtù del vincolo aziendale descritto nei requisiti alla @cap:requirements-list, che ne richiede esplicitamente l'utilizzo. \
Alternative come Podman o Kubernetes non sono state prese in considerazione proprio per questo motivo. \
Docker rappresenta comunque la soluzione più adatta al contesto, in quanto è una piattaforma che permette di sviluppare e distribuire applicazioni in modo rapido e facilmente configurabile, gestendo l'infrastruttura nello stesso modo in cui viene gestita l'applicazione, riducendo il divario fra l'ambiente di sviluppo e quello di produzione.

#img(
    "technologies/docker.png",
    caption: [Logo Docker],
    alt: "",
    width: 25%
)

=== Supporto

OpenCV@opencv e pdf2image@pdf2image sono due librerie utilizzate a supporto del progetto, entrambe senza alternative considerate in quanto svolgono funzioni molto specifiche. \
OpenCV è una libreria di computer vision e image processing, utilizzata per riconoscere pattern relativi ai vari template DDT. \
pdf2image è una libreria che permette di convertire un PDF in un'immagine, utilizzata per visualizzare il documento nell'interfaccia web al momento della creazione di un template.

#img(
    "technologies/opencv.webp",
    caption: [Logo OpenCV],
    alt: "",
    width: 15%
)

=== OCR

// TODO: in questa sezione non suddivido per ora fra OCR scelti e scartati, in quanto questa scelta è ancora in fase di revisione.

Le tecnologie OCR prese in considerazione sono PaddleOCR@paddleocr, Surya@surya, EasyOCR@easyocr, OCRmyPDF@ocrmypdf e Tesseract-OCR@tesseract. \
PaddleOCR è una libreria sviluppata da Baidu, basata su reti neurali, che offre elevata accuratezza su documenti strutturati. Tuttavia, la sua configurazione risulta complessa e l'inferenza su CPU è particolarmente lenta, rendendola poco adatta a contesti senza accelerazione hardware dedicata. \
Surya è una libreria moderna basata su modelli transformer, progettata per il riconoscimento di testo in documenti multi-lingua e multi-colonna. Come PaddleOCR, soffre di tempi di elaborazione elevati in assenza di GPU, e la sua integrazione richiede una gestione non banale delle dipendenze. \
EasyOCR è una libreria Python basata su deep learning che supporta oltre 80 lingue, offrendo un'API semplice e diretta pur mantenendo una buona accuratezza su documenti stampati. \
OCRmyPDF è uno strumento che aggiunge un layer di testo ricercabile a PDF scansionati, basandosi internamente su Tesseract. Dispone inoltre di una funzionalità di deskewing automatico, ovvero la correzione dell'inclinazione di documenti acquisiti con una leggera rotazione. \
Tesseract-OCR è il motore OCR open source più diffuso, originariamente sviluppato da HP e attualmente mantenuto da Google, con supporto a numerose lingue e buona accuratezza su testo stampato pulito.