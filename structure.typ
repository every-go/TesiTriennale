/* Questo file serve per:
- Gestire i capitoli
- Gestire lo stile e la numerazione del conteggio delle pagine
*/

// Frontmatter
#include "preface/firstpage.typ"
#include "preface/copyright.typ"

#set page(numbering: "i")
#include "preface/dedication.typ"
#include "preface/acknowledgements.typ"
#include "preface/summary.typ"
#include "preface/table-of-contents.typ"
#pagebreak()
#pagebreak()

// Mainmatter
#counter(page).update(1)
#set page(numbering: "1.")
#include "chapters/1_introduction.typ"
#include "chapters/2_stage-description.typ"
#include "chapters/3_requirements.typ"
#include "chapters/4_introduzione-teorica.typ"
#include "chapters/5_approcci.typ"
#include "chapters/6_interfaccia_logic.typ"
#include "chapters/7_conclusion.typ"

//#include "docs/esempi.typ"

// Backmatter
#include "appendix/glossary/glossary.typ"
#include "appendix/bibliography/bibliography.typ"
