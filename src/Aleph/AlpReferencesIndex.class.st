Class {
	#name : #AlpReferencesIndex,
	#superclass : #AlpBasicIndex,
	#category : #Aleph
}

{ #category : #'updating - methods' }
AlpReferencesIndex >> methodAdded: aMethod [

	self referencesOf: aMethod do: [ :aVariable | 
		self atEntry: aVariable add: aMethod ]
]

{ #category : #'updating - methods' }
AlpReferencesIndex >> methodRemoved: aMethod [

	self referencesOf: aMethod do: [ :aVariable | 
		self atEntry: aVariable remove: aMethod ]
]

{ #category : #private }
AlpReferencesIndex >> referencesOf: aMethod do: aBlock [

	(aMethod literals 
		select: [ :each | each isVariableBinding ]) asSet
		do: [ :each | aBlock value: each key ]
]
