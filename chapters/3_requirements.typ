#import "../config/thesis-config.typ": glpl, gl, path, img
#import "data/requirements_list.typ": *

#pagebreak(to:"odd")

= Analisi dei requisiti<cap:analisi-requisiti>

#text(style: "italic", [
    In questo capitolo effettuo l'analisi degli utenti, descrivo i casi d'uso e compongo la lista dei requisiti dividendoli per tipologia e necessità.
])
#v(1em)

== Analisi degli utenti

Gli utenti che sfruttano il servizio sono personale amministrativo e operativo di aziende che gestiscono quotidianamente #gl("DDT") cartacei sia in entrata (materiali ricevuti da fornitori per il trattamento) sia in uscita (spedizioni di materiali trattati). Si tratta tipicamente di utenti non tecnici, abituati a operare su gestionali aziendali, per i quali è fondamentale che il sistema sia semplice da usare e che non richieda competenze informatiche particolari.

Il volume di documenti trattati può essere considerevole: in contesti aziendali di medie dimensioni, la ricezione e la spedizione di merci genera un flusso costante di #gl("DDT") che devono essere registrati tempestivamente nel gestionale per mantenere aggiornata la contabilità di magazzino.

Attualmente, i dati vengono inseriti manualmente, con un dispendio di tempo e un rischio di errore significativi. Questo approccio presenta diverse criticità: lentezza nella registrazione, possibilità di errori di digitazione o omissione di dati, e difficoltà nel recuperare informazioni storiche dai #gl("DDT") cartacei archiviati. Inoltre, il personale potrebbe trovarsi a dover ricopiare più volte le stesse informazioni, come codici articolo e descrizioni, in diversi sistemi, aumentando ulteriormente il carico di lavoro ripetitivo.

== Casi d'uso<cap:casi-uso>

Ogni caso d'uso verrà segnato con il codice UC ed è comprensivo di una descrizione associata.

Denominerò l'attore "Personale", per riferirsi al personale dell'azienda che esegue l'operazione.

=== Descrizione associata ai casi d'uso

Ogni caso d'uso si compone di tutte le informazioni presenti nella seguente tabella, salvo i casi in cui uno specifico campo non risulti rilevante.

