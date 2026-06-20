#import "../config/thesis-config.typ": glpl, gl, path, img
#import "data/3.1_requirements_list.typ": *
#show "->": $->$

#pagebreak(to:"odd")

= Analisi dei requisiti<cap:analisi-requisiti>

#text(style: "italic", [
    In questo capitolo effettuo l'analisi degli utenti, descrivo i casi d'uso e compongo la lista dei requisiti dividendoli per tipologia e necessità.
])
#v(1em)

== Analisi degli utenti

Gli utenti che sfruttano il servizio sono personale amministrativo e operativo di aziende che gestiscono quotidianamente DDT cartacei sia in entrata (materiali ricevuti da fornitori per il trattamento) sia in uscita (spedizioni di materiali trattati). Si tratta tipicamente di utenti non tecnici, abituati a operare su gestionali aziendali, per i quali è fondamentale che il sistema sia semplice da utilizzare e che non richieda competenze informatiche particolari.

Il volume di documenti trattati può essere considerevole: in contesti aziendali di medie dimensioni, la ricezione e la spedizione di merci genera un flusso costante di DDT che devono essere registrati tempestivamente nel gestionale per mantenere aggiornata la contabilità di magazzino.

Attualmente, i dati vengono inseriti manualmente, con un dispendio di tempo e un rischio di errore significativi. Questo approccio presenta diverse criticità: lentezza nella registrazione, possibilità di errori di digitazione o omissione di dati, e difficoltà nel recuperare informazioni storiche dai DDT cartacei archiviati. Inoltre, il personale potrebbe trovarsi a dover ricopiare più volte le stesse informazioni, come codici articolo e descrizioni, in diversi sistemi, aumentando ulteriormente il carico di lavoro ripetitivo.

== Casi d'uso<cap:casi-uso>

Ogni caso d'uso verrà identificato con il codice UC ed è comprensivo di una descrizione associata.

Denominerò l'attore "Personale", per riferirsi al personale dell'azienda che esegue l'operazione.

=== Descrizione associata ai casi d'uso

Ogni caso d'uso si compone di tutte le informazioni presenti nella seguente tabella, salvo i casi in cui uno specifico campo non risulti rilevante.

#figure(caption: "Campi dei Casi d'Uso.")[
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
    [Rappresenta coloro che interagiscono con il sistema dall'esterno, senza farne parte],
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
    [Evento o condizione che avvia il caso d'uso],
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
    else if level == 8 {
      let grandgrandgrandparent = numbers.pos().at(level - 5)
      let grandgrandparent = numbers.pos().at(level - 4)
      let grandparent = numbers.pos().at(level - 3)
      let parent = numbers.pos().at(level - 2)
      let child = numbers.pos().at(level - 1)
      return numbering("UC1.1.1.1.1", grandgrandgrandparent, grandgrandparent, grandparent, parent, child)
    }
  }
)
#set heading(supplement: none)
#let d = [*Descrizione: *]
#let ac = [#v(0.5em) *Acceptance criteria: *]

==== Caricamento DDT<uc:caricamento-ddt>

#img(
  "UC/UC1.png",
  caption: [UC1: Caricamento DDT.],
  width: 70%,
  alt: "Questo diagramma dei casi d'uso rappresenta il personale che carica un DDT."
)<fig:uc1>

- Attore principale: Personale
- Scenario principale:
 + Il personale carica un DDT nel sistema
- Precondizioni:
 - Il sistema è online
 - Il personale si trova nella pagina del caricamento del DDT
- Postcondizioni:
 - Il personale può visualizzare i risultati dell'estrazione
- Trigger: Il personale vuole caricare il DDT per poi visualizzare i dati dell'estrazione

==== Visualizza dati estrazione<uc:visualizza-dati>

#img(
  "UC/UC2.png",
  caption: [UC2: Visualizza dati estrazione.],
  width: 90%,
  alt: "Questo diagramma dei casi d'uso rappresenta il personale che visualizza i dati estratti. Quest'azione include anche la visualizzazione dei dati del fornitore, la visualizzazione dei dati del destinatario, la visualizzazione della lista degli articoli, la visualizzazione dei dati dell'appendice, la visualizzazione del numero del DDT e della data."
)<fig:uc2>

- Attore principale: Personale
- Scenario principale:
 + Il personale visualizza i dati del fornitore -> Vedi @uc:visualizza-fornitore
 + Il personale visualizza i dati del destinatario -> Vedi @uc:visualizza-destinatario
 + Il personale visualizza la lista degli articoli -> Vedi @uc:visualizza-articoli
 + Il personale visualizza i dati dell'appendice del documento -> Vedi @uc:visualizza-appendice
 + Il personale visualizza il numero del DDT -> Vedi @uc:visualizza-numero
 + Il personale visualizza la data del DDT -> Vedi @uc:visualizza-data
- Precondizioni:
 - Il sistema è online
 - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
- Postcondizioni:
 - Il personale ha visualizzato i dati estratti
- Inclusioni:
  - @uc:visualizza-fornitore
  - @uc:visualizza-destinatario
  - @uc:visualizza-articoli
  - @uc:visualizza-appendice
  - @uc:visualizza-numero
  - @uc:visualizza-data
- Trigger: Il personale vuole visualizzare i dati estratti al caricamento del DDT

===== Visualizza dati fornitore<uc:visualizza-fornitore>

#img(
  "UC/UC2.1.png",
  caption: [UC2.1: Visualizza dati fornitore.],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati del fornitore, nello specifico visualizza la ragione sociale, l'indirizzo e la partita IVA."
)<fig:uc2.1>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del fornitore -> Vedi @uc:visualizza-fornitore-ragione-sociale
  + Il personale visualizza l'indirizzo del fornitore -> Vedi @uc:visualizza-fornitore-indirizzo
  + Il personale visualizza la partita IVA del fornitore -> Vedi @uc:visualizza-fornitore-piva
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati del fornitore
- Inclusioni:
  - @uc:visualizza-fornitore-ragione-sociale
  - @uc:visualizza-fornitore-indirizzo
  - @uc:visualizza-fornitore-piva
- Trigger: Il personale vuole visualizzare i dati del fornitore estratti dal DDT

====== Visualizza ragione sociale fornitore<uc:visualizza-fornitore-ragione-sociale>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizza-fornitore
- Postcondizioni:
  - Il personale ha visualizzato la ragione sociale del fornitore
- Trigger: Il personale vuole visualizzare la ragione sociale del fornitore estratta dal DDT

====== Visualizza indirizzo fornitore<uc:visualizza-fornitore-indirizzo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza l'indirizzo del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizza-fornitore
- Postcondizioni:
  - Il personale ha visualizzato l'indirizzo del fornitore
- Trigger: Il personale vuole visualizzare l'indirizzo del fornitore estratto dal DDT

====== Visualizza partita IVA fornitore<uc:visualizza-fornitore-piva>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la partita IVA del fornitore
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del fornitore -> Vedi @uc:visualizza-fornitore
- Postcondizioni:
  - Il personale ha visualizzato la partita IVA del fornitore
- Trigger: Il personale vuole visualizzare la partita IVA del fornitore estratta dal DDT

