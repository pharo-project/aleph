"
I am a SystemNavigation implementation that uses the indexes in Aleph for all the queries.
"
Class {
	#name : #AlpSystemNavigation,
	#superclass : #SystemNavigation,
	#category : #'Aleph-Core'
}

{ #category : #query }
AlpSystemNavigation >> allClassNamesStartingWith: aString do: aBlock [

	^ self manager findClassesStartingWith: aString do: [ :aClass |
		"Somehow this gives a list of lists..."
		 aBlock value: aClass name ]
]

{ #category : #query }
AlpSystemNavigation >> allImplementorsOf: aLiteral [

	^ self applyScope: (self manager findImplementorsOf: aLiteral)
]

{ #category : #query }
AlpSystemNavigation >> allReferencesTo: aLiteral [

	(aLiteral isKindOf: ClyVariable)
		ifTrue: [ ^ self manager findReferencesTo: aLiteral actualVariable name ].

	^ self applyScope: (aLiteral isVariableBinding
		ifTrue:[ self manager findReferencesTo: aLiteral key ]
		ifFalse: [ self manager findSendersOf: aLiteral ])
]

{ #category : #query }
AlpSystemNavigation >> allSelectorsStartingWith: aString do: aBlock [

	^ self manager findSelectorsStartingWith: aString do: [ :aMethod |
		 aBlock value: aMethod selector]
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
