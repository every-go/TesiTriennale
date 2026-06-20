#import "../config/thesis-config.typ": glpl, gl
#import "../config/variables.typ": myTutor
#pagebreak(to:"odd")

= Descrizione stage<cap:descrizione-stage>
#text(style: "italic", [
    In questo capitolo approfondisco l'organizzazione dello stage, il rapporto con l'azienda e svolgo l'analisi dei rischi.
])
#v(1em)

== Competenze da apprendere<cap:competenze>

Lo stage mira a sviluppare competenze che vanno oltre i singoli linguaggi di programmazione: capacità di analisi dei requisiti, astrazione dei problemi e progettazione di soluzioni algoritmiche generalizzabili.

Per quanto l'azienda usi principalmente #gl("framework", display: "framework") PHP come Laravel e Filament, mi è stata lasciata completa libertà di linguaggio e altri framework per realizzare il progetto più rapidamente possibile.

Lo stage mi permetterà di acquisire conoscenze su OCR on-premise, preprocessing documentale, #gl("parsing", display: "parsing") strutturato di documenti, orchestrazione Docker@docker, testing comparativo e collaborazione con tutor e stakeholder.

== Vincoli<cap:vincoli>

Il vincolo principale è non utilizzare LLM oppure OCR a pagamento, come ad esempio OpenAI@openai, Mistral@mistral e AWS Textract@aws-textract.

L'azienda valuta principalmente la capacità di analisi e problem-solving piuttosto che l'aderenza a uno stack tecnologico specifico.

== Pianificazione

Lo stage si articola in 300 ore distribuite su otto settimane: sette settimane da 40 ore e una settimana conclusiva da 20 ore.

La pianificazione, direttamente presa dal piano di lavoro, è la seguente:

+ Prima Settimana - Analisi iniziale e setup (40 ore): onboarding sul progetto, studio dell'analisi dei requisiti, setup dell'ambiente di lavoro locale e comprensione del flusso attuale di lettura DDT e delle dipendenze da servizi esterni;
+ Seconda Settimana - Mappatura funzionale e architettura locale (40 ore): analisi dei template DDT principali, mappatura dei campi da estrarre, studio delle funzionalità attuali basate su Mistral Documents e definizione dell'architettura locale con Docker e componenti preferibilmente native;
+ Terza Settimana - Pipeline OCR locale e preprocessing (40 ore): implementazione delle prime routine di acquisizione documenti, preprocessing immagini, OCR locale e parsing dei campi principali di testata e righe documento;
+ Quarta Settimana - Classificazione template e normalizzazione dati (40 ore): sviluppo della logica di riconoscimento layout, gestione dei template, metriche di confidenza, normalizzazione dei valori estratti e trattamento dei casi ambigui;
+ Quinta Settimana - Integrazione applicativa e revisione operatore (40 ore): integrazione nel modulo Laravel/Filament delle schermate di upload, dashboard, revisione assistita dei campi OCR, mapping dati e tracciamento delle operazioni;
+ Sesta Settimana - Export gestionale e test comparativi (40 ore): implementazione dell'export verso gestionale o file di interscambio, confronto tra pipeline locale e soluzione precedente, correzione anomalie e ottimizzazione delle performance;
+ Settima Settimana - Hardening, Docker e documentazione tecnica (40 ore): rifinitura del prototipo, riduzione delle dipendenze non necessarie, predisposizione delle configurazioni Docker e raccolta della documentazione tecnica di deploy e manutenzione;
+ Ottava Settimana - Validazione finale e relazione (20 ore): validazione conclusiva con il tutor, consolidamento dei risultati, stesura della relazione finale e preparazione della presentazione conclusiva dello stage.

== Analisi dei rischi <cap:analisi-rischi>

I rischi identificati per questo progetto sono classificati con un codice progressivo della forma *RN*, dove *N* è un numero intero incrementale che parte da 01, e decorati con una probabilità di occorrenza, un impatto e una strategia di mitigazione.