===== Visualizza dati destinatario<uc:visualizza-destinatario>

#img(
  "UC/UC2.2.png",
  caption: [UC2.2: Visualizza dati destinatario.],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati del destinatario, nello specifico visualizza la ragione sociale, l'indirizzo e la partita IVA."
)<fig:uc2.2>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del destinatario -> Vedi @uc:visualizza-destinatario-ragione-sociale
  + Il personale visualizza l'indirizzo del destinatario -> Vedi @uc:visualizza-destinatario-indirizzo
  + Il personale visualizza la partita IVA del destinatario -> Vedi @uc:visualizza-destinatario-piva
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati del destinatario
- Inclusioni:
  - @uc:visualizza-destinatario-ragione-sociale
  - @uc:visualizza-destinatario-indirizzo
  - @uc:visualizza-destinatario-piva
- Trigger: Il personale vuole visualizzare i dati del destinatario estratti dal DDT

====== Visualizza ragione sociale destinatario<uc:visualizza-destinatario-ragione-sociale>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la ragione sociale del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizza-destinatario
- Postcondizioni:
  - Il personale ha visualizzato la ragione sociale del destinatario
- Trigger: Il personale vuole visualizzare la ragione sociale del destinatario estratta dal DDT

====== Visualizza indirizzo destinatario<uc:visualizza-destinatario-indirizzo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza l'indirizzo del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizza-destinatario
- Postcondizioni:
  - Il personale ha visualizzato l'indirizzo del destinatario
- Trigger: Il personale vuole visualizzare l'indirizzo del destinatario estratto dal DDT

====== Visualizza partita IVA destinatario<uc:visualizza-destinatario-piva>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la partita IVA del destinatario
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati del destinatario -> Vedi @uc:visualizza-destinatario
- Postcondizioni:
  - Il personale ha visualizzato la partita IVA del destinatario
- Trigger: Il personale vuole visualizzare la partita IVA del destinatario estratta dal DDT

===== Visualizza lista articoli<uc:visualizza-articoli>

#img(
  "UC/UC2.3.png",
  caption: [UC2.3: Visualizza lista articoli.],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza la lista degli articoli, la cui azione include il visualizzare il singolo articolo, Quest'ultima include la visualizzazione del codice dell'articolo, la sua descrizione, la quantità, il riferimento al codice dell'ordine e la misura di unità dell'articolo."
)<fig:uc2.3>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la lista degli articoli
  + Per ogni articolo, il personale visualizza il singolo articolo -> Vedi @uc:visualizza-singolo-articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato la lista degli articoli estratti dal DDT
- Inclusioni:
  - @uc:visualizza-singolo-articolo
- Trigger: Il personale vuole visualizzare gli articoli estratti dal DDT

====== Visualizza dati articolo singolo<uc:visualizza-singolo-articolo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il codice dell'articolo -> Vedi @uc:visualizza-articolo-codice
  + Il personale visualizza la descrizione dell'articolo -> Vedi @uc:visualizza-articolo-descrizione
  + Il personale visualizza la quantità dell'articolo -> Vedi @uc:visualizza-articolo-quantita
  + Il personale visualizza il riferimento al codice ordine dell'articolo -> Vedi @uc:visualizza-articolo-ordine
  + Il personale visualizza la misura di unità dell'articolo -> Vedi @uc:visualizza-articolo-unita
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
- Postcondizioni:
  - Il personale ha visualizzato i dati del singolo articolo
- Inclusioni:
  - @uc:visualizza-articolo-codice
  - @uc:visualizza-articolo-descrizione
  - @uc:visualizza-articolo-quantita
  - @uc:visualizza-articolo-ordine
  - @uc:visualizza-articolo-unita
- Trigger: Il personale vuole visualizzare i dati di un articolo estratto dal DDT

======= Visualizza codice articolo<uc:visualizza-articolo-codice>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il codice dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizza-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato il codice dell'articolo
- Trigger: Il personale vuole visualizzare il codice dell'articolo estratto dal DDT

======= Visualizza descrizione articolo<uc:visualizza-articolo-descrizione>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la descrizione dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizza-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la descrizione dell'articolo
- Trigger: Il personale vuole visualizzare la descrizione dell'articolo estratta dal DDT

======= Visualizza quantità articolo<uc:visualizza-articolo-quantita>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la quantità dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizza-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la quantità dell'articolo
- Trigger: Il personale vuole visualizzare la quantità dell'articolo estratta dal DDT

======= Visualizza riferimento codice ordine<uc:visualizza-articolo-ordine>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il riferimento al codice ordine dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizza-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato il riferimento al codice ordine dell'articolo
- Trigger: Il personale vuole visualizzare il riferimento al codice ordine dell'articolo estratto dal DDT

======= Visualizza misura di unità articolo<uc:visualizza-articolo-unita>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la misura di unità dell'articolo
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando la lista degli articoli -> Vedi @uc:visualizza-articoli
  - Il personale sta visualizzando i dati di un articolo singolo -> Vedi @uc:visualizza-singolo-articolo
- Postcondizioni:
  - Il personale ha visualizzato la misura di unità dell'articolo
- Trigger: Il personale vuole visualizzare la misura di unità dell'articolo estratta dal DDT

===== Visualizza dati appendice documento<uc:visualizza-appendice>

#img(
  "UC/UC2.4.png",
  caption: [UC2.4: Visualizza dati appendice documento.],
  alt: "Questo diagramma dei casi d'uso mostra il personale che visualizza i dati dell'appendice del documento. Questo include la visualizzazione delle note (annotazioni), la visualizzazione del numero colli, la visualizzazione del peso netto e la visualizzazione del peso lordo."
)<fig:uc2.4>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza le note del documento -> Vedi @uc:visualizza-appendice-note
  + Il personale visualizza il numero di colli -> Vedi @uc:visualizza-appendice-colli
  + Il personale visualizza il peso lordo -> Vedi @uc:visualizza-appendice-peso-lordo
  + Il personale visualizza il peso netto -> Vedi @uc:visualizza-appendice-peso-netto
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato i dati dell'appendice del documento
- Inclusioni:
  - @uc:visualizza-appendice-note
  - @uc:visualizza-appendice-colli
  - @uc:visualizza-appendice-peso-lordo
  - @uc:visualizza-appendice-peso-netto
- Trigger: Il personale vuole visualizzare i dati dell'appendice estratti dal DDT

====== Visualizza note<uc:visualizza-appendice-note>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza le note presenti nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizza-appendice
- Postcondizioni:
  - Il personale ha visualizzato le note del documento
- Trigger: Il personale vuole visualizzare le note estratte dal DDT

====== Visualizza numero colli<uc:visualizza-appendice-colli>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il numero di colli indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizza-appendice
- Postcondizioni:
  - Il personale ha visualizzato il numero di colli
- Trigger: Il personale vuole visualizzare il numero di colli estratto dal DDT

====== Visualizza peso netto<uc:visualizza-appendice-peso-netto>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il peso netto indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizza-appendice
- Postcondizioni:
  - Il personale ha visualizzato il peso netto
- Trigger: Il personale vuole visualizzare il peso netto estratto dal DDT

