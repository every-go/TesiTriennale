#import "../config/variables.typ": *
#import "../config/thesis-config.typ": glpl, gl, img, path
#pagebreak(to:"odd")

= Analisi degli approcci iniziali<cap:approcci>
#text(style: "italic", [
    In questo capitolo descrivo i primi approcci e le prime idee applicate allo svolgimento del progetto.
])
#v(1em)

== Soluzione precedente

La prima settimana è stata dedicata all'onboarding nel progetto già esistente, in modo da capire quali sono i principali requisiti per la sostituzione di quest'ultimo. \
Ho studiato la soluzione basata su Mistral OCR e LLM, la quale ha un approccio a tripla fase:
+ Estrarre con Mistral OCR il testo dei DDT;
+ Convertire il testo ricavato in Markdown;
+ Passare il Markdown a Mistral LLM il quale, con degli specifici prompt, ricava i dati corretti.

== Approccio iniziale

Siccome la mia soluzione non poteva utilizzare LLM o API a pagamento, come descritto nella @cap:vincoli, dovevo ideare un approccio totalmente diverso ma generalizzabile alla grande quantità di fornitori disponibili per l'azienda che usa il prodotto.

Inizialmente ho scelto di ideare un approccio basato unicamente su doppia fase:
+ Estrarre con OCR il testo;
+ Ricavare i dati con l'utilizzo di regular expression (regex).

== OCR scelto per i primi test
Per le prime settimane, fino a quando le logiche di estrazione non si sono dimostrate sufficientemente solide, ho scelto di utilizzare un OCR con un impatto ridotto sulla CPU, privilegiando la velocità di esecuzione rispetto alla precisione, in modo da poter iterare rapidamente sui test. L'OCR inizialmente scelto è stato EasyOCR, successivamente sostituito da Pytesseract, risultato leggermente più performante pur mantenendo tempi di estrazione contenuti. Maggiori dettagli sullo studio e il confronto degli OCR utilizzati sono disponibili nella @cap:ocr.

== Approccio iniziale con regex

L'idea era quella di estrarre i dati subito dopo le parole chiave, sfruttando pattern specifici per ogni campo.
Ad esempio, 
- per la data del DDT veniva cercata una data subito dopo keyword come "data" oppure "doc. data";
- per il numero del DDT, una sequenza dopo "num", "numero", "num. doc." o "numero doc.";
- per il numero dei colli un intero dopo le scritte "numero colli", "colli".

Questo approccio si è però rivelato inadeguato per la maggior parte dei template dei
fornitori, i cui DDT non presentano una struttura compatibile con questa logica.

Alla @fig:adeguato c'è un esempio adeguato per l'estrazione di dati tramite regex,
alla @fig:non-adeguato c'è un esempio non adeguato per l'estrazione di dati tramite
regex.

#figure(caption: "Esempio adeguato all'estrazione tramite regex.")[
    #table(
        columns: (auto, auto),
        [*Numero colli*], [1],
        [*Peso lordo*], [1.0KG]
    )
]<fig:adeguato>

#figure(caption: "Esempio non adeguato all'estrazione tramite regex.")[
    #table(
        columns: (auto, auto),
        [*Numero colli*], [*Peso lordo*],
        [1], [1.0KG]
    )
]<fig:non-adeguato>

Infatti la maggior parte dei DDT ha una struttura simile alla @fig:non-adeguato, rendendo impossibile l'estrazione dei dati subito dopo le parole chiave, in quanto le regex non hanno conoscenza della posizione superiore o inferiore di un campo, ma solo della parte precedente o successiva.

Il problema risultava ancora più evidente per gli articoli, strutturati tipicamente in forma tabellare con colonne affiancate (codice, descrizione, unità di misura, quantità): in questi casi le regex non sono in grado di associare correttamente i valori alle rispettive colonne, poiché manca qualsiasi consapevolezza della disposizione spaziale del testo.

Infine, anche nei casi in cui l'approccio avrebbe potuto funzionare, la manutenibilità del codice sarebbe risultata critica: la necessità di gestire tutte le varianti delle keyword (P.IVA, Partita IVA, PIVA, VAT number, ecc.) avrebbe comportato un elevato debito tecnico, rendendo il sistema difficilmente estendibile all'arrivo di nuovi fornitori con layout differenti.

== Conclusione e direzione successiva

I primi approcci hanno evidenziato un limite fondamentale: qualsiasi metodo basato esclusivamente sul contenuto testuale, senza tenere conto della posizione spaziale dei campi all'interno del documento, non è in grado di gestire la varietà di layout presenti nei DDT reali.\
Questa consapevolezza ha orientato lo sviluppo verso un approccio che ragiona sulla disposizione geometrica del testo nel documento, come descritto nella @cap:interfaccia.