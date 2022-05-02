"
I am an index to improve the lookup of senders of a given selector.
I go over all the methods and store which messages are sent. 
I can handle the implicit literals encoded in the bytecode by using #AlpEncodedSpecialLiteralMapProvider
"
Class {
	#name : #AlpSendersIndex,
	#superclass : #AlpBasicIndex,
	#category : #'Aleph-Indexes'
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

	"I use a set to guarantee that the repeted literals are only stored once.
	
	I use an IdentitySet instead of a Set to gain speed, as we can compare symbols by identity. "
	| senders |
	senders := IdentitySet new.

	aMethod literalsEvenTheOnesInTheInnerBlocks do: [ :each | each isSymbol ifTrue: [ senders add: each ] ].
	aMethod specialLiterals do: [ :each | senders add: each].
	aMethod pragmas do: [ :each | senders add: each selector ].
	
	senders do: aBlock
	
]
