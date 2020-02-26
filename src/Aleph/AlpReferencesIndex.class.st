Class {
	#name : #AlpReferencesIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpReferencesIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpReferencesIndex >> indexMethod: aMethod [

	aMethod literals 
		select: [ :each | each isVariableBinding ]
		thenDo: [ :each | (self indexAt: each key) add: aMethod ]
]
