#import "../../config/constants.typ" : glossary
#import "terms.typ": glossary-terms
#import "../../config/thesis-config.typ": print-glossary

#pagebreak(to:"odd")
#heading(numbering: none, glossary) <glossary>
#print-glossary(
    glossary-terms.sorted(key: t => lower(repr(t.short))),
    deduplicate-back-references: true
)
