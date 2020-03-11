Class {
	#name : #AlpSendersIndex,
	#superclass : #AlpBasicIndex,
	#category : #Aleph
}

{ #category : #building }
AlpSendersIndex >> indexMethod: aMethod [

	self 
		sendersOf: aMethod 
		do: [ :aSelector | self atEntry: aSelector add: aMethod ]
]

{ #category : #updating }
AlpSendersIndex >> methodRemoved: aMethod [

	self sendersOf: aMethod do: [ :aSelector | 
		self atEntry: aSelector remove: aMethod ]
]

{ #category : #private }
AlpSendersIndex >> sendersOf: aMethod do: aBlock [

	aMethod literals do: [ :each |
		each isSymbol ifTrue: [ aBlock value: each ] ].
	aMethod specialLiterals do: [ :each |
		aBlock value: each ].
	aMethod pragmas do: [ :each |
		aBlock value: each selector ]
]