Ogni rischio è stato analizzato tenendo conto sia delle caratteristiche generali del progetto, sia delle specificità legate all'elaborazione OCR di documenti eterogenei.

=== R01: Incompletezza o ambiguità dei requisiti espressi nel piano di lavoro<risk:r01>

#figure(caption: "Rischio R01.")[
    #table(
        columns: (0.28fr, 0.72fr),
        inset: 3pt,
        fill: (_, row) => if row == 0 { luma(230) } else { white },
        table.header([*Campo*], [*Descrizione*]),
        [Codice], [R01],
        [Nome], [Incompletezza o ambiguità dei requisiti espressi nel piano di lavoro],
        [Descrizione], [I requisiti descritti nel piano di lavoro possono risultare incompleti o ambigui, portando a implementazioni non coerenti con le aspettative del tutor aziendale],
        [Mitigazione], [I requisiti vengono analizzati e chiariti nelle prime fasi dello stage, producendo una specifica condivisa con il tutor. In caso di dubbi, si effettuano incontri chiarificatori prima di procedere con l'implementazione],
        [Probabilità], [Bassa],
        [Impatto], [Medio],
    )
]

=== R02: Sovradimensionamento del progetto rispetto alle capacità personali<risk:r02>

#figure(caption: "Rischio R02.")[
    #table(
        columns: (0.28fr, 0.72fr),
        inset: 3pt,
        fill: (_, row) => if row == 0 { luma(230) } else { white },
        table.header([*Campo*], [*Descrizione*]),
        [Codice], [R02],
        [Nome], [Sovradimensionamento del progetto rispetto alle capacità personali],
        [Descrizione], [Le attività previste potrebbero rivelarsi eccessive rispetto alle ore disponibili e alle competenze del singolo stagista, rischiando di non completare tutti gli obiettivi nei tempi stabiliti],
        [Mitigazione], [Le attività vengono suddivise per priorità in base al valore che portano al progetto, in modo che in caso di mancanza di tempo solo le attività meno critiche e non vincolanti subiscano ritardi o cancellazioni],
        [Probabilità], [Media],
        [Impatto], [Alto],
    )
]

=== R03: Difficoltà nel coordinamento interno<risk:r03>

#figure(caption: "Rischio R03.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R03],
    [Nome], [Difficoltà nel coordinamento interno],
    [Descrizione], [La comunicazione con il tutor aziendale o con altri stakeholder potrebbe risultare discontinua o inefficace, rallentando le decisioni tecniche e causando incomprensioni sugli obiettivi],
    [Mitigazione], [Vengono pianificati incontri regolari con il tutor aziendale come previsto dal piano di lavoro, con aggiornamenti frequenti sullo stato di avanzamento. Eventuali dubbi vengono segnalati tempestivamente senza attendere l'incontro successivo],
    [Probabilità], [Bassa],
    [Impatto], [Alto],
  )
]

=== R04: Difficoltà nell'apprendimento delle tecnologie<risk:r04>

#figure(caption: "Rischio R04.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R04],
    [Nome], [Difficoltà nell'apprendimento delle tecnologie],
    [Descrizione], [Alcune tecnologie previste dal progetto, come i motori OCR on-premise, potrebbero richiedere un tempo di apprendimento superiore al previsto, riducendo il tempo effettivamente disponibile per lo sviluppo],
    [Mitigazione], [Le prime settimane dello stage sono dedicate esplicitamente all'analisi e al setup dell'ambiente, includendo il tempo di apprendimento nella pianificazione. In caso di difficoltà persistenti, si privilegiano librerie e strumenti con documentazione più matura],
    [Probabilità], [Media],
    [Impatto], [Medio],
  )
]

=== R05: Incompatibilità delle tecnologie scelte con l'infrastruttura esistente<risk:r05>

