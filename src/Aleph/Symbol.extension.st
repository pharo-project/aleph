Extension { #name : #Symbol }

{ #category : #'*Aleph' }
Symbol class >> numberOfSymbols [

	^ NewSymbols size + OneCharacterSymbols size + SymbolTable size.

]
