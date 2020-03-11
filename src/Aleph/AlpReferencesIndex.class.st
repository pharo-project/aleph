Class {
	#name : #AlpReferencesIndex,
	#superclass : #AlpTrieIndex,
	#category : #Aleph
}

{ #category : #building }
AlpReferencesIndex >> indexMethod: aMethod [

	self referencesOf: aMethod do: [ :aVariable | 
		self atEntry: aVariable add: aMethod ]
]

{ #category : #updating }
AlpReferencesIndex >> methodRemoved: aMethod [

	self referencesOf: aMethod do: [ :aVariable | 
		self atEntry: aVariable remove: aMethod ]
]

{ #category : #private }
AlpReferencesIndex >> referencesOf: aMethod do: aBlock [

	aMethod literals 
		select: [ :each | each isVariableBinding ]
		thenDo: [ :each | aBlock value: each key ]
]
