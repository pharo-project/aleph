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
		(table at: aString ifAbsentPut: [ IdentitySet new:100 ])
			add: aMethod.
		^ self ].

	table
		at: aString
		update: [ :previous | previous ifNil: [ aMethod ] ifNotNil: [ previous copyWith: aMethod ] ]
		initial: {aMethod}
]

{ #category : #updating }
AlpBasicIndex >> atEntry: aString remove: aMethod [ 
	
	^ table at: aString update: [ :previous | previous copyWithout: aMethod ] initial: [ nil ]
]

{ #category : #updating }
AlpBasicIndex >> beginRebuild [
	
	duringRebuild := true.
]

{ #category : #updating }
AlpBasicIndex >> endRebuild [

	duringRebuild := false.
	table associationsDo: [ :assoc | assoc value: (assoc value asArray) ]
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
