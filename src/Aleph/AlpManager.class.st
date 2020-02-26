Class {
	#name : #AlpManager,
	#superclass : #Object,
	#instVars : [
		'indexes',
		'navigation'
	],
	#classVars : [
		'Active',
		'Default'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpManager class >> activate [

	Active := true
]

{ #category : #accessing }
AlpManager class >> deactivate [

	Active := false
]

{ #category : #accessing }
AlpManager class >> default [

	^ Default ifNil: [ Default := self new ]
]

{ #category : #testing }
AlpManager class >> isActive [

	^ Active ifNil: [ 
		self deactivate.
		Active ]
]

{ #category : #query }
AlpManager >> findImplementorsOf: aLiteral [

	^ (self indexAt: AlpImplementorsIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpManager >> findReferencesTo: aLiteral [

	^ (self indexAt: AlpReferencesIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpManager >> findSendersOf: aLiteral [

	^ (self indexAt: AlpSendersIndex) referencesTo: aLiteral
]

{ #category : #private }
AlpManager >> indexAt: aClass [

	^ indexes detect: [ :each | each class = aClass ]
]

{ #category : #accessing }
AlpManager >> navigation [

	^ navigation ifNil: [ SystemNavigation default ]
]

{ #category : #accessing }
AlpManager >> navigation: aNavigation [

	navigation := aNavigation
]

{ #category : #initialization }
AlpManager >> newDefaultIndexes [

	^ { 
	AlpImplementorsIndex new.
	AlpReferencesIndex new.
	AlpSendersIndex new.
	 }
]

{ #category : #updating }
AlpManager >> rebuildAll [

	indexes := self newDefaultIndexes.
	self navigation allMethodsDo: [ :eachMethod |
		indexes do: [ :eachIndex | eachIndex indexMethod: eachMethod ] ]
]
