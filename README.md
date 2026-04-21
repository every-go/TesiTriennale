# Smart Accounting, evoluzione sistema lettura DDT

## Introduzione
Questa tesi è l'elaborato di Matteo Mazzaretto, uno studente del CdL triennale in informatica, redatto nell'a.a. 2025-2026.

## Template
Il template della tesi è stato preso dalla repository in questo [link](https://github.com/tlazzarin/thesis-template)

Ringrazio il creatore di questo template di Typst.

## Contenuto

Riguarda il tirocinio effettuato presso Spazio Dev SRL, Tombolo, PD, dal 27/04 al 26/06.

## Obiettivo del tirocinio
+ Lo stage sarà focalizzato sul progetto Smart Accounting, con l’obiettivo di analizzare ed evolvere l’attuale sistema di lettura DDT già funzionante ma oggi dipendente da API esterne a pagamento per la comprensione documentale.

+ Definizione e sviluppo di una pipeline OCR locale/on-premise per acquisizione, classificazione layout, parsing ed estrazione strutturata dei dati dai DDT, privilegiando componenti hostate in locale e facilmente manutenibili.

+ Integrazione del nuovo modulo nel sistema esistente in ambiente Laravel/Filament, riducendo la dipendenza da microservizi esterni e favorendo, ove possibile, librerie native PHP/Laravel e un ecosistema Docker essenziale.