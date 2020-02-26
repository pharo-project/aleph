Class {
	#name : #AlpSystemNavigation,
	#superclass : #SystemNavigation,
	#category : #Aleph
}

{ #category : #testing }
AlpSystemNavigation class >> isActive [

	^ AlpManager isActive
]

{ #category : #query }
AlpSystemNavigation >> allImplementorsOf: aLiteral [

	^ self applyScope: (self manager findImplementorsOf: aLiteral)
]

{ #category : #query }
AlpSystemNavigation >> allReferencesTo: aLiteral [

	^ self applyScope: (aLiteral first isUppercase 
		ifTrue:[ self manager findReferencesTo: aLiteral ]
		ifFalse: [  self manager findSendersOf: aLiteral ])
]

{ #category : #query }
AlpSystemNavigation >> allSendersOf: aLiteral [

	^ self applyScope: (self manager findSendersOf: aLiteral)
]

{ #category : #'as yet unclassified' }
AlpSystemNavigation >> applyScope: aCollection [

	(environment notNil 
		and: [ environment isDictionary not ])
		ifTrue: [ 
			^ aCollection select: [ :each | environment hasClassNamed: each origin name  ] ].

	^ aCollection
]

{ #category : #'as yet unclassified' }
AlpSystemNavigation >> manager [

	^ AlpManager default
]
