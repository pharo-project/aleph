"
I am an index manager, charged with the task of concentrate all system indexes and accessors to it. 
The find* methods provide access to the contained indexes.
The manager subscribes to SystemAnnouncer to listen system changes (method addition, modification and removals), in order to keep the indexes up-to date.

We use a special task it runner in low priority to update the indexes in background, when the system is idle.

The method rebuildAll will discard all previously existing indexes and re-build all from scratch. 
"
Class {
	#name : #AlpIndexManager,
	#superclass : #Object,
	#instVars : [
		'indexes',
		'navigation'
	],
	#classVars : [
		'Active',
		'Current'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpIndexManager class >> activate [

	Active := true
]

{ #category : #'instance creation' }
AlpIndexManager class >> current [

	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
AlpIndexManager class >> deactivate [

	Active := false
]

{ #category : #testing }
AlpIndexManager class >> isActive [

	^ Active ifNil: [ 
		self deactivate.
		Active ]
]

{ #category : #query }
AlpIndexManager >> findImplementorsOf: aLiteral [

	^ (self indexAt: AlpImplementorsIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findReferencesTo: aLiteral [

	^ (self indexAt: AlpReferencesIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findSendersOf: aLiteral [

	^ (self indexAt: AlpSendersIndex) referencesTo: aLiteral
]

{ #category : #private }
AlpIndexManager >> indexAt: aClass [

	^ indexes detect: [ :each | each class = aClass ]
]

{ #category : #accessing }
AlpIndexManager >> navigation [

	^ navigation ifNil: [ SystemNavigation default ]
]

{ #category : #accessing }
AlpIndexManager >> navigation: aNavigation [

	navigation := aNavigation
]

{ #category : #initialization }
AlpIndexManager >> newDefaultIndexes [

	^ { 
	AlpImplementorsIndex new.
	AlpReferencesIndex new.
	AlpSendersIndex new.
	 }
]

{ #category : #updating }
AlpIndexManager >> rebuildAll [

	indexes := self newDefaultIndexes.
	self navigation allMethodsDo: [ :eachMethod |
		indexes do: [ :eachIndex | eachIndex indexMethod: eachMethod ] ]
]

{ #category : #initialization }
AlpIndexManager >> subscribeToSystemAnnouncer [

		ClassAdded-> #behaviorAdded:.
		ClassRemoved->#behaviorRemoved:.
		MethodAdded -> #methodAdded:.
		MethodRemoved -> #methodRemoved:.
		MethodModified -> #methodModified:.
	
]
