#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "../config/thesis-config.typ": gl, glpl, img

= Introduzione <cap:introduzione>
#text(style: "italic", [
    In questo capitolo descrivo l'azienda, introduco il progetto e spiego le motivazioni che mi hanno portato a sceglierlo.
])
#v(1em)

== L'azienda

Spazio Dev SRL è una software house situata a Tombolo (PD) specializzata nello sviluppo di soluzioni innovative che integrano AI, stampa 3D e design.

L'obiettivo principale dell'azienda è di innovare le imprese riducendo tempi, costi e complessità operativa attraverso automazione e tecnologie avanzate.

#img(
    "logo_azienda.svg",
    caption: [Logo Spazio Dev],
    alt: ""
)<fig:logo>

== Il progetto

Il lavoro si concentra sull'evoluzione di Smart Accounting, un sistema già
operativo per la lettura automatica di Documenti di Trasporto (#gl("DDT")), attualmente dipendente da #gl("Mistral") per la comprensione documentale. La soluzione esistente, pur funzionante, comporta costi operativi ricorrenti e dipendenza da LLM.

Lo scopo è quello di definire e sviluppare una pipeline OCR locale per acquisire i dati, classificare i layout ed estrarre dati strutturati dai #gl("DDT") senza dipendere da #gl("API") esterne a pagamento. La pipeline prevede più fasi sequenziali: acquisizione e preprocessing delle immagini, riconoscimento ottico del testo, classificazione del template di provenienza, normalizzazione dei valori estratti, revisione assistita da parte dell'operatore ed esportazione verso il gestionale aziendale.

Nello specifico, i dati da estrarre sono:
- Ragione sociale del fornitore e del destinatario
- P.IVA del fornitore e del destinatario
- Indirizzo del fornitore e del destinatario
- Codice degli articoli
- Descrizione degli articoli (se presente)
- Metro di misura di unità degli articoli (se presente)
- Quantità degli articoli
- Riferimento al codice ordine degli articoli (se presente)
- Annotazioni presenti nel #gl("DDT")
- Numero di colli
- Peso lordo
- Peso netto (se presente)


== Scelta del progetto

Ho scelto questo progetto per tre ragioni principali:

+ Affronta un problema rilevante nell'informatica moderna: l'estrazione affidabile di dati da documenti semi-strutturati;

+ Offre l'opportunità di apprendere tecnologie ampiamente utilizzate nell'informatica moderna, come gli OCR;

+ Richiede un approccio algoritmico generalizzabile anziché soluzioni ad-hoc per casi specifici, stimolando capacità di astrazione e design di sistema.