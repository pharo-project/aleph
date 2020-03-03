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

	self referencesOf: aMethod do: [ :aVariable | 
		(self indexAt: aVariable) add: aMethod ]
]

{ #category : #updating }
AlpReferencesIndex >> methodAdded: aMethod [

	self indexMethod: aMethod
]

{ #category : #updating }
AlpReferencesIndex >> methodRemoved: aMethod [

	self referencesOf: aMethod do: [ :aVariable | 
		self remove: aMethod fromEntry: aVariable ]
]

{ #category : #private }
AlpReferencesIndex >> referencesOf: aMethod do: aBlock [

	aMethod literals 
		select: [ :each | each isVariableBinding ]
		thenDo: [ :each | aBlock value: each key ]
]
