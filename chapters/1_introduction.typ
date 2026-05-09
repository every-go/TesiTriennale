#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "../config/thesis-config.typ": gl, glpl, glossary-style, linkfn, path, img

= Introduzione <cap:introduzione>
#text(style: "italic", [
    In questo capitolo descrivo l'azienda, introduco il progetto e spiego le motivazioni che mi hanno portato a sceglierlo.
])
#v(1em)

== L'azienda

Spazio Dev SRL è una software house situata a Tombolo (PD) specializzata nello sviluppo di soluzioni innovative che integrano AI, stampa 3D e design.

L'obiettivo principale dell'azienda è di innovare le imprese riducendo tempi, costi e complessità operativa attraverso automazione e tecnologie avanzate.

Il logo è mostrato nella @fig:logo.

#img(
    "logo_azienda.svg",
    caption: [Logo Spazio Dev],
    alt: "Logo azienda Spazio Dev"
)<fig:logo>

== Il progetto

Il lavoro si concentra sull'evoluzione di Smart Accounting, un sistema già operativo per la lettura automatica di Documenti di Trasporto (#gl("DDT")), attualmente dipendente da #gl("Mistral") per la comprensione documentale.

Lo scopo è quello di definire e sviluppare una pipeline OCR locale per acquisire i dati, classificare i layout ed estrarre dati strutturati dai #gl("DDT") senza dipendere da #gl("API") esterne a pagamento.

== Scelta del progetto

Ho scelto questo progetto per tre ragioni principali:

+ Affronta un problema rilevante nell'informatica moderna: l'estrazione affidabile di dati da documenti semi-strutturati;

+ Offre l'opportunità di apprendere tecnologie ampiamente utilizzate nell'ecosistema PHP, come Laravel e Filament;

+ Richiede un approccio algoritmico generalizzabile anziché soluzioni ad-hoc per casi specifici, stimolando capacità di astrazione e design di sistema.