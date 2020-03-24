"
I implement an index on top of all the classes in the system.
Providing full-text search.
"
Class {
	#name : #AlpClassesIndex,
	#superclass : #AlpTrieIndex,
	#category : #Aleph
}

{ #category : #'updating - classes' }
AlpClassesIndex >> class: aClass renamedFrom: oldName to: newName [

	aClass isMeta ifTrue: [ ^ self ].

	self removeEntry: oldName.
	self atEntry: newName add: aClass
]

{ #category : #'updating - classes' }
AlpClassesIndex >> classAdded: aClass [

	aClass isMeta ifTrue: [ ^ self ].

	self atEntry: aClass name add: aClass.

]

{ #category : #'updating - classes' }
AlpClassesIndex >> classRemoved: aClass [

	aClass isMeta ifTrue: [ ^ self ].
	self atEntry: aClass name remove: aClass.

]

{ #category : #updating }
AlpClassesIndex >> initialTableSize [

	^ statistics at: #numberOfClasses
]