====== Visualizza peso lordo<uc:visualizza-appendice-peso-lordo>

- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il peso lordo indicato nel documento
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
  - Il personale sta visualizzando i dati dell'appendice del documento -> Vedi @uc:visualizza-appendice
- Postcondizioni:
  - Il personale ha visualizzato il peso lordo
- Trigger: Il personale vuole visualizzare il peso lordo estratto dal DDT

===== Visualizza numero DDT<uc:visualizza-numero>
- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza il numero del DDT
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato il numero del DDT
- Trigger: Il personale vuole visualizzare il numero del DDT

===== Visualizza data DDT<uc:visualizza-data>
- Attore principale: Personale
- Scenario principale:
  + Il personale visualizza la data del DDT
- Precondizioni:
  - Il sistema è online
  - Il personale ha caricato un DDT -> Vedi @uc:caricamento-ddt
  - Il personale sta visualizzando i dati estratti -> Vedi @uc:visualizza-dati
- Postcondizioni:
  - Il personale ha visualizzato la data del DDT
- Trigger: Il personale vuole visualizzare la data estratta dal DDT

==== Creazione template<uc:creazione-template>

#img(
  "UC/UC3.png",
  caption: [UC3: Creazione template.],
  alt: "Questo diagramma dei casi d'uso mostra il caso d'uso della creazione del template. Mostra le inclusioni dei casi d'uso di caricamento PDF di riferimento, l'inserimento del nome del fornitore, le operazioni sui rettangoli, l'inserimento delle parole di riepilogo, l'inserimento delle parole da ignorare, l'indicazione della posizione della quantità, il salvataggio del template, la configurazione delle parole chiave e la rotazione del PDF."
)

- Attore principale: Personale
- Scenario principale:
 + Il personale carica il PDF di riferimento -> Vedi @uc:caricamento-pdf
 + Il personale inserisce il nome del fornitore -> Vedi @uc:inserimento-nome-fornitore
 + Il personale effettua le operazioni sui rettangoli del template -> Vedi @uc:operazione-rettangoli
 + Il personale inserisce le parole per il riepilogo -> Vedi @uc:inserimento-parole-riepilogo
 + Il personale inserisce le parole da ignorare -> Vedi @uc:inserimento-parole-ignorare
 + Il personale indica la posizione della quantità -> Vedi @uc:indicazione-quantita
 + Il personale salva il template -> Vedi @uc:salvataggio-template
 + Il personale configura le parole chiave -> Vedi @uc:configurazione-parole-chiave
 + Il personale ruota, se necessario, il PDF per creare il template -> Vedi @uc:rotazione
- Precondizioni:
 - Il sistema è online
- Postcondizioni:
 - Il personale ha creato il template del DDT
- Inclusioni:
  - @uc:caricamento-pdf
  - @uc:inserimento-nome-fornitore
  - @uc:operazione-rettangoli
  - @uc:inserimento-parole-riepilogo
  - @uc:inserimento-parole-ignorare
  - @uc:indicazione-quantita
  - @uc:salvataggio-template
  - @uc:configurazione-parole-chiave
  - @uc:rotazione
- Trigger: Il personale vuole creare un nuovo template per il DDT

===== Caricamento PDF di riferimento<uc:caricamento-pdf>

- Attore principale: Personale
- Scenario principale:
 + Il personale carica il PDF di riferimento
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
- Postcondizioni:
 - Il PDF di riferimento è stato caricato
- Trigger: Il personale vuole caricare un PDF come riferimento per il template

===== Inserimento nome fornitore<uc:inserimento-nome-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce il nome del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha inserito il nome del fornitore
- Trigger: Il personale vuole inserire il nome del fornitore per il template

===== Operazioni sui rettangoli<uc:operazione-rettangoli>

Nella seguente figura, è mostrato il diagramma dei casi d'uso per l'operazione sui rettangoli. È evidenziato il caso d'uso @uc:creazione-rettangolo-ancora poiché è l'unico che ha un'inclusione. Tutti gli altri diagrammi dei casi d'uso sono omessi, in quanto ogni operazione su ogni rettangolo si generalizza in creazione, modifica ed eliminazione.

#img(
  "UC/UC3.3.png",
  caption: [UC3.3: Operazioni sui rettangoli.],
  alt: "Questo diagramma rappresenta le operazioni possibili sui rettangoli. Infatti, le operazioni sui rettangoli si generalizzano in creazione, modifica ed eliminazione. Nel caso specifico dell'ancora rappresentato in figura, la creazione del rettangolo include l'inserimento del nome dell'ancora."
)

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua le operazioni sui rettangoli
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Inclusioni:
  - @uc:operazione-rettangolo-ancora
  - @uc:operazione-rettangolo-intestazione
  - @uc:operazione-rettangolo-corpo
  - @uc:operazione-rettangolo-appendice
  - @uc:operazione-rettangolo-numero
  - @uc:operazione-rettangolo-data
  - @uc:operazione-rettangolo-ragione-fornitore
  - @uc:operazione-rettangolo-partitaIVA-fornitore
  - @uc:operazione-rettangolo-indirizzo-fornitore
  - @uc:operazione-rettangolo-ragione-destinatario
  - @uc:operazione-rettangolo-partitaIVA-destinatario
  - @uc:operazione-rettangolo-indirizzo-destinatario
  - @uc:operazione-rettangolo-prima-unita
  - @uc:operazione-rettangolo-prima-quantita
  - @uc:operazione-rettangolo-primo-codice
  - @uc:operazione-rettangolo-prima-descrizione
  - @uc:operazione-rettangolo-primo-riferimento
  - @uc:operazione-rettangolo-riga-campione
  - @uc:operazione-rettangolo-intestazione-colonne
  - @uc:operazione-rettangolo-colli
  - @uc:operazione-rettangolo-note
  - @uc:operazione-rettangolo-peso-lordo
  - @uc:operazione-rettangolo-peso-netto
- Trigger: Il personale vuole operare sui rettangoli per creare il template

====== Operazione sul rettangolo ancora<uc:operazione-rettangolo-ancora>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'ancora
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-ancora
  - @uc:modifica-rettangolo-ancora
  - @uc:eliminazione-rettangolo-ancora
- Trigger: Il personale vuole operare sul rettangolo dell'ancora

======= Creazione rettangolo ancora<uc:creazione-rettangolo-ancora>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'ancora
 + Il personale inserisce il nome dell'ancora -> Vedi @uc:inserimento-nome-ancora
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'ancora
- Inclusioni:
  - @uc:inserimento-nome-ancora
- Trigger: Il personale vuole creare il rettangolo dell'ancora nel template

======== Inserimento nome ancora<uc:inserimento-nome-ancora>

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce il nome dell'ancora
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il personale ha creato il rettangolo dell'ancora -> Vedi @uc:creazione-rettangolo-ancora
- Postcondizioni:
 - Il personale ha inserito il nome dell'ancora
- Trigger: Il personale vuole inserire il nome dell'ancora

======= Modifica rettangolo ancora<uc:modifica-rettangolo-ancora>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'ancora
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'ancora è stato creato -> Vedi @uc:creazione-rettangolo-ancora
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'ancora
- Trigger: Il personale vuole modificare il rettangolo dell'ancora