#figure(caption: "Rischio R05.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R05],
    [Nome], [Incompatibilità delle tecnologie scelte con l'infrastruttura esistente],
    [Descrizione], [Le tecnologie selezionate per la pipeline OCR locale potrebbero risultare incompatibili con il sistema Smart Accounting esistente o con i vincoli dell'infrastruttura Docker aziendale],
    [Mitigazione], [Viene effettuata un'analisi preventiva delle tecnologie subito dopo l'identificazione dei requisiti, verificando la compatibilità con l'infrastruttura esistente prima di procedere con l'implementazione],
    [Probabilità], [Media],
    [Impatto], [Alto],
  )
]

=== R06: Gestione inadeguata dei casi limite nell'estrazione dati<risk:r06>

#figure(caption: "Rischio R06.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R06],
    [Nome], [Gestione inadeguata dei casi limite nell'estrazione dati],
    [Descrizione], [La pipeline OCR potrebbe non gestire correttamente situazioni anomale quali campi assenti, valori ambigui, formati numerici non standard o DDT con struttura parzialmente illeggibile],
    [Mitigazione], [Vengono identificati i casi limite più frequenti durante la fase di analisi dei template, definendo regole di validazione e fallback espliciti per gestire valori mancanti o ambigui],
    [Probabilità], [Alta],
    [Impatto], [Medio],
  )
]

=== R07: Variabilità dei layout dei DDT tra fornitori diversi<risk:r07>

#figure(caption: "Rischio R07.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R07],
    [Nome], [Variabilità dei layout dei DDT tra fornitori diversi],
    [Descrizione], [I DDT provenienti da fornitori diversi presentano strutture, formati e posizioni dei campi molto eterogenei, rendendo difficile la definizione di un template di estrazione universale],
    [Mitigazione], [L'utente specifica il fornitore al momento del caricamento del DDT, permettendo alla pipeline di applicare direttamente le regole di estrazione configurate per quel template. I template vengono censiti e configurati progressivamente durante lo stage man mano che si raccolgono esempi reali],
    [Probabilità], [Alta],
    [Impatto], [Alto],
  )
]

=== R08: Variabilità dei layout dei DDT dello stesso fornitore<risk:r08>

#figure(caption: "Rischio R08.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R08],
    [Nome], [Variabilità dei layout dei DDT dello stesso fornitore],
    [Descrizione], [I DDT provenienti dallo stesso fornitore possono avere strutture, formati e posizioni dei campi molto eterogenei, rendendo difficile la definizione di un template di estrazione universale],
    [Mitigazione], [Una volta specificato il fornitore, la pipeline seleziona automaticamente il template più adatto tra quelli configurati per quel fornitore],
    [Probabilità], [Bassa],
    [Impatto], [Alto],
  )
]

=== R09: Qualità insufficiente delle scansioni<risk:r09>

#figure(caption: "Rischio R09.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R09],
    [Nome], [Qualità insufficiente delle scansioni],
    [Descrizione], [I DDT cartacei possono essere acquisiti con qualità scadente — bassa risoluzione, rotazione, macchie o contrasto insufficiente — compromettendo l'accuratezza del riconoscimento ottico del testo],
    [Mitigazione], [La pipeline include una fase di preprocessing delle immagini con operazioni di correzione della rotazione, miglioramento del contrasto e riduzione del rumore],
    [Probabilità], [Media],
    [Impatto], [Alto],
  )
]

=== R10: Accuratezza insufficiente del motore OCR<risk:r10>

#figure(caption: "Rischio R10.")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 3pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header([*Campo*], [*Descrizione*]),
    [Codice], [R10],
    [Nome], [Accuratezza insufficiente del motore OCR],
    [Descrizione], [Il motore OCR locale potrebbe produrre risultati meno accurati rispetto alla soluzione precedente basata su Mistral, in particolare su testi piccoli, scritte a mano o caratteri tipografici non standard presenti in alcuni DDT],
    [Mitigazione], [Vengono eseguiti test comparativi tra il motore OCR locale e la soluzione precedente su un campione rappresentativo di documenti reali],
    [Probabilità], [Media],
    [Impatto], [Alto],
  )
]