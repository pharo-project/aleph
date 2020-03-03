Class {
	#name : #AlpIndex,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : #Aleph
}

{ #category : #building }
AlpIndex >> buildIndex [

	self subclassResponsibility
]

{ #category : #accessing }
AlpIndex >> indexAt: aSymbol [

	^ table 
		at: aSymbol
		ifAbsentPut: [ Set new ]
]

{ #category : #initialization }
AlpIndex >> initialize [

	super initialize.
	table := IdentityDictionary new: self startSize
]

{ #category : #updating }
AlpIndex >> methodAdded: aMethod [

	self indexMethod: aMethod
]

{ #category : #'as yet unclassified' }
AlpIndex >> methodModifiedFrom: oldMethod to: newMethod [
	"Do nothing. Modify a method does not change implementor name"
]

{ #category : #accessing }
AlpIndex >> navigation [

	^ SystemNavigation new
]

{ #category : #accessing }
AlpIndex >> referencesTo: aSymbol [

	^ (table 
		at: aSymbol 
		ifAbsent: [ #() ])
		asArray
]

{ #category : #initialization }
AlpIndex >> startSize [

	^ 1000000
]
