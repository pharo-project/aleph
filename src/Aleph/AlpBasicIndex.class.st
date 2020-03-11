Class {
	#name : #AlpBasicIndex,
	#superclass : #Object,
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

{ #category : #updating }
AlpBasicIndex >> indexMethod: aMethod [

	self subclassResponsibility 
]

{ #category : #initialization }
AlpBasicIndex >> initialize [

	super initialize.
	table := IdentityDictionary new
]

{ #category : #updating }
AlpBasicIndex >> methodAdded: aMethod [

	self indexMethod: aMethod
]

{ #category : #updating }
AlpBasicIndex >> methodModifiedFrom: oldMethod to: newMethod [ 

	self methodRemoved: oldMethod.
	self methodAdded: newMethod
	
]

{ #category : #accessing }
AlpBasicIndex >> referencesTo: aString [ 
	
	^ table at: aString ifAbsent: #()
]