#figure(caption: "Campi dei Casi d'Uso")[
  #table(
    columns: (0.28fr, 0.72fr),
    inset: 8pt,
    fill: (_, row) => if row == 0 { luma(230) } else { white },
    table.header(
      [*Campo*], [*Descrizione*],
    ),
    [Grafico UML],
    [Rappresenta lo scenario dei casi d'uso in oggetto],
    [Attore],
    [Rappresenta coloro che interagiscono in quel sistema, senza il controllo da parte del sistema],
    [Scenario principale],
    [La sequenza ragionevole delle operazioni che l'attore deve effettuare per portare a compimento lo scenario],
    [Precondizioni],
    [Lista di elementi necessari per far sì che l'attore possa soddisfare il caso d'uso in oggetto],
    [Postcondizioni],
    [Lista di elementi che descrive le modifiche effettuate internamente dopo il corretto avvenimento dello scenario principale],
    [Scenario alternativo],
    [Rappresenta un comportamento valido ma non principale, che devia dal flusso base a causa di errori],
    [Inclusioni],
    [Ulteriori casi d'uso che l'attore deve compiere per portare a termine lo scenario],
    [Estensioni],
    [Relazione che aggiunge comportamento opzionale o alternativo a un caso d'uso completo, attivata solo al verificarsi di una condizione specifica],
    [Specializzazioni],
    [Le specializzazioni rappresentano varianti del caso d'uso generale e sono tra loro mutualmente esclusive, senza imporre un percorso di esecuzione obbligatorio],
    [Trigger],
    [Descrizione sintetica di una funzionalità dal punto di vista dell'utente, focalizzata sugli obiettivi],
  )
]<table:campi_casi>

#[
#set heading(
  numbering: (..numbers) => {
    let level = numbers.pos().len()
    if level == 4 {
      return numbering("UC1", numbers.pos().at(level - 1))
    } else if level == 5 {
      let parent = numbers.pos().at(level - 2)
      let child = numbers.pos().at(level - 1)
      return numbering("UC1.1", parent, child)
    } else if level == 6 {
      let grandparent = numbers.pos().at(level - 3)
      let parent = numbers.pos().at(level - 2)
      let child = numbers.pos().at(level - 1)
      return numbering("UC1.1.1", grandparent, parent, child)
    } else if level == 7 {
      let grandgrandparent = numbers.pos().at(level - 4)
      let grandparent = numbers.pos().at(level - 3)
      let parent = numbers.pos().at(level - 2)
      let child = numbers.pos().at(level - 1)
      return numbering("UC1.1.1.1", grandgrandparent, grandparent, parent, child)
    }
  }
)
#set heading(supplement: none)
#let d = [*Descrizione: *]
#let ac = [#v(0.5em) *Acceptance criteria: *]

==== Caricamento DDT<uc:caricamento-ddt>

#img(
  "UC/UC1.png",
  caption: [UC1: Caricamento DDT],
  width: 70%,
  alt: "Questo diagramma dei casi d'uso rappresenta il personale che carica un DDT."
)<fig:uc1>

- Attore principale: Personale
- Scenario principale:
 + Il personale carica un #gl("DDT") nel sistema
- Precondizioni:
 - Il sistema è online
 - Il personale si trova nella pagina del caricamento del #gl("DDT")
- Postcondizioni:
 - Il personale può visualizzare i risultati dell'estrazione
- Trigger: Il personale vuole caricare il #gl("DDT") per poi visualizzare i dati dell'estrazione

==== Visualizzazione dati estratti<uc:visualizzazione-dati>

#img(
  "UC/UC2.png",
  caption: [UC2: Visualizzazione dati estratti],
  width: 75%,
  alt: "Questo diagramma dei casi d'uso rappresenta il personale che visualizza i dati estratti. Quest'azione include anche la visualizzazione dei dati del fornitore, la visualizzazione dei dati del destinatario, la visualizzazione della lista degli articoli e la visualizzazione dei dati dell'appendice."
)<fig:uc2>

- Attore principale: Personale
- Scenario principale:
 + Il personale visualizza i dati del fornitore -> Vedi @uc:visualizzazione-fornitore
 + Il personale visualizza i dati del destinatario -> Vedi @uc:visualizzazione-destinatario
 + Il personale visualizza la lista degli articoli -> Vedi @uc:visualizzazione-articoli
 + Il personale visualizza i dati dell'appendice del documento -> Vedi @uc:visualizzazione-appendice
- Precondizioni:
 - Il sistema è online
 - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
- Postcondizioni:
 - Il personale ha visualizzato i dati estratti
- Inclusioni:
  - @uc:visualizzazione-fornitore
  - @uc:visualizzazione-destinatario
  - @uc:visualizzazione-articoli
  - @uc:visualizzazione-appendice
- Trigger: Il personale vuole visualizzare i dati estratti al caricamento del #gl("DDT")

===== Visualizzazione dati fornitore<uc:visualizzazione-fornitore>

#img(
  "UC/UC2.1.png",
  caption: [UC2.1: Visualizzazione dati fornitore],
  width: 75%,
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati del fornitore, specificatamente visualizza la ragione sociale, l'indirizzo e la partita IVA."
)<fig:uc2.1>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del fornitore -> Vedi @uc:visualizzazione-fornitore-ragione-sociale
  + Il personale visualizza l'indirizzo del fornitore -> Vedi @uc:visualizzazione-fornitore-indirizzo
  + Il personale visualizza la partita IVA del fornitore -> Vedi @uc:visualizzazione-fornitore-piva
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati del fornitore
- Inclusioni:
  - @uc:visualizzazione-fornitore-ragione-sociale
  - @uc:visualizzazione-fornitore-indirizzo
  - @uc:visualizzazione-fornitore-piva
- Trigger: Il personale vuole visualizzare i dati del fornitore estratti dal #gl("DDT")

