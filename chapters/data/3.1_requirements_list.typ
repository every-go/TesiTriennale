#import "../../config/thesis-config.typ": gl

// Functional
#let getFR(getLen: bool) = {
  let FR = ()
  let m = "RFM"
  let d = "RFD"
  let o = "RFO"
  let mandatory = 0
  let desirable = 0
  let optional = 0
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter caricare il DDT nel sistema.],
    [@uc:caricamento-ddt]
  ))
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter caricare i DDT in formato PDF.],
    [@uc:caricamento-ddt]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [I DDT in formato PDF devono avere una dimensione massima di 5MB.],
    [@uc:caricamento-ddt, @uc:caricamento-pdf]
  ))
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti.],
    [@uc:visualizza-dati]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati del fornitore.],
    [@uc:visualizza-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la ragione sociale del fornitore.],
    [@uc:visualizza-fornitore-ragione-sociale]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'indirizzo del fornitore.],
    [@uc:visualizza-fornitore-indirizzo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la partita IVA del fornitore.],
    [@uc:visualizza-fornitore-piva]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati del destinatario.],
    [@uc:visualizza-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la ragione sociale del destinatario.],
    [@uc:visualizza-destinatario-ragione-sociale]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'indirizzo del destinatario.],
    [@uc:visualizza-destinatario-indirizzo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la partita IVA del destinatario.],
    [@uc:visualizza-destinatario-piva]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati degli articoli estratti.],
    [@uc:visualizza-articoli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti di un singolo articolo.],
    [@uc:visualizza-singolo-articolo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il codice di un singolo articolo.],
    [@uc:visualizza-articolo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la descrizione di un singolo articolo.],
    [@uc:visualizza-articolo-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la quantità di un singolo articolo.],
    [@uc:visualizza-articolo-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il riferimento al codice ordine di un singolo articolo.],
    [@uc:visualizza-articolo-ordine]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'unità di misura di un singolo articolo.],
    [@uc:visualizza-articolo-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti dall'appendice del DDT.],
    [@uc:visualizza-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare le note estratte.],
    [@uc:visualizza-appendice-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il numero di colli.],
    [@uc:visualizza-appendice-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il peso netto estratto.],
    [@uc:visualizza-appendice-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il peso lordo estratto.],
    [@uc:visualizza-appendice-peso-lordo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il numero del DDT estratto.],
    [@uc:visualizza-numero]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la data del DDT estratta.],
    [@uc:visualizza-data]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare un nuovo template per il DDT.],
    [@uc:creazione-template]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter caricare un PDF di riferimento per il template.],
    [@uc:caricamento-pdf]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter inserire il nome del fornitore per il template.],
    [@uc:inserimento-nome-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter effettuare operazioni sui rettangoli del template.],
    [@uc:operazione-rettangoli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'ancora.],
    [@uc:operazione-rettangolo-ancora]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'ancora.],
    [@uc:creazione-rettangolo-ancora]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter inserire il nome dell'ancora.],
    [@uc:inserimento-nome-ancora]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'ancora.],
    [@uc:modifica-rettangolo-ancora]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'ancora.],
    [@uc:eliminazione-rettangolo-ancora]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'intestazione.],
    [@uc:operazione-rettangolo-intestazione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'intestazione.],
    [@uc:creazione-rettangolo-intestazione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'intestazione.],
    [@uc:modifica-rettangolo-intestazione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'intestazione.],
    [@uc:eliminazione-rettangolo-intestazione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del corpo.],
    [@uc:operazione-rettangolo-corpo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del corpo.],
    [@uc:creazione-rettangolo-corpo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del corpo.],
    [@uc:modifica-rettangolo-corpo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del corpo.],
    [@uc:eliminazione-rettangolo-corpo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'appendice.],
    [@uc:operazione-rettangolo-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'appendice.],
    [@uc:creazione-rettangolo-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'appendice.],
    [@uc:modifica-rettangolo-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'appendice.],
    [@uc:eliminazione-rettangolo-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del numero DDT.],
    [@uc:operazione-rettangolo-numero]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del numero DDT.],
    [@uc:creazione-rettangolo-numero]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del numero DDT.],
    [@uc:modifica-rettangolo-numero]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del numero DDT.],
    [@uc:eliminazione-rettangolo-numero]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della data DDT.],
    [@uc:operazione-rettangolo-data]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della data DDT.],
    [@uc:creazione-rettangolo-data]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della data DDT.],
    [@uc:modifica-rettangolo-data]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della data DDT.],
    [@uc:eliminazione-rettangolo-data]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della ragione sociale del fornitore.],
    [@uc:operazione-rettangolo-ragione-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della ragione sociale del fornitore.],
    [@uc:creazione-rettangolo-ragione-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della ragione sociale del fornitore.],
    [@uc:modifica-rettangolo-ragione-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della ragione sociale del fornitore.],
    [@uc:eliminazione-rettangolo-ragione-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della partita IVA del fornitore.],
    [@uc:operazione-rettangolo-partitaIVA-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della partita IVA del fornitore.],
    [@uc:creazione-rettangolo-partitaIVA-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della partita IVA del fornitore.],
    [@uc:modifica-rettangolo-partitaIVA-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della partita IVA del fornitore.],
    [@uc:eliminazione-rettangolo-partitaIVA-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'indirizzo del fornitore.],
    [@uc:operazione-rettangolo-indirizzo-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'indirizzo del fornitore.],
    [@uc:creazione-rettangolo-indirizzo-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'indirizzo del fornitore.],
    [@uc:modifica-rettangolo-indirizzo-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'indirizzo del fornitore.],
    [@uc:eliminazione-rettangolo-indirizzo-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della ragione sociale del destinatario.],
    [@uc:operazione-rettangolo-ragione-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della ragione sociale del destinatario.],
    [@uc:creazione-rettangolo-ragione-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della ragione sociale del destinatario.],
    [@uc:modifica-rettangolo-ragione-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della ragione sociale del destinatario.],
    [@uc:eliminazione-rettangolo-ragione-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della partita IVA del destinatario.],
    [@uc:operazione-rettangolo-partitaIVA-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della partita IVA del destinatario.],
    [@uc:creazione-rettangolo-partitaIVA-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della partita IVA del destinatario.],
    [@uc:modifica-rettangolo-partitaIVA-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della partita IVA del destinatario.],
    [@uc:eliminazione-rettangolo-partitaIVA-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'indirizzo del destinatario.],
    [@uc:operazione-rettangolo-indirizzo-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'indirizzo del destinatario.],
    [@uc:creazione-rettangolo-indirizzo-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'indirizzo del destinatario.],
    [@uc:modifica-rettangolo-indirizzo-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'indirizzo del destinatario.],
    [@uc:eliminazione-rettangolo-indirizzo-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della prima unità.],
    [@uc:operazione-rettangolo-prima-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della prima unità.],
    [@uc:creazione-rettangolo-prima-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della prima unità.],
    [@uc:modifica-rettangolo-prima-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della prima unità.],
    [@uc:eliminazione-rettangolo-prima-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della prima quantità.],
    [@uc:operazione-rettangolo-prima-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della prima quantità.],
    [@uc:creazione-rettangolo-prima-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della prima quantità.],
    [@uc:modifica-rettangolo-prima-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della prima quantità.],
    [@uc:eliminazione-rettangolo-prima-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del primo codice.],
    [@uc:operazione-rettangolo-primo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del primo codice.],
    [@uc:creazione-rettangolo-primo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del primo codice.],
    [@uc:modifica-rettangolo-primo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del primo codice.],
    [@uc:eliminazione-rettangolo-primo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della prima descrizione.],
    [@uc:operazione-rettangolo-prima-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della prima descrizione.],
    [@uc:creazione-rettangolo-prima-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della prima descrizione.],
    [@uc:modifica-rettangolo-prima-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della prima descrizione.],
    [@uc:eliminazione-rettangolo-prima-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del primo riferimento al codice ordine.],
    [@uc:operazione-rettangolo-primo-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del primo riferimento al codice ordine.],
    [@uc:creazione-rettangolo-primo-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del primo riferimento al codice ordine.],
    [@uc:modifica-rettangolo-primo-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del primo riferimento al codice ordine.],
    [@uc:eliminazione-rettangolo-primo-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo della riga campione.],
    [@uc:operazione-rettangolo-riga-campione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo della riga campione.],
    [@uc:creazione-rettangolo-riga-campione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo della riga campione.],
    [@uc:modifica-rettangolo-riga-campione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo della riga campione.],
    [@uc:eliminazione-rettangolo-riga-campione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo dell'intestazione colonne.],
    [@uc:operazione-rettangolo-intestazione-colonne]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo dell'intestazione colonne.],
    [@uc:creazione-rettangolo-intestazione-colonne]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo dell'intestazione colonne.],
    [@uc:modifica-rettangolo-intestazione-colonne]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo dell'intestazione colonne.],
    [@uc:eliminazione-rettangolo-intestazione-colonne]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del numero colli.],
    [@uc:operazione-rettangolo-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del numero colli.],
    [@uc:creazione-rettangolo-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del numero colli.],
    [@uc:modifica-rettangolo-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del numero colli.],
    [@uc:eliminazione-rettangolo-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo delle note.],
    [@uc:operazione-rettangolo-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo delle note.],
    [@uc:creazione-rettangolo-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo delle note.],
    [@uc:modifica-rettangolo-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo delle note.],
    [@uc:eliminazione-rettangolo-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del peso lordo.],
    [@uc:operazione-rettangolo-peso-lordo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del peso lordo.],
    [@uc:creazione-rettangolo-peso-lordo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del peso lordo.],
    [@uc:modifica-rettangolo-peso-lordo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del peso lordo.],
    [@uc:eliminazione-rettangolo-peso-lordo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter operare sul rettangolo del peso netto.],
    [@uc:operazione-rettangolo-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare il rettangolo del peso netto.],
    [@uc:creazione-rettangolo-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter modificare il rettangolo del peso netto.],
    [@uc:modifica-rettangolo-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter eliminare il rettangolo del peso netto.],
    [@uc:eliminazione-rettangolo-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter inserire le parole per il riepilogo.],
    [@uc:inserimento-parole-riepilogo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter inserire le parole da ignorare.],
    [@uc:inserimento-parole-ignorare]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter indicare la posizione della quantità nel template.],
    [@uc:indicazione-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter salvare il template.],
    [@uc:salvataggio-template]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter salvare un template che non esiste.],
    [@uc:salvataggio-template-nuovo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter salvare un template esistente.],
    [@uc:salvataggio-template-esistente]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter sovrascrivere un template esistente.],
    [@uc:sovrascrittura-template]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter creare una variante del template per un altro fornitore.],
    [@uc:creazione-variante-template]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per il template.],
    [@uc:configurazione-parole-chiave]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter inserire le parole chiave.],
    [@uc:inserimento-parole-chiave]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter specificare cosa prendere dopo la parola chiave.],
    [@uc:inserimento-cosa-prendere]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per il codice.],
    [@uc:configurazione-parole-chiave-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per la descrizione.],
    [@uc:configurazione-parole-chiave-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per l'unità.],
    [@uc:configurazione-parole-chiave-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per la quantità.],
    [@uc:configurazione-parole-chiave-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter configurare le parole chiave per il riferimento al codice ordine.],
    [@uc:configurazione-parole-chiave-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter specificare se il riferimento al codice ordine è unico oppure diverso per ogni articolo.],
    [@uc:specificare-riferimento]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter ruotare il PDF.],
    [@uc:rotazione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter ruotare il PDF a sinistra.],
    [@uc:rotazione-sx]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter ruotare il PDF a destra.],
    [@uc:rotazione-dx]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il sistema deve consentire la classificazione del template.],
    [Piano di lavoro]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il sistema deve estrarre e normalizzare i dati.],
    [Piano di lavoro]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il risultato del sistema deve poter essere revisionato dal personale],
    [Piano di lavoro]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il risultato del sistema deve poter essere revisionato dagli sviluppatori.],
    [Piano di lavoro]
  ))

  desirable+=1
  FR.push((
    (d + str(desirable)),
    [Il sistema deve poter restituire un indicatore di sicurezza sull'affidabilità del risultato.],
    [Piano di lavoro]
  ))

  optional+=1
  FR.push((
    (o + str(optional)),
    [Il sistema deve poter estendere il supporto a più template DDT configurabili da interfaccia amministrativa.],
    [Piano di lavoro]
  ))

  optional+=1
  FR.push((
    (o + str(optional)),
    [Il sistema deve poter avere un controllo sulla rotazione dei PDF caricati.],
    [Piano di lavoro]
  ))

  optional+=1
  FR.push((
    (o + str(optional)),
    [Il sistema deve poter avere un controllo sul contrasto dei PDF caricati.],
    [Piano di lavoro]
  ))

  optional+=1
  FR.push((
    (o + str(optional)),
    [Il sistema deve poter avere un controllo sulla riduzione del rumore dei PDF caricati.],
    [Piano di lavoro]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return FR
}

// Qualitative
#let getQR(getLen: bool) = {
  let QR = ()  
  let m = "RQM"
  let d = "RQD"
  let o = "RQO"
  let mandatory = 0
  let desirable = 0
  let optional = 0

  mandatory+=1
  QR.push((
    (m + str(mandatory)),
    [La documentazione deve essere conforme alle scelte implementative, sui risultati ottenuti e sui limiti residui.],
    [Piano di lavoro]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return QR
}

// Constraint
#let getCR(getLen: bool) = {
  let CR = ()  
  let m = "RCM"
  let d = "RCD"
  let o = "RCO"
  let mandatory = 0
  let desirable = 0
  let optional = 0
  
  mandatory+=1
  CR.push((
    (m + str(mandatory)),
    [Il sistema deve prevedere una pipeline di OCR locale on-premise.],
    [Piano di lavoro]
  ))

  mandatory+=1
  CR.push((
    (m + str(mandatory)),
    [Il sistema deve poter essere distribuito tramite immagine Docker.],
    [Piano di lavoro]
  ))
  
  mandatory+=1
  CR.push((
    (m + str(mandatory)),
    [Il sistema deve restituire il risultato in un formato JSON deciso dall'azienda.],
    [Riunione col tutor]
  ))

  mandatory+=1
  CR.push((
    (m + str(mandatory)),
    [Il sistema deve gestire PDF multipagina.],
    [Riunione col tutor]
  ))

  optional+=1
  CR.push((
    (o + str(optional)),
    [L'ambiente di esecuzione del sistema deve essere definito tramite un Dockerfile, in modo da rendere agevole l'aggiornamento della versione Python e delle dipendenze di sistema.],
    [Piano di lavoro]
  ))

  optional+=1
  CR.push((
    (o + str(optional)),
    [Le dipendenze Python del sistema devono essere gestite tramite pip e dichiarate in un file requirements.txt, per consentirne l'aggiornamento in modo riproducibile.],
    [Piano di lavoro]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return CR
}