======= Eliminazione rettangolo ancora<uc:eliminazione-rettangolo-ancora>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'ancora
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'ancora è stato creato -> Vedi @uc:creazione-rettangolo-ancora
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'ancora
- Trigger: Il personale vuole eliminare il rettangolo dell'ancora

====== Operazione sul rettangolo intestazione<uc:operazione-rettangolo-intestazione>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'intestazione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-intestazione
  - @uc:modifica-rettangolo-intestazione
  - @uc:eliminazione-rettangolo-intestazione
- Trigger: Il personale vuole operare sul rettangolo dell'intestazione

======= Creazione rettangolo intestazione<uc:creazione-rettangolo-intestazione>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'intestazione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'intestazione
- Trigger: Il personale vuole creare il rettangolo dell'intestazione

======= Modifica rettangolo intestazione<uc:modifica-rettangolo-intestazione>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'intestazione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'intestazione è stato creato -> Vedi @uc:creazione-rettangolo-intestazione
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'intestazione
- Trigger: Il personale vuole modificare il rettangolo dell'intestazione

======= Eliminazione rettangolo intestazione<uc:eliminazione-rettangolo-intestazione>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'intestazione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'intestazione è stato creato -> Vedi @uc:creazione-rettangolo-intestazione
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'intestazione
- Trigger: Il personale vuole eliminare il rettangolo dell'intestazione

====== Operazione sul rettangolo corpo<uc:operazione-rettangolo-corpo>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del corpo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-corpo
  - @uc:modifica-rettangolo-corpo
  - @uc:eliminazione-rettangolo-corpo
- Trigger: Il personale vuole operare sul rettangolo del corpo

======= Creazione rettangolo corpo<uc:creazione-rettangolo-corpo>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del corpo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del corpo
- Trigger: Il personale vuole creare il rettangolo del corpo

======= Modifica rettangolo corpo<uc:modifica-rettangolo-corpo>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del corpo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del corpo è stato creato -> Vedi @uc:creazione-rettangolo-corpo
- Postcondizioni:
 - Il personale ha modificato il rettangolo del corpo
- Trigger: Il personale vuole modificare il rettangolo del corpo

======= Eliminazione rettangolo corpo<uc:eliminazione-rettangolo-corpo>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del corpo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del corpo è stato creato -> Vedi @uc:creazione-rettangolo-corpo
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del corpo
- Trigger: Il personale vuole eliminare il rettangolo del corpo

====== Operazione sul rettangolo appendice<uc:operazione-rettangolo-appendice>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'appendice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-appendice
  - @uc:modifica-rettangolo-appendice
  - @uc:eliminazione-rettangolo-appendice
- Trigger: Il personale vuole operare sul rettangolo dell'appendice

======= Creazione rettangolo appendice<uc:creazione-rettangolo-appendice>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'appendice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'appendice
- Trigger: Il personale vuole creare il rettangolo dell'appendice

======= Modifica rettangolo appendice<uc:modifica-rettangolo-appendice>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'appendice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'appendice è stato creato -> Vedi @uc:creazione-rettangolo-appendice
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'appendice
- Trigger: Il personale vuole modificare il rettangolo dell'appendice

======= Eliminazione rettangolo appendice<uc:eliminazione-rettangolo-appendice>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'appendice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'appendice è stato creato -> Vedi @uc:creazione-rettangolo-appendice
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'appendice
- Trigger: Il personale vuole eliminare il rettangolo dell'appendice

====== Operazione sul rettangolo numero DDT<uc:operazione-rettangolo-numero>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del numero DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-numero
  - @uc:modifica-rettangolo-numero
  - @uc:eliminazione-rettangolo-numero
- Trigger: Il personale vuole operare sul rettangolo del numero DDT

======= Creazione rettangolo numero DDT<uc:creazione-rettangolo-numero>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del numero DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del numero DDT
- Trigger: Il personale vuole creare il rettangolo del numero DDT

======= Modifica rettangolo numero DDT<uc:modifica-rettangolo-numero>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del numero DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del numero del DDT è stato creato -> Vedi @uc:creazione-rettangolo-numero
- Postcondizioni:
 - Il personale ha modificato il rettangolo del numero DDT
- Trigger: Il personale vuole modificare il rettangolo del numero DDT

======= Eliminazione rettangolo numero DDT<uc:eliminazione-rettangolo-numero>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del numero DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del numero del DDT è stato creato -> Vedi @uc:creazione-rettangolo-numero
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del numero DDT
- Trigger: Il personale vuole eliminare il rettangolo del numero DDT

====== Operazione sul rettangolo data DDT<uc:operazione-rettangolo-data>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della data DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-data
  - @uc:modifica-rettangolo-data
  - @uc:eliminazione-rettangolo-data
- Trigger: Il personale vuole operare sul rettangolo della data DDT

======= Creazione rettangolo data DDT<uc:creazione-rettangolo-data>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della data DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della data DDT
- Trigger: Il personale vuole creare il rettangolo della data DDT

======= Modifica rettangolo data DDT<uc:modifica-rettangolo-data>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della data DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della data del DDT è stato creato -> Vedi @uc:creazione-rettangolo-data
- Postcondizioni:
 - Il personale ha modificato il rettangolo della data DDT
- Trigger: Il personale vuole modificare il rettangolo della data DDT

======= Eliminazione rettangolo data DDT<uc:eliminazione-rettangolo-data>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della data DDT
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della data del DDT è stato creato -> Vedi @uc:creazione-rettangolo-data
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della data DDT
- Trigger: Il personale vuole eliminare il rettangolo della data DDT

====== Operazione sul rettangolo ragione sociale fornitore<uc:operazione-rettangolo-ragione-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della ragione sociale del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-ragione-fornitore
  - @uc:modifica-rettangolo-ragione-fornitore
  - @uc:eliminazione-rettangolo-ragione-fornitore
- Trigger: Il personale vuole operare sul rettangolo della ragione sociale del fornitore

======= Creazione rettangolo ragione sociale fornitore<uc:creazione-rettangolo-ragione-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della ragione sociale del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della ragione sociale del fornitore
- Trigger: Il personale vuole creare il rettangolo della ragione sociale del fornitore

======= Modifica rettangolo ragione sociale fornitore<uc:modifica-rettangolo-ragione-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della ragione sociale del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della ragione sociale del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-ragione-fornitore
- Postcondizioni:
 - Il personale ha modificato il rettangolo della ragione sociale del fornitore
- Trigger: Il personale vuole modificare il rettangolo della ragione sociale del fornitore

======= Eliminazione rettangolo ragione sociale fornitore<uc:eliminazione-rettangolo-ragione-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della ragione sociale del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della ragione sociale del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-ragione-fornitore
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della ragione sociale del fornitore
- Trigger: Il personale vuole eliminare il rettangolo della ragione sociale del fornitore

====== Operazione sul rettangolo partita IVA fornitore<uc:operazione-rettangolo-partitaIVA-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della partita IVA del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-partitaIVA-fornitore
  - @uc:modifica-rettangolo-partitaIVA-fornitore
  - @uc:eliminazione-rettangolo-partitaIVA-fornitore
