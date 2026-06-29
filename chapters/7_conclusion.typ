#import "data/3.1_requirements_list.typ": *
#import "../config/variables.typ": *
#import "../config/thesis-config.typ": heading-name
#pagebreak(to:"odd")

= Conclusioni<cap:conclusioni>
#text(style: "italic", [
    In questo capitolo traggo le conclusioni sul progetto.
])
#v(1em)

== Consuntivo finale
Il consuntivo orario finale, riportato nella @fig:tabella-calcolo-ore, suddivide in maniera approssimata le ore dedicate alle varie attività.
#v(1em)
#set table(
  align: (center+horizon, center+horizon), 
)
#let ore-fasi = (
  ("Onboarding del progetto", 16),
  ("Primi approcci solo con regex", 32),
  ("Testing tecnologie per creazione interfaccia grafica", 24),
  ("Creazione interfaccia grafica estrazione DDT", 8),
  ("Creazione interfaccia grafica costruzione template", 40),
  ("Test con pochi template per testare la bontà degli algoritmi", 60),
  ("Creazione test di regressione e di tutti i template", 12),
  ("Testing di tutti i fornitori", 80),
  ("Scrittura documentazione relativa", 32)
)

#let totale-ore = ore-fasi.map(riga => riga.at(1)).sum()

