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
    [Il personale deve poter caricare il #gl("DDT") nel sistema.],
    [@uc:caricamento-ddt]
  ))
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter caricare i #gl("DDT") in formato PDF.],
    [@uc:caricamento-ddt]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [I #gl("DDT") in formato PDF devono avere una dimensione massima di 5MB.],
    [@uc:caricamento-ddt]
  ))
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti.],
    [@uc:visualizzazione-dati]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati del fornitore.],
    [@uc:visualizzazione-fornitore]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la ragione sociale del fornitore.],
    [@uc:visualizzazione-fornitore-ragione-sociale]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'indirizzo del fornitore.],
    [@uc:visualizzazione-fornitore-indirizzo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la partita IVA del fornitore.],
    [@uc:visualizzazione-fornitore-piva]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati del destinatario.],
    [@uc:visualizzazione-destinatario]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la ragione sociale del destinatario.],
    [@uc:visualizzazione-destinatario-ragione-sociale]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'indirizzo del destinatario.],
    [@uc:visualizzazione-destinatario-indirizzo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la partita IVA del destinatario.],
    [@uc:visualizzazione-destinatario-piva]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati degli articoli estratti.],
    [@uc:visualizzazione-articoli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti di un singolo articolo.],
    [@uc:visualizzazione-singolo-articolo]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il codice di un singolo articolo.],
    [@uc:visualizzazione-articolo-codice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la descrizione di un singolo articolo.],
    [@uc:visualizzazione-articolo-descrizione]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare la quantità di un singolo articolo.],
    [@uc:visualizzazione-articolo-quantita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il riferimento al codice ordine di un singolo articolo.],
    [@uc:visualizzazione-articolo-ordine]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare l'unità di misura di un singolo articolo.],
    [@uc:visualizzazione-articolo-unita]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare i dati estratti dall'appendice del #gl("DDT").],
    [@uc:visualizzazione-appendice]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare le note estratte.],
    [@uc:visualizzazione-appendice-note]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il numero di colli.],
    [@uc:visualizzazione-appendice-colli]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il peso netto estratto.],
    [@uc:visualizzazione-appendice-peso-netto]
  ))

  mandatory+=1
  FR.push((
    (m + str(mandatory)),
    [Il personale deve poter visualizzare il peso lordo estratto.],
    [@uc:visualizzazione-appendice-peso-lordo]
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
    [Il sistema deve poter estendere il supporto a più template #gl("DDT") configurabili da interfaccia amministrativa.],
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
    [Il sistema deve restituire il risultato entro 20 secondi.],
    [Piano di lavoro]
  ))

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
