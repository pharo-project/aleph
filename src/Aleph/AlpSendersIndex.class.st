Class {
	#name : #AlpSendersIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpSendersIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpSendersIndex >> indexMethod: aMethod [

	aMethod literals do: [ :each |
		each isSymbol ifTrue: [ (self indexAt: each) add: aMethod ] ].
	aMethod specialLiterals do: [ :each |
		(self indexAt: each) add: aMethod ].
	aMethod pragmas do: [ :each |
		(self indexAt: each selector) add: aMethod ]
]
