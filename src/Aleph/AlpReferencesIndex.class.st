"
I am the index to store the references to a given class.
I index the name of the global accessible variables and store them in a table with the class that they refer to. 
"
Class {
	#name : #AlpReferencesIndex,
	#superclass : #AlpBasicIndex,
	#category : #Aleph
}

{ #category : #accessing }
AlpReferencesIndex >> initialTableSize [

	^ statistics at: #numberOfClasses
]

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

	(aMethod literalsEvenTheOnesInTheInnerBlocks 
		select: [ :each | each isVariableBinding ]) asSet
		do: [ :each | aBlock value: each key ]
]
