#import "./config/variables.typ": *
#import "./config/thesis-config.typ": *

#show figure.where(kind: table): set block(breakable: true)

#show: config.with(
  myAuthor: myName,
  myTitle: myTitle,
  myLang: myLang
)

#include "structure.typ"