====== Visualizzazione ragione sociale fornitore<uc:visualizzazione-fornitore-ragione-sociale>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizzazione-fornitore
- Postcondizioni:
  - Il personale ha visualizzato la ragione sociale del fornitore
- Trigger: Il personale vuole visualizzare la ragione sociale del fornitore estratta dal #gl("DDT")

====== Visualizzazione indirizzo fornitore<uc:visualizzazione-fornitore-indirizzo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza l'indirizzo del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizzazione-fornitore
- Postcondizioni:
  - Il personale ha visualizzato l'indirizzo del fornitore
- Trigger: Il personale vuole visualizzare l'indirizzo del fornitore estratto dal #gl("DDT")

====== Visualizzazione partita IVA fornitore<uc:visualizzazione-fornitore-piva>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la partita IVA del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizzazione-fornitore
- Postcondizioni:
  - Il personale ha visualizzato la partita IVA del fornitore
- Trigger: Il personale vuole visualizzare la partita IVA del fornitore estratta dal #gl("DDT")

===== Visualizzazione dati destinatario<uc:visualizzazione-destinatario>

#img(
  "UC/UC2.2.png",
  caption: [UC2.2: Visualizzazione dati destinatario],
  width: 75%,
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati del destinatario, specificatamente visualizza la ragione sociale, l'indirizzo e la partita IVA."
)<fig:uc2.2>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del destinatario -> Vedi @uc:visualizzazione-destinatario-ragione-sociale
  + Il personale visualizza l'indirizzo del destinatario -> Vedi @uc:visualizzazione-destinatario-indirizzo
  + Il personale visualizza la partita IVA del destinatario -> Vedi @uc:visualizzazione-destinatario-piva
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati del destinatario
- Inclusioni:
  - @uc:visualizzazione-destinatario-ragione-sociale
  - @uc:visualizzazione-destinatario-indirizzo
  - @uc:visualizzazione-destinatario-piva
- Trigger: Il personale vuole visualizzare i dati del destinatario estratti dal #gl("DDT")

====== Visualizzazione ragione sociale destinatario<uc:visualizzazione-destinatario-ragione-sociale>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizzazione-destinatario
- Postcondizioni:
  - Il personale ha visualizzato la ragione sociale del destinatario
- Trigger: Il personale vuole visualizzare la ragione sociale del destinatario estratta dal #gl("DDT")

====== Visualizzazione indirizzo destinatario<uc:visualizzazione-destinatario-indirizzo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza l'indirizzo del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizzazione-destinatario
- Postcondizioni:
  - Il personale ha visualizzato l'indirizzo del destinatario
- Trigger: Il personale vuole visualizzare l'indirizzo del destinatario estratto dal #gl("DDT")

====== Visualizzazione partita IVA destinatario<uc:visualizzazione-destinatario-piva>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la partita IVA del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizzazione-destinatario
- Postcondizioni:
  - Il personale ha visualizzato la partita IVA del destinatario
- Trigger: Il personale vuole visualizzare la partita IVA del destinatario estratta dal #gl("DDT")

===== Visualizzazione lista articoli<uc:visualizzazione-articoli>

#img(
  "UC/UC2.3.png",
  caption: [UC2.3: Visualizzazione lista articoli],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza la lista degli articoli, la cui azione include il visualizzare il singolo articolo, Quest'ultima include la visualizzazione del codice dell'articolo, la sua descrizione, la quantità, il riferimento al codice dell'ordine e la misura di unità dell'articolo."
)<fig:uc2.3>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la lista degli articoli
  + Per ogni articolo, il personale visualizza il singolo articolo -> Vedi @uc:visualizzazione-singolo-articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
- Postcondizioni:
  - Il personale ha visualizzato la lista degli articoli estratti dal #gl("DDT")
- Inclusioni:
  - @uc:visualizzazione-singolo-articolo
- Trigger: Il personale vuole visualizzare gli articoli estratti dal #gl("DDT")

