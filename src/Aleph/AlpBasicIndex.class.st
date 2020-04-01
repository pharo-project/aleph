"
I am the basic index in Aleph. 
My subclasses should implement the response to the different system events that an index is interested in. 

Basically, I implement a Dictionary with all the index entries. Inside each entry there is an array to store the elements that correspond to the entry.

My subclasses should provide also the initialTableSize to customize how the table is initialized during the building of the index.
"
Class {
	#name : #AlpBasicIndex,
	#superclass : #AlpIndex,
	#instVars : [
		'table',
		'duringRebuild'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpBasicIndex >> atEntry: aString add: aMethod [

	duringRebuild ifTrue: [  
		(table 
			at: aString 
			ifAbsentPut: [ IdentitySet new:100 ])
			add: aMethod.
		^ self ].

	table
		at: aString
		update: [ :previous | 
			previous 
				ifNotNil: [ previous copyWith: aMethod ]
				ifNil: [ { aMethod } ]  ]
		initial: [ { aMethod } ]
]

{ #category : #updating }
AlpBasicIndex >> atEntry: aString remove: aMethod [ 
	
	^ table 
		at: aString 
		update: [ :previous | previous copyWithout: aMethod ] 
		initial: [ nil ]
]

{ #category : #updating }
AlpBasicIndex >> beginRebuild [
	
	duringRebuild := true.
]

{ #category : #updating }
AlpBasicIndex >> clear [

	self initialize.
]

{ #category : #updating }
AlpBasicIndex >> endRebuild [

	duringRebuild := false.
	table associationsDo: [ :assoc | assoc value: (assoc value asArray) ]
]

{ #category : #accessing }
AlpBasicIndex >> initialTableSize [

	^ self subclassResponsibility 
]

{ #category : #initialization }
AlpBasicIndex >> initialize [

	super initialize.
	table := IdentityDictionary new: 10000.
	duringRebuild := false.
]

{ #category : #accessing }
AlpBasicIndex >> referencesTo: aString [ 
	
	^ table at: aString ifAbsent: #()
]
