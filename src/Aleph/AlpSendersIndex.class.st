Class {
	#name : #AlpSendersIndex,
	#superclass : #AlpBasicIndex,
	#category : #Aleph
}

{ #category : #accessing }
AlpSendersIndex >> initialTableSize [

	^ statistics at: #numberOfSymbols
]

{ #category : #'updating - methods' }
AlpSendersIndex >> methodAdded: aMethod [

	self 
		sendersOf: aMethod 
		do: [ :aSelector | self atEntry: aSelector add: aMethod ]
]

{ #category : #'updating - methods' }
AlpSendersIndex >> methodRemoved: aMethod [

	self sendersOf: aMethod do: [ :aSelector | 
		self atEntry: aSelector remove: aMethod ]
]

{ #category : #private }
AlpSendersIndex >> sendersOf: aMethod do: aBlock [

	"I use a Set to guarantee that the repeted literals are only stored once"
	| senders |
	senders := Set new.

	aMethod literals do: [ :each | each isSymbol ifTrue: [ senders add: each ] ].
	aMethod specialLiterals do: [ :each | senders add: each].
	aMethod pragmas do: [ :each | senders add: each selector ].
	
	senders do: aBlock
	
]