====== Visualizzazione singolo articolo<uc:visualizzazione-singolo-articolo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il codice dell'articolo -> Vedi @uc:visualizzazione-articolo-codice
  + Il personale visualizza la descrizione dell'articolo -> Vedi @uc:visualizzazione-articolo-descrizione
  + Il personale visualizza la quantità dell'articolo -> Vedi @uc:visualizzazione-articolo-quantita
  + Il personale visualizza il riferimento al codice ordine dell'articolo -> Vedi @uc:visualizzazione-articolo-ordine
  + Il personale visualizza la misura di unità dell'articolo -> Vedi @uc:visualizzazione-articolo-unita
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
- Postcondizioni:
  - Il personale ha visualizzato i dati del singolo articolo
- Inclusioni:
  - @uc:visualizzazione-articolo-codice
  - @uc:visualizzazione-articolo-descrizione
  - @uc:visualizzazione-articolo-quantita
  - @uc:visualizzazione-articolo-ordine
  - @uc:visualizzazione-articolo-unita
- Trigger: Il personale vuole visualizzare i dati di un articolo estratto dal #gl("DDT")

======= Visualizzazione codice articolo<uc:visualizzazione-articolo-codice>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il codice dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizzazione-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato il codice dell'articolo
- Trigger: Il personale vuole visualizzare il codice dell'articolo estratto dal #gl("DDT")

======= Visualizzazione descrizione articolo<uc:visualizzazione-articolo-descrizione>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la descrizione dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizzazione-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la descrizione dell'articolo
- Trigger: Il personale vuole visualizzare la descrizione dell'articolo estratta dal #gl("DDT")

======= Visualizzazione quantità articolo<uc:visualizzazione-articolo-quantita>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la quantità dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizzazione-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la quantità dell'articolo
- Trigger: Il personale vuole visualizzare la quantità dell'articolo estratta dal #gl("DDT")

======= Visualizzazione riferimento codice ordine articolo<uc:visualizzazione-articolo-ordine>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il riferimento al codice ordine dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizzazione-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato il riferimento al codice ordine dell'articolo
- Trigger: Il personale vuole visualizzare il riferimento al codice ordine dell'articolo estratto dal #gl("DDT")

======= Visualizzazione misura di unità articolo<uc:visualizzazione-articolo-unita>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la misura di unità dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizzazione-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizzazione-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la misura di unità dell'articolo
- Trigger: Il personale vuole visualizzare la misura di unità dell'articolo estratta dal #gl("DDT")

===== Visualizzazione dati appendice documento<uc:visualizzazione-appendice>

#img(
  "UC/UC2.4.png",
  caption: [UC2.4: Visualizzazione dati appendice documento],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati dell'appendice del documento. Questo include la visualizzazione delle note (annotazioni), la visualizzazione del numero colli, la visualizzazione del peso netto e la visualizzazione del peso lordo."
)<fig:uc2.4>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza le note del documento -> Vedi @uc:visualizzazione-appendice-note
  + Il personale visualizza il numero di colli -> Vedi @uc:visualizzazione-appendice-colli
  + Il personale visualizza il peso lordo -> Vedi @uc:visualizzazione-appendice-peso-lordo
  + Il personale visualizza il peso netto -> Vedi @uc:visualizzazione-appendice-peso-netto
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati dell'appendice del documento
- Inclusioni:
  - @uc:visualizzazione-appendice-note
  - @uc:visualizzazione-appendice-colli
  - @uc:visualizzazione-appendice-peso-lordo
  - @uc:visualizzazione-appendice-peso-netto
- Trigger: Il personale vuole visualizzare i dati dell'appendice estratti dal #gl("DDT")

====== Visualizzazione note<uc:visualizzazione-appendice-note>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza le note presenti nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizzazione-appendice
- Postcondizioni:
  - Il personale ha visualizzato le note del documento
- Trigger: Il personale vuole visualizzare le note estratte dal #gl("DDT")

====== Visualizzazione numero colli<uc:visualizzazione-appendice-colli>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il numero di colli indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizzazione-appendice
- Postcondizioni:
  - Il personale ha visualizzato il numero di colli
- Trigger: Il personale vuole visualizzare il numero di colli estratto dal #gl("DDT")

