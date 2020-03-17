Class {
	#name : #AlpBasicIndex,
	#superclass : #AlpIndex,
	#instVars : [
		'table'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpBasicIndex >> atEntry: aString add: aMethod [

	table
		at: aString
		update: [ :previous | previous copyWith: aMethod ]
		initial: {aMethod}
]

{ #category : #updating }
AlpBasicIndex >> atEntry: aString remove: aMethod [ 
	
	^ table at: aString update: [ :previous | previous copyWithout: aMethod ] initial: [ nil ]
]

{ #category : #updating }
AlpBasicIndex >> beginRebuild [
]

{ #category : #updating }
AlpBasicIndex >> endRebuild [
]

{ #category : #initialization }
AlpBasicIndex >> initialize [

	super initialize.
	table := IdentityDictionary new
]

{ #category : #accessing }
AlpBasicIndex >> referencesTo: aString [ 
	
	^ table at: aString ifAbsent: #()
]