- Trigger: Il personale vuole operare sul rettangolo della partita IVA del fornitore

======= Creazione rettangolo partita IVA fornitore<uc:creazione-rettangolo-partitaIVA-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della partita IVA del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della partita IVA del fornitore
- Trigger: Il personale vuole creare il rettangolo della partita IVA del fornitore

======= Modifica rettangolo partita IVA fornitore<uc:modifica-rettangolo-partitaIVA-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della partita IVA del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della partita IVA del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-partitaIVA-fornitore
- Postcondizioni:
 - Il personale ha modificato il rettangolo della partita IVA del fornitore
- Trigger: Il personale vuole modificare il rettangolo della partita IVA del fornitore

======= Eliminazione rettangolo partita IVA fornitore<uc:eliminazione-rettangolo-partitaIVA-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della partita IVA del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della partita IVA del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-partitaIVA-fornitore
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della partita IVA del fornitore
- Trigger: Il personale vuole eliminare il rettangolo della partita IVA del fornitore

====== Operazione sul rettangolo indirizzo fornitore<uc:operazione-rettangolo-indirizzo-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'indirizzo del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-indirizzo-fornitore
  - @uc:modifica-rettangolo-indirizzo-fornitore
  - @uc:eliminazione-rettangolo-indirizzo-fornitore
- Trigger: Il personale vuole operare sul rettangolo dell'indirizzo del fornitore

======= Creazione rettangolo indirizzo fornitore<uc:creazione-rettangolo-indirizzo-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'indirizzo del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'indirizzo del fornitore
- Trigger: Il personale vuole creare il rettangolo dell'indirizzo del fornitore

======= Modifica rettangolo indirizzo fornitore<uc:modifica-rettangolo-indirizzo-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'indirizzo del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'indirizzo del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-indirizzo-fornitore
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'indirizzo del fornitore
- Trigger: Il personale vuole modificare il rettangolo dell'indirizzo del fornitore

======= Eliminazione rettangolo indirizzo fornitore<uc:eliminazione-rettangolo-indirizzo-fornitore>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'indirizzo del fornitore
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'indirizzo del fornitore è stato creato -> Vedi @uc:creazione-rettangolo-indirizzo-fornitore
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'indirizzo del fornitore
- Trigger: Il personale vuole eliminare il rettangolo dell'indirizzo del fornitore

====== Operazione sul rettangolo ragione sociale destinatario<uc:operazione-rettangolo-ragione-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della ragione sociale del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-ragione-destinatario
  - @uc:modifica-rettangolo-ragione-destinatario
  - @uc:eliminazione-rettangolo-ragione-destinatario
- Trigger: Il personale vuole operare sul rettangolo della ragione sociale del destinatario

======= Creazione rettangolo ragione sociale destinatario<uc:creazione-rettangolo-ragione-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della ragione sociale del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della ragione sociale del destinatario
- Trigger: Il personale vuole creare il rettangolo della ragione sociale del destinatario

======= Modifica rettangolo ragione sociale destinatario<uc:modifica-rettangolo-ragione-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della ragione sociale del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della ragione sociale del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-ragione-destinatario
- Postcondizioni:
 - Il personale ha modificato il rettangolo della ragione sociale del destinatario
- Trigger: Il personale vuole modificare il rettangolo della ragione sociale del destinatario

======= Eliminazione rettangolo ragione sociale destinatario<uc:eliminazione-rettangolo-ragione-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della ragione sociale del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della ragione sociale del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-ragione-destinatario
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della ragione sociale del destinatario
- Trigger: Il personale vuole eliminare il rettangolo della ragione sociale del destinatario

====== Operazione sul rettangolo partita IVA destinatario<uc:operazione-rettangolo-partitaIVA-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della partita IVA del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-partitaIVA-destinatario
  - @uc:modifica-rettangolo-partitaIVA-destinatario
  - @uc:eliminazione-rettangolo-partitaIVA-destinatario
- Trigger: Il personale vuole operare sul rettangolo della partita IVA del destinatario

======= Creazione rettangolo partita IVA destinatario<uc:creazione-rettangolo-partitaIVA-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della partita IVA del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della partita IVA del destinatario
- Trigger: Il personale vuole creare il rettangolo della partita IVA del destinatario

======= Modifica rettangolo partita IVA destinatario<uc:modifica-rettangolo-partitaIVA-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della partita IVA del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della partita IVA del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-partitaIVA-destinatario
- Postcondizioni:
 - Il personale ha modificato il rettangolo della partita IVA del destinatario
- Trigger: Il personale vuole modificare il rettangolo della partita IVA del destinatario

======= Eliminazione rettangolo partita IVA destinatario<uc:eliminazione-rettangolo-partitaIVA-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della partita IVA del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della partita IVA del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-partitaIVA-destinatario
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della partita IVA del destinatario
- Trigger: Il personale vuole eliminare il rettangolo della partita IVA del destinatario

====== Operazione sul rettangolo indirizzo destinatario<uc:operazione-rettangolo-indirizzo-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'indirizzo del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-indirizzo-destinatario
  - @uc:modifica-rettangolo-indirizzo-destinatario
  - @uc:eliminazione-rettangolo-indirizzo-destinatario
- Trigger: Il personale vuole operare sul rettangolo dell'indirizzo del destinatario

======= Creazione rettangolo indirizzo destinatario<uc:creazione-rettangolo-indirizzo-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'indirizzo del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'indirizzo del destinatario
- Trigger: Il personale vuole creare il rettangolo dell'indirizzo del destinatario

======= Modifica rettangolo indirizzo destinatario<uc:modifica-rettangolo-indirizzo-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'indirizzo del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'indirizzo del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-indirizzo-destinatario
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'indirizzo del destinatario
- Trigger: Il personale vuole modificare il rettangolo dell'indirizzo del destinatario

======= Eliminazione rettangolo indirizzo destinatario<uc:eliminazione-rettangolo-indirizzo-destinatario>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'indirizzo del destinatario
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'indirizzo del destinatario è stato creato -> Vedi @uc:creazione-rettangolo-indirizzo-destinatario
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'indirizzo del destinatario
- Trigger: Il personale vuole eliminare il rettangolo dell'indirizzo del destinatario

====== Operazione sul rettangolo prima unità<uc:operazione-rettangolo-prima-unita>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della prima unità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-prima-unita
  - @uc:modifica-rettangolo-prima-unita
  - @uc:eliminazione-rettangolo-prima-unita
- Trigger: Il personale vuole operare sul rettangolo della prima unità

======= Creazione rettangolo prima unità<uc:creazione-rettangolo-prima-unita>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della prima unità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della prima unità
- Trigger: Il personale vuole creare il rettangolo della prima unità

======= Modifica rettangolo prima unità<uc:modifica-rettangolo-prima-unita>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della prima unità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima unità del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-unita
- Postcondizioni:
 - Il personale ha modificato il rettangolo della prima unità
- Trigger: Il personale vuole modificare il rettangolo della prima unità

======= Eliminazione rettangolo prima unità<uc:eliminazione-rettangolo-prima-unita>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della prima unità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima unità del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-unita
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della prima unità
- Trigger: Il personale vuole eliminare il rettangolo della prima unità

