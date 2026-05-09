#import "../config/thesis-config.typ": glpl, gl,
#import "../config/variables.typ": myTutor
#pagebreak(to:"odd")

= Descrizione stage<cap:descrizione-stage>
#text(style: "italic", [
    In questo capitolo approfondisco l'organizzazione dello stage, il rapporto con l'azienda e svolgo l'analisi dei rischi.
])
#v(1em)

== Competenze da apprendere

Lo stage mira a sviluppare competenze che vanno oltre i singoli linguaggi di programmazione: capacità di analisi dei requisiti, astrazione dei problemi e progettazione di soluzioni algoritmiche generalizzabili.

Per quanto l'azienda usi i framework PHP menzionati precedentemente, mi è stata lasciata completa libertà di linguaggio e altri framework per realizzare il prodotto che metta in atto le mie idee in modo più rapido.

Lo stage mi permetterà di acquisire conoscenze su OCR on-premise, preprocessing documentale, classificazione di template, parsing strutturato di documenti, integrazione con gestionali legacy, orchestrazione Docker, testing comparativo, documentazione tecnica e collaborazione con tutor e stakeholder.

== Vincoli

Il vincolo principale è non utilizzare LLM a pagamento, come OpenAI, Gemini, Claude o #gl("Mistral").

L'azienda valuta principalmente la capacità di analisi e problem-solving piuttosto che l'aderenza a uno stack tecnologico specifico.

== Pianificazione

Lo stage si articola in 300 ore distribuite su otto settimane: sette settimane da 40 ore e una settimana conclusiva da 20 ore.

La pianificazione, direttamente presa dal piano di lavoro, è la seguente:

+ Prima Settimana - Analisi iniziale e setup (40 ore): onboarding sul progetto Smart Accounting, studio dell'analisi dei requisiti, setup dell'ambiente di lavoro locale e comprensione del flusso attuale di lettura #gl("DDT") e delle dipendenze da servizi esterni;
+ Seconda Settimana - Mappatura funzionale e architettura locale (40 ore): analisi dei template #gl("DDT") principali, mappatura dei campi da estrarre, studio delle funzionalità attuali basate su #gl("Mistral") Documents e definizione dell'architettura locale con Docker e componenti preferibilmente native;
+ Terza Settimana - Pipeline OCR locale e preprocessing (40 ore): implementazione delle prime routine di acquisizione documenti, preprocessing immagini, OCR locale e parsing dei campi principali di testata e righe documento;
+ Quarta Settimana - Classificazione template e normalizzazione dati (40 ore): sviluppo della logica di riconoscimento layout, gestione dei template, metriche di confidenza, normalizzazione dei valori estratti e trattamento dei casi ambigui;
+ Quinta Settimana - Integrazione applicativa e revisione operatore (40 ore): integrazione nel modulo Laravel/Filament delle schermate di upload, dashboard, revisione assistita dei campi OCR, mapping dati e tracciamento delle operazioni;
+ Sesta Settimana - Export gestionale e test comparativi (40 ore): implementazione dell'export verso gestionale o file di interscambio, confronto tra pipeline locale e soluzione precedente, correzione anomalie e ottimizzazione delle performance;
+ Settima Settimana - Hardening, Docker e documentazione tecnica (40 ore): rifinitura del prototipo, riduzione delle dipendenze non necessarie, predisposizione delle configurazioni Docker e raccolta della documentazione tecnica di deploy e manutenzione;
+ Ottava Settimana - Validazione finale e relazione (20 ore): validazione conclusiva con il tutor, consolidamento dei risultati, stesura della relazione finale e preparazione della presentazione conclusiva dello stage.

== Analisi dei rischi

I rischi sono classificati in tecnologici (RT) e personali (RP), come mostrato nelle @tab:rischi-tecno e @tab:rischi-pers.

#figure(
    caption: [Rischi tecnologici],
)[
    #table(columns:(1fr, 2fr),
        [Codice], [Descrizione],
        [RT1],[Difficoltà nell'apprendimento delle nuove tecnologie],
        [RT2],[Gestione inadeguata dei casi limite del progetto],
        [RT3],[Incompatibilità delle tecnologie scelte con l'infrastruttura esistente],
    )
] <tab:rischi-tecno>

#figure(
    caption: [Rischi personali],
)[
    #table(columns:(1fr, 2fr),
        [Codice], [Descrizione],
        [RP1],[Incomprensione dei requisiti del Piano di Lavoro],
        [RP2],[Impossibilità di completare le ore previste nei tempi],
        [RP3],[Difficoltà di comunicazione con il tutor aziendale],
    )
] <tab:rischi-pers>