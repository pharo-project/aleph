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
		ifAbsentPut: [ WeakSet new ]
]

{ #category : #initialization }
AlpIndex >> initialize [

	super initialize.
	table := IdentityDictionary new: self startSize
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
