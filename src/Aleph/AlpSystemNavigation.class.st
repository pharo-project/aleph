"
I am a SystemNavigation implementation that uses the indexes in Aleph for all the queries.
"
Class {
	#name : #AlpSystemNavigation,
	#superclass : #SystemNavigation,
	#category : #Aleph
}

{ #category : #query }
AlpSystemNavigation >> allImplementorsOf: aLiteral [

	^ self applyScope: (self manager findImplementorsOf: aLiteral)
]

{ #category : #query }
AlpSystemNavigation >> allReferencesTo: aLiteral [

	^ self applyScope: (aLiteral isVariableBinding
		ifTrue:[ self manager findReferencesTo: aLiteral key ]
		ifFalse: [ self manager findSendersOf: aLiteral ])
]

{ #category : #query }
AlpSystemNavigation >> allSendersOf: aLiteral [

	^ self applyScope: (self manager findSendersOf: aLiteral)
]

{ #category : #private }
AlpSystemNavigation >> applyScope: aCollection [

	(environment notNil 
		and: [ environment isDictionary not ])
		ifTrue: [ 
			^ aCollection select: [ :each | environment hasClassNamed: each origin name  ] ].

	^ aCollection
]

{ #category : #private }
AlpSystemNavigation >> manager [

	^ AlpIndexManager current
]