#figure(
  caption: [Consuntivo orario finale],
  table(
    columns: 2,
    table.header([*Attività*], [*Ore*]),
    ..ore-fasi.map(riga => ([#riga.at(0)], [#riga.at(1)])).flatten(),
    [*Totale*], [*#totale-ore*]
  )
)<fig:tabella-calcolo-ore>
#v(1em)

== Requisiti soddisfatti
Tutti i requisiti descritti nella @cap:requirements-list sono stati implementati, come riportato nel riepilogo della @tab:requisiti-soddisfatti.
#v(1em)

#let fr_tot = getFR(getLen: true)
#let qr_tot = getQR(getLen: true)
#let cr_tot = getCR(getLen: true)

#figure(
  table(
    columns: (auto, 1fr, 1fr, auto, auto),
    table.header([*Tipo*], [*Obbligatori*], [*Desiderabili*],[*Opzionali*], [*Somma*]),
    [Funzionali], [#fr_tot.at(0)/#fr_tot.at(0)], [#fr_tot.at(1)/#fr_tot.at(1)], [#fr_tot.at(2)/#fr_tot.at(2)], [#fr_tot.sum()/#fr_tot.sum()],
    [Qualità], [#qr_tot.at(0)/#qr_tot.at(0)], [#qr_tot.at(1)/#qr_tot.at(1)], [#qr_tot.at(2)/#qr_tot.at(2)], [#qr_tot.sum()/#qr_tot.sum()],
    [Vincolo], [#cr_tot.at(0)/#cr_tot.at(0)], [#cr_tot.at(1)/#cr_tot.at(1)], [#cr_tot.at(2)/#cr_tot.at(2)], [#cr_tot.sum()/#cr_tot.sum()],
    [*Totale*],
      [*#{fr_tot.at(0)+qr_tot.at(0)+cr_tot.at(0)}/#{fr_tot.at(0)+qr_tot.at(0)+cr_tot.at(0)}*],
      [*#{fr_tot.at(1)+qr_tot.at(1)+cr_tot.at(1)}/#{fr_tot.at(1)+qr_tot.at(1)+cr_tot.at(1)}*],
      [*#{fr_tot.at(2)+qr_tot.at(2)+cr_tot.at(2)}/#{fr_tot.at(2)+qr_tot.at(2)+cr_tot.at(2)}*],
      [*#{fr_tot.sum()+qr_tot.sum()+cr_tot.sum()}/#{fr_tot.sum()+qr_tot.sum()+cr_tot.sum()}*],
    align: (center+horizon)
  ),
  caption: "Riepilogo dei requisiti soddisfatti"
)<tab:requisiti-soddisfatti>

== Rischi occorsi e mitigati
L'analisi dei rischi si trova nella @cap:analisi-rischi.\
I rischi emersi durante lo stage sono riportati in @fig:rischi-occorsi.\
#v(1em)
#figure(
  caption: [Rischi occorsi con la loro mitigazione],
  table(
    columns: 2,
    table.header([*Descrizione*],[*Mitigazione*]),
    [#heading-name(<risk:r05>)], [Il rischio è stato incontrato durante lo studio delle tecnologie. La mitigazione è stata uno studio a priori che mi ha permesso di escludere alcune tecnologie che non rispettavano i vincoli richiesti. Maggiori dettagli nella @cap:introduzione-teorica.],
    [#heading-name(<risk:r06>)], [Il rischio è stato incontrato parecchie volte nel corso del progetto. Quando incontrato mitigavo il rischio aggiungendo funzionalità che permettevano di ridurre al minimo l'impatto dei casi limite.],
    [#heading-name(<risk:r07>)], [La mitigazione effettivamente applicata per questo rischio è la possibilità di creare per ogni fornitore almeno un template.],
    [#heading-name(<risk:r08>)], [La mitigazione effettivamente applicata per questo rischio è la possibilità di creare per ogni fornitore più di un template, gestendo la scelta del miglior template come descritto nella @cap:fornitori-template.],
    [#heading-name(<risk:r09>)], [La mitigazione effettivamente applicata per questo rischio è la gestione del preprocessing come descritto nella @cap:inclinazione.],
    [#heading-name(<risk:r10>)], [Siccome era impossibile agire direttamente modificando gli OCR, il rischio è stato mitigato trovando un modo più veloce per comprendere se la causa delle estrazioni errate è dettata dall'algoritmo o dall'OCR. Quanto fatto per mitigare è descritto nella @cap:risultati-ocr.],
  )
)<fig:rischi-occorsi>
#v(1em)

== Obiettivi raggiunti e valutazione personale
Gli obiettivi principali definiti con il tutor all'inizio del progetto sono stati interamente soddisfatti, testando tutti i fornitori di cui disponevo almeno un PDF d'esempio.\
Secondo il report che ho creato durante lo svolgimento del tirocinio, basato sui risultati ottenuti dai test di regressione descritti nella @cap:test, l'accuratezza esatta ottenuta dall'algoritmo è stata del 99,04%.\
Per quanto buona sia questa percentuale, mi era impossibile calcolare con precisione la bontà degli articoli estratti, per questo motivo credo che la reale affidabilità si aggiri tra l'80% e il 90%.\
Ad ogni modo, il risultato è più che soddisfacente dal mio punto di vista; il problema è che non mi è stato possibile testarlo in produzione per mancanza di tempo.\
Inoltre, la creazione del template è molto lunga e laboriosa, credo che questa possa essere un passaggio molto propenso all'errore umano, per il quale è necessaria una certa esperienza pratica per creare i migliori template.\
Per questo motivo, sarebbe utile integrare nella creazione dei template un supporto basato sull'intelligenza artificiale, capace di tracciare automaticamente i rettangoli, lasciando poi al personale o a uno sviluppatore il compito di correggerli.\
Come sottolineato dal tutor, 'Ogni cosa che si può fare a mano si può anche automatizzare', un'osservazione che condivido pienamente: credo infatti che l'automazione della creazione dei template rappresenterebbe un significativo miglioramento per il progetto.\
Dal punto di vista personale, questo tipo di progetto, in cui sono richiesti continuamente test sulle stesse parti e una continua iterazione con una sorta di 'try fail retry', senza allargare ad altre funzionalità, risulta molto soddisfacente solo quando vengono finalmente raggiunti gli obiettivi, ma piuttosto frustrante durante lo svolgimento.\
Inoltre, lavorare con librerie e strumenti esterni, come gli OCR, comporta un disagio particolare: quando l'algoritmo fallisce, la causa non è sempre riconducibile al proprio lavoro, ma talvolta ai limiti degli strumenti su cui ci si deve affidare.\
Resto comunque consapevole che un'affidabilità del 100% sia irrealistica per un OCR, e che parte di queste difficoltà vada quindi accettata come inevitabile.\
In definitiva, la mia soddisfazione per il progetto è molto alta: non pensavo di riuscire a portare ogni singolo punto alla conclusione e soprattutto di ottenere un'accuratezza così elevata.\
Al di là del risultato tecnico, questo percorso mi ha permesso di affinare capacità di analisi e di astrazione che ritengo preziose per il mio futuro professionale.