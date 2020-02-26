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

	^ self manager findImplementorsOf: aLiteral
]

{ #category : #query }
AlpSystemNavigation >> allReferencesTo: aLiteral [

	^ aLiteral first isUppercase 
		ifTrue:[ self manager findReferencesTo: aLiteral ]
		ifFalse: [  self manager findSendersOf: aLiteral ]
]

{ #category : #query }
AlpSystemNavigation >> allSendersOf: aLiteral [

	^ self manager findSendersOf: aLiteral
]

{ #category : #'as yet unclassified' }
AlpSystemNavigation >> manager [

	^ AlpManager default
]