====== Operazione sul rettangolo prima quantità<uc:operazione-rettangolo-prima-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della prima quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-prima-quantita
  - @uc:modifica-rettangolo-prima-quantita
  - @uc:eliminazione-rettangolo-prima-quantita
- Trigger: Il personale vuole operare sul rettangolo della prima quantità

======= Creazione rettangolo prima quantità<uc:creazione-rettangolo-prima-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della prima quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della prima quantità
- Trigger: Il personale vuole creare il rettangolo della prima quantità

======= Modifica rettangolo prima quantità<uc:modifica-rettangolo-prima-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della prima quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima quantità del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-quantita
- Postcondizioni:
 - Il personale ha modificato il rettangolo della prima quantità
- Trigger: Il personale vuole modificare il rettangolo della prima quantità

======= Eliminazione rettangolo prima quantità<uc:eliminazione-rettangolo-prima-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della prima quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima quantità del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-quantita
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della prima quantità
- Trigger: Il personale vuole eliminare il rettangolo della prima quantità

====== Operazione sul rettangolo primo codice<uc:operazione-rettangolo-primo-codice>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del primo codice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-primo-codice
  - @uc:modifica-rettangolo-primo-codice
  - @uc:eliminazione-rettangolo-primo-codice
- Trigger: Il personale vuole operare sul rettangolo del primo codice

======= Creazione rettangolo primo codice<uc:creazione-rettangolo-primo-codice>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del primo codice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del primo codice
- Trigger: Il personale vuole creare il rettangolo del primo codice

======= Modifica rettangolo primo codice<uc:modifica-rettangolo-primo-codice>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del primo codice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del primo codice del DDT è stato creato -> Vedi @uc:creazione-rettangolo-primo-codice
- Postcondizioni:
 - Il personale ha modificato il rettangolo del primo codice
- Trigger: Il personale vuole modificare il rettangolo del primo codice

======= Eliminazione rettangolo primo codice<uc:eliminazione-rettangolo-primo-codice>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del primo codice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del primo codice del DDT è stato creato -> Vedi @uc:creazione-rettangolo-primo-codice
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del primo codice
- Trigger: Il personale vuole eliminare il rettangolo del primo codice

====== Operazione sul rettangolo prima descrizione<uc:operazione-rettangolo-prima-descrizione>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della prima descrizione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-prima-descrizione
  - @uc:modifica-rettangolo-prima-descrizione
  - @uc:eliminazione-rettangolo-prima-descrizione
- Trigger: Il personale vuole operare sul rettangolo della prima descrizione

======= Creazione rettangolo prima descrizione<uc:creazione-rettangolo-prima-descrizione>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della prima descrizione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della prima descrizione
- Trigger: Il personale vuole creare il rettangolo della prima descrizione

======= Modifica rettangolo prima descrizione<uc:modifica-rettangolo-prima-descrizione>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della prima descrizione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima descrizione del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-descrizione
- Postcondizioni:
 - Il personale ha modificato il rettangolo della prima descrizione
- Trigger: Il personale vuole modificare il rettangolo della prima descrizione

======= Eliminazione rettangolo prima descrizione<uc:eliminazione-rettangolo-prima-descrizione>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della prima descrizione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della prima descrizione del DDT è stato creato -> Vedi @uc:creazione-rettangolo-prima-descrizione
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della prima descrizione
- Trigger: Il personale vuole eliminare il rettangolo della prima descrizione

====== Operazione sul rettangolo primo riferimento codice ordine<uc:operazione-rettangolo-primo-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del primo riferimento al codice ordine
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-primo-riferimento
  - @uc:modifica-rettangolo-primo-riferimento
  - @uc:eliminazione-rettangolo-primo-riferimento
- Trigger: Il personale vuole operare sul rettangolo del primo riferimento al codice ordine

======= Creazione rettangolo primo riferimento codice ordine<uc:creazione-rettangolo-primo-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del primo riferimento al codice ordine
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del primo riferimento al codice ordine
- Trigger: Il personale vuole creare il rettangolo del primo riferimento al codice ordine

======= Modifica rettangolo primo riferimento codice ordine<uc:modifica-rettangolo-primo-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del primo riferimento al codice ordine
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del primo riferimento codice ordine del DDT è stato creato -> Vedi @uc:creazione-rettangolo-primo-riferimento
- Postcondizioni:
 - Il personale ha modificato il rettangolo del primo riferimento al codice ordine
- Trigger: Il personale vuole modificare il rettangolo del primo riferimento al codice ordine

======= Eliminazione rettangolo primo riferimento codice ordine<uc:eliminazione-rettangolo-primo-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del primo riferimento al codice ordine
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del primo riferimento codice ordine del DDT è stato creato -> Vedi @uc:creazione-rettangolo-primo-riferimento
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del primo riferimento al codice ordine
- Trigger: Il personale vuole eliminare il rettangolo del primo riferimento al codice ordine

====== Operazione sul rettangolo riga campione<uc:operazione-rettangolo-riga-campione>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo della riga campione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-riga-campione
  - @uc:modifica-rettangolo-riga-campione
  - @uc:eliminazione-rettangolo-riga-campione
- Trigger: Il personale vuole operare sul rettangolo della riga campione

======= Creazione rettangolo riga campione<uc:creazione-rettangolo-riga-campione>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo della riga campione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo della riga campione
- Trigger: Il personale vuole creare il rettangolo della riga campione

======= Modifica rettangolo riga campione<uc:modifica-rettangolo-riga-campione>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo della riga campione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della riga campione del DDT è stato creato -> Vedi @uc:creazione-rettangolo-riga-campione
- Postcondizioni:
 - Il personale ha modificato il rettangolo della riga campione
- Trigger: Il personale vuole modificare il rettangolo della riga campione

======= Eliminazione rettangolo riga campione<uc:eliminazione-rettangolo-riga-campione>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo della riga campione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo della riga campione del DDT è stato creato -> Vedi @uc:creazione-rettangolo-riga-campione
- Postcondizioni:
 - Il personale ha eliminato il rettangolo della riga campione
- Trigger: Il personale vuole eliminare il rettangolo della riga campione

====== Operazione sul rettangolo intestazione colonne<uc:operazione-rettangolo-intestazione-colonne>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo dell'intestazione colonne
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-intestazione-colonne
  - @uc:modifica-rettangolo-intestazione-colonne
  - @uc:eliminazione-rettangolo-intestazione-colonne
- Trigger: Il personale vuole operare sul rettangolo dell'intestazione colonne

======= Creazione rettangolo intestazione colonne<uc:creazione-rettangolo-intestazione-colonne>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo dell'intestazione colonne
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo dell'intestazione colonne
- Trigger: Il personale vuole creare il rettangolo dell'intestazione colonne

======= Modifica rettangolo intestazione colonne<uc:modifica-rettangolo-intestazione-colonne>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo dell'intestazione colonne
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'intestazione colonne del DDT è stato creato -> Vedi @uc:creazione-rettangolo-intestazione-colonne
- Postcondizioni:
 - Il personale ha modificato il rettangolo dell'intestazione colonne
