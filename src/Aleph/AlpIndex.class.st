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

{ #category : #updating }
AlpIndex >> methodAdded: aMethod [

	self subclassResponsibility
]

{ #category : #updating }
AlpIndex >> methodModifiedFrom: oldMethod to: newMethod [ 

	self methodRemoved: oldMethod.
	self methodAdded: newMethod
	
]

{ #category : #updating }
AlpIndex >> methodRemoved: aMethod [

	self subclassResponsibility
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

{ #category : #private }
AlpIndex >> remove: aMethod fromEntry: aSymbol [
	| set |

	set := self indexAt: aSymbol.
	set remove: aMethod ifAbsent: [].
	set ifEmpty: [ 
		table removeKey: aSymbol ifAbsent: [] ]
]

{ #category : #initialization }
AlpIndex >> startSize [

	^ 1000000
]

{ #category : #accessing }
AlpIndex >> table [

	^ table
]