====== Visualizzazione peso netto<uc:visualizzazione-appendice-peso-netto>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il peso netto indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizzazione-appendice
- Postcondizioni:
  - Il personale ha visualizzato il peso netto
- Trigger: Il personale vuole visualizzare il peso netto estratto dal #gl("DDT")

====== Visualizzazione peso lordo<uc:visualizzazione-appendice-peso-lordo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il peso lordo indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un #gl("DDT") -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizzazione-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizzazione-appendice
- Postcondizioni:
  - Il personale ha visualizzato il peso lordo
- Trigger: Il personale vuole visualizzare il peso lordo estratto dal #gl("DDT")

]

== Tracciamento dei requisiti
Ad ogni requisito è associato un codice costruito in base alle sue caratteristiche:
#v(1em)
#align(center)[*R(F/Q/C)(M/D/O)*]
#set list(marker: none)
#v(0.3em)
- R (_Requirement_): requisito
#v(1em)
- F (_Functional_): definisce una funzione di un sistema o dei suoi componenti;
- Q (_Qualitative_): rappresentano come il sistema deve essere per soddisfare i requisiti dello stakeholder;
- C (_Constraint_): rappresentano dei vincoli o dei limiti che il sistema deve rispettare;
#v(0.5em)
- M (_Mandatory_): irrinunciabili per qualcuno degli stakeholder;
- D (_Desirable_): non strettamente necessari ma a valore aggiunto riconoscibile;
- O (_Optional_): relativamente utili oppure contrattabili anche in fasi avanzate del progetto;
#v(1em)
In @tab:requisiti-funzionali, @tab:requisiti-qualitativi e @tab:requisiti-vincolo sono riassunti i requisiti e il loro tracciamento con gli use case delineati in fase di analisi.
#[
#show figure: set block(breakable: true)
#set table(
  align: (center+horizon, left+horizon, center+horizon),
  columns: (auto, 5fr, 1.5fr),
)
#v(1em)
#figure(
    table(
        table.header([*Codice*], [*Descrizione*], [*Fonti*]),
        ..getFR().flatten()
    ),
    caption: "Tracciamento dei requisti funzionali.",
)
<tab:requisiti-funzionali>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getQR().flatten()
    ),
    caption: "Tracciamento dei requisti di qualità.",
)
<tab:requisiti-qualitativi>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getCR().flatten()
    ),
    caption: "Tracciamento dei requisti di vincolo.",
)
<tab:requisiti-vincolo>

#v(2em)
Di seguito, nella @tab:riepilogo-requisiti ho inserito il riepilogo dei requisiti, suddivisi per tipologia e necessità.
#v(1em)
#show figure: set block(breakable: false)
#figure(
  table(
    columns: (auto, 1fr, 1fr, auto, auto),
    table.header([*Tipo*], [*Obbligatori*], [*Desiderabili*],[*Opzionali*], [*Somma*]),
    [Funzionali], [#getFR(getLen: true).at(0)], [#getFR(getLen: true).at(1)], [#getFR(getLen: true).at(2)], [#getFR(getLen: true).sum()],
    [Qualità], [#getQR(getLen: true).at(0)], [#getQR(getLen: true).at(1)], [#getQR(getLen: true).at(2)], [#getQR(getLen: true).sum()],
    [Vincolo], [#getCR(getLen: true).at(0)], [#getCR(getLen: true).at(1)], [#getCR(getLen: true).at(2)], [#getCR(getLen: true).sum()],
    [*Totale*],
      [*#{getFR(getLen: true).at(0)+getQR(getLen: true).at(0)+getCR(getLen: true).at(0)}*],
      [*#{getFR(getLen: true).at(1)+getQR(getLen: true).at(1)+getCR(getLen: true).at(1)}*],
      [*#{getFR(getLen: true).at(2)+getQR(getLen: true).at(2)+getCR(getLen: true).at(2)}*],
      [*#{getFR(getLen: true).sum()+getQR(getLen: true).sum()+getCR(getLen: true).sum()}*],
    align: (center+horizon)
  ),
  caption: "Riepilogo dei requisiti."
)<tab:riepilogo-requisiti>
]