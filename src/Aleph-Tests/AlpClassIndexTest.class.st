Class {
	#name : #AlpClassIndexTest,
	#superclass : #AlpIndexTestCase,
	#instVars : [
		'classes'
	],
	#category : #'Aleph-Tests'
}

{ #category : #accessing }
AlpClassIndexTest >> indexClass [

	^ AlpClassesIndex
]

{ #category : #utils }
AlpClassIndexTest >> newClass: aName [ 	
	^ self newClass: aName superclass: Object slots: #()
]

{ #category : #utils }
AlpClassIndexTest >> newClass: aName superclass: aSuperclass slots: someSlots [

	| aClass |
	aClass := aSuperclass subclass: aName slots: someSlots classVariables: '' poolDictionaries: '' package: self class package name.
	classes add: aClass.
	
	^ aClass
]

{ #category : #accessing }
AlpClassIndexTest >> setUp [ 
	
	super setUp.
	classes := OrderedCollection new
]

{ #category : #accessing }
AlpClassIndexTest >> tearDown [ 

	classes ifNotNil: [ classes do: [ :eachClass | eachClass removeFromSystem ] ]
]

{ #category : #tests }
AlpClassIndexTest >> testClassAdded [
	
	| c1 |
	c1 := self newClass: #AlpClassForTest1.
	self index classAdded: c1.
	
	self assert: (self index referencesTo: #AlpClassForTest1) size equals: 1.
	self assertCollection: (self index referencesTo: #AlpClassForTest1) hasSameElements: { c1 }.

]

{ #category : #tests }
AlpClassIndexTest >> testClassAddedAndThenRemoved [
	
	| c1 |
	c1 := self newClass: #AlpClassForTest1.
	self index classAdded: c1.

	self assert: (self index referencesTo: #AlpClassForTest1) size equals: 1.
	self assertCollection: (self index referencesTo: #AlpClassForTest1) hasSameElements: { c1 }.

	self index classRemoved: c1.
	
	self assert: (self index referencesTo: #AlpClassForTest1) size equals: 0.
	self assertCollection: (self index referencesTo: #AlpClassForTest1) hasSameElements: {}.

]

{ #category : #tests }
AlpClassIndexTest >> testClassAddedAndThenRenamed [
	
	| c1 |
	c1 := self newClass: #AlpClassForTest1.
	self index classAdded: c1.

	self assert: (self index referencesTo: #AlpClassForTest1) size equals: 1.
	self assertCollection: (self index referencesTo: #AlpClassForTest1) hasSameElements: { c1 }.

	c1 rename: #AlpClassForTest2.
	self index class: c1 renamedFrom: #AlpClassForTest1 to: #AlpClassForTest2.
	
	self assert: (self index referencesTo: #AlpClassForTest1) size equals: 0.
	self assertCollection: (self index referencesTo: #AlpClassForTest1) hasSameElements: {}.
	self assert: (self index referencesTo: #AlpClassForTest2) size equals: 1.
	self assertCollection: (self index referencesTo: #AlpClassForTest2) hasSameElements: {c1}.

]