- Trigger: Il personale vuole modificare il rettangolo dell'intestazione colonne

======= Eliminazione rettangolo intestazione colonne<uc:eliminazione-rettangolo-intestazione-colonne>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo dell'intestazione colonne
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo dell'intestazione colonne del DDT è stato creato -> Vedi @uc:creazione-rettangolo-intestazione-colonne
- Postcondizioni:
 - Il personale ha eliminato il rettangolo dell'intestazione colonne
- Trigger: Il personale vuole eliminare il rettangolo dell'intestazione colonne

====== Operazione sul rettangolo numero colli<uc:operazione-rettangolo-colli>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del numero colli
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-colli
  - @uc:modifica-rettangolo-colli
  - @uc:eliminazione-rettangolo-colli
- Trigger: Il personale vuole operare sul rettangolo del numero colli

======= Creazione rettangolo numero colli<uc:creazione-rettangolo-colli>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del numero colli
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del numero colli
- Trigger: Il personale vuole creare il rettangolo del numero colli

======= Modifica rettangolo numero colli<uc:modifica-rettangolo-colli>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del numero colli
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del numero colli del DDT è stato creato -> Vedi @uc:creazione-rettangolo-colli
- Postcondizioni:
 - Il personale ha modificato il rettangolo del numero colli
- Trigger: Il personale vuole modificare il rettangolo del numero colli

======= Eliminazione rettangolo numero colli<uc:eliminazione-rettangolo-colli>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del numero colli
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del numero colli del DDT è stato creato -> Vedi @uc:creazione-rettangolo-colli
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del numero colli
- Trigger: Il personale vuole eliminare il rettangolo del numero colli

====== Operazione sul rettangolo note<uc:operazione-rettangolo-note>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo delle note
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-note
  - @uc:modifica-rettangolo-note
  - @uc:eliminazione-rettangolo-note
- Trigger: Il personale vuole operare sul rettangolo delle note

======= Creazione rettangolo note<uc:creazione-rettangolo-note>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo delle note
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo delle note
- Trigger: Il personale vuole creare il rettangolo delle note

======= Modifica rettangolo note<uc:modifica-rettangolo-note>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo delle note
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo delle note del DDT è stato creato -> Vedi @uc:creazione-rettangolo-note
- Postcondizioni:
 - Il personale ha modificato il rettangolo delle note
- Trigger: Il personale vuole modificare il rettangolo delle note

======= Eliminazione rettangolo note<uc:eliminazione-rettangolo-note>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo delle note
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo delle note del DDT è stato creato -> Vedi @uc:creazione-rettangolo-note
- Postcondizioni:
 - Il personale ha eliminato il rettangolo delle note
- Trigger: Il personale vuole eliminare il rettangolo delle note

====== Operazione sul rettangolo peso lordo<uc:operazione-rettangolo-peso-lordo>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del peso lordo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-peso-lordo
  - @uc:modifica-rettangolo-peso-lordo
  - @uc:eliminazione-rettangolo-peso-lordo
- Trigger: Il personale vuole operare sul rettangolo del peso lordo

======= Creazione rettangolo peso lordo<uc:creazione-rettangolo-peso-lordo>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del peso lordo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del peso lordo
- Trigger: Il personale vuole creare il rettangolo del peso lordo

======= Modifica rettangolo peso lordo<uc:modifica-rettangolo-peso-lordo>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del peso lordo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del peso lordo del DDT è stato creato -> Vedi @uc:creazione-rettangolo-peso-lordo
- Postcondizioni:
 - Il personale ha modificato il rettangolo del peso lordo
- Trigger: Il personale vuole modificare il rettangolo del peso lordo

======= Eliminazione rettangolo peso lordo<uc:eliminazione-rettangolo-peso-lordo>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del peso lordo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del peso lordo del DDT è stato creato -> Vedi @uc:creazione-rettangolo-peso-lordo
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del peso lordo
- Trigger: Il personale vuole eliminare il rettangolo del peso lordo

====== Operazione sul rettangolo peso netto<uc:operazione-rettangolo-peso-netto>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua un'operazione sul rettangolo del peso netto
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:creazione-rettangolo-peso-netto
  - @uc:modifica-rettangolo-peso-netto
  - @uc:eliminazione-rettangolo-peso-netto
- Trigger: Il personale vuole operare sul rettangolo del peso netto

======= Creazione rettangolo peso netto<uc:creazione-rettangolo-peso-netto>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea il rettangolo del peso netto
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato il rettangolo del peso netto
- Trigger: Il personale vuole creare il rettangolo del peso netto

======= Modifica rettangolo peso netto<uc:modifica-rettangolo-peso-netto>

- Attore principale: Personale
- Scenario principale:
 + Il personale modifica il rettangolo del peso netto
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del peso netto del DDT è stato creato -> Vedi @uc:creazione-rettangolo-peso-netto
- Postcondizioni:
 - Il personale ha modificato il rettangolo del peso netto
- Trigger: Il personale vuole modificare il rettangolo del peso netto

======= Eliminazione rettangolo peso netto<uc:eliminazione-rettangolo-peso-netto>

- Attore principale: Personale
- Scenario principale:
 + Il personale elimina il rettangolo del peso netto
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il rettangolo del peso netto del DDT è stato creato -> Vedi @uc:creazione-rettangolo-peso-netto
- Postcondizioni:
 - Il personale ha eliminato il rettangolo del peso netto
- Trigger: Il personale vuole eliminare il rettangolo del peso netto

===== Inserimento parole riepilogo<uc:inserimento-parole-riepilogo>

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce le parole per il riepilogo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha inserito le parole per il riepilogo
- Trigger: Il personale vuole inserire le parole per il riepilogo del template

===== Inserimento parole da ignorare<uc:inserimento-parole-ignorare>

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce le parole da ignorare
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha inserito le parole da ignorare
- Trigger: Il personale vuole inserire le parole da ignorare per il template

===== Indicazione posizione quantità<uc:indicazione-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale indica la posizione della quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha indicato la posizione della quantità
- Trigger: Il personale vuole indicare la posizione della quantità nel template

===== Salvataggio template<uc:salvataggio-template>

#img(
  "UC/UC3.7.png",
  caption: [UC3.7: Salvataggio template.],
  alt: "Questo diagramma dei casi d'uso rappresenta il caso d'uso di salvataggio di un template. Si generalizza nei casi d'uso di salvataggio di template nuovo ed esistente. Quest'ultimo si generalizza ulteriormente nella sovrascrittura del template esistente e nella creazione della variante del template."
)

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua il salvataggio del template
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:salvataggio-template-nuovo
  - @uc:salvataggio-template-esistente
- Trigger: Il personale vuole salvare il template

====== Salvataggio template nuovo<uc:salvataggio-template-nuovo>

- Attore principale: Personale
- Scenario principale:
 + Il personale salva un template che non esiste
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha salvato il nuovo template
- Trigger: Il personale vuole salvare un template che non esiste

====== Salvataggio template esistente<uc:salvataggio-template-esistente>

