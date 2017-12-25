syn match   mySymbolOperator  ":\||\|+\|-\|*\|/\|=\|%"
syn match   mySpecialOperator "\."
syn match   mySymbolLogical   "&&\|||\|>=\|<=\|==\|!=\|!\|>\|<"
syn match   mySemicolon       ","
syn match   myBracket         "(\|)"

syn keyword myHiFunction      pprint

hi def link mySymbolOperator  Operator
hi def link mySymbolLogical   Include
hi def link mySpecialOperator Typedef
hi def link mySemicolon       Include
hi def link myBracket         Include
hi def link myHiFunction      Function
