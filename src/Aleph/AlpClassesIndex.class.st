Class {
	#name : #AlpClassesIndex,
	#superclass : #AlpTrieIndex,
	#category : #Aleph
}

{ #category : #'updating - classes' }
AlpClassesIndex >> class: aClass renamedFrom: oldName to: newName [

	self removeEntry: oldName.
	self atEntry: newName add: aClass
]

{ #category : #'updating - classes' }
AlpClassesIndex >> classAdded: aClass [

	self atEntry: aClass name add: aClass.

]

{ #category : #'updating - classes' }
AlpClassesIndex >> classRemoved: aClass [

	self atEntry: aClass name remove: aClass.

]