- Attore principale: Personale
- Scenario principale:
 + Il personale effettua il salvataggio di un template esistente
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Specializzazioni:
  - @uc:sovrascrittura-template
  - @uc:creazione-variante-template
- Trigger: Il personale vuole salvare un template esistente

======= Sovrascrittura template esistente<uc:sovrascrittura-template>

- Attore principale: Personale
- Scenario principale:
 + Il personale sovrascrive un template esistente
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha sovrascritto il template esistente
- Trigger: Il personale vuole sovrascrivere un template esistente

======= Creazione variante template<uc:creazione-variante-template>

- Attore principale: Personale
- Scenario principale:
 + Il personale crea una variante del template
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha creato una variante del template
- Trigger: Il personale vuole creare una variante del template per un altro fornitore

===== Configurazione parole chiave<uc:configurazione-parole-chiave>

#img(
  "UC/UC3.8.png",
  caption: [UC3.8: Configurazione parole chiave.],
  alt: "Questo diagramma dei casi d'uso mostra la configurazione delle parole chiave. Ogni configurazione include l'inserimento delle parole chiave e l'indicazione su cosa prendere dopo le parole. La configurazione si generalizza nella configurazione per i campi codice, descrizione, unità, quantità e riferimento codice ordine. Quest'ultimo include il caso d'uso per specificare se il riferimento è unico oppure diverso per ogni articolo."
)

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce le parole chiave -> Vedi @uc:inserimento-parole-chiave
 + Il personale specifica cosa prendere dopo la parola chiave -> Vedi @uc:inserimento-cosa-prendere
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per il template
- Inclusioni:
  - @uc:inserimento-parole-chiave
  - @uc:inserimento-cosa-prendere
- Specializzazioni:
  - @uc:configurazione-parole-chiave-codice
  - @uc:configurazione-parole-chiave-descrizione
  - @uc:configurazione-parole-chiave-unita
  - @uc:configurazione-parole-chiave-quantita
  - @uc:configurazione-parole-chiave-riferimento
- Trigger: Il personale vuole configurare le parole chiave per il template

====== Inserimento parole chiave<uc:inserimento-parole-chiave>

- Attore principale: Personale
- Scenario principale:
 + Il personale inserisce le parole chiave
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha inserito le parole chiave
- Trigger: Il personale vuole inserire le parole chiave per il template

====== Inserimento cosa prendere<uc:inserimento-cosa-prendere>

- Attore principale: Personale
- Scenario principale:
 + Il personale specifica cosa prendere dopo la parola chiave
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha specificato cosa prendere dopo la parola chiave
- Trigger: Il personale vuole specificare cosa prendere dopo la parola chiave

====== Configurazione parole chiave codice<uc:configurazione-parole-chiave-codice>

- Attore principale: Personale
- Scenario principale:
 + Il personale configura le parole chiave per il codice
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per il codice
- Trigger: Il personale vuole configurare le parole chiave per il codice

====== Configurazione parole chiave descrizione<uc:configurazione-parole-chiave-descrizione>

- Attore principale: Personale
- Scenario principale:
 + Il personale configura le parole chiave per la descrizione
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per la descrizione
- Trigger: Il personale vuole configurare le parole chiave per la descrizione

====== Configurazione parole chiave unità<uc:configurazione-parole-chiave-unita>

- Attore principale: Personale
- Scenario principale:
 + Il personale configura le parole chiave per l'unità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per l'unità
- Trigger: Il personale vuole configurare le parole chiave per l'unità

====== Configurazione parole chiave quantità<uc:configurazione-parole-chiave-quantita>

- Attore principale: Personale
- Scenario principale:
 + Il personale configura le parole chiave per la quantità
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per la quantità
- Trigger: Il personale vuole configurare le parole chiave per la quantità

====== Configurazione parole chiave riferimento codice ordine<uc:configurazione-parole-chiave-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale configura le parole chiave per il riferimento al codice ordine
 + Il personale specifica se il riferimento è unico o diverso per ogni articolo -> Vedi @uc:specificare-riferimento
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha configurato le parole chiave per il riferimento al codice ordine
- Inclusioni:
  - @uc:specificare-riferimento
- Trigger: Il personale vuole configurare le parole chiave per il riferimento al codice ordine

======= Specificare se il riferimento è unico o diverso per ogni articolo<uc:specificare-riferimento>

- Attore principale: Personale
- Scenario principale:
 + Il personale specifica se il riferimento al codice ordine è unico oppure diverso per ogni articolo
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
 - Il personale sta configurando le parole chiave per il riferimento al codice ordine -> Vedi @uc:configurazione-parole-chiave-riferimento
- Postcondizioni:
 - Il personale ha specificato se il riferimento è unico o diverso per ogni articolo
- Trigger: Il personale vuole specificare se il riferimento al codice ordine è unico oppure diverso per ogni articolo

===== Rotazione PDF<uc:rotazione>

#img(
  "UC/UC3.9.png",
  caption: [UC3.9: Rotazione PDF.],
  alt: "Questo diagramma dei casi d'uso rappresenta il personale che vuole ruotare il PDF al momento della creazione del template. Questo caso d'uso si specializza nella rotazione del PDF a sinistra oppure nella rotazione del PDF a destra."
)

- Attore principale: Personale
- Scenario principale:
 + Il personale ruota il PDF per creare il template
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template -> Vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato -> Vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il personale ha ruotato il PDF
- Specializzazioni:
 - @uc:rotazione-sx
 - @uc:rotazione-dx
- Trigger: Il personale vuole ruotare il PDF per creare il template

====== Rotazione PDF a sinistra<uc:rotazione-sx>

- Attore principale: Personale
- Scenario principale:
 + Il personale seleziona l'opzione di rotazione a sinistra (antioraria)
 + Il personale visualizza l'anteprima del PDF ruotato
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template → vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato → vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il PDF è ruotato di 90° in senso antiorario
- Trigger: Il personale vuole ruotare il PDF a sinistra per migliorare l'allineamento del template

====== Rotazione PDF a destra<uc:rotazione-dx>

- Attore principale: Personale
- Scenario principale:
 + Il personale seleziona l'opzione di rotazione a destra (oraria)
 + Il personale visualizza l'anteprima del PDF ruotato
- Precondizioni:
 - Il sistema è online
 - Il personale sta creando il template → vedi @uc:creazione-template
 - Il PDF di riferimento è stato caricato → vedi @uc:caricamento-pdf
- Postcondizioni:
 - Il PDF è ruotato di 90° in senso orario
- Trigger: Il personale vuole ruotare il PDF a destra per migliorare l'allineamento del template
]

== Tracciamento dei requisiti<cap:requirements-list>
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
    caption: "Tracciamento dei requisiti funzionali.",
)
<tab:requisiti-funzionali>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getQR().flatten()
    ),
    caption: "Tracciamento dei requisiti di qualità.",
)
<tab:requisiti-qualitativi>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getCR().flatten()
    ),
    caption: "Tracciamento dei requisiti di vincolo.",
)
<tab:requisiti-vincolo>

#v(2em)
Di seguito, nella @tab:riepilogo-requisiti ho inserito il riepilogo dei requisiti, suddivisi per tipologia e necessità.
#v(1em)
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