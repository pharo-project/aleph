"
I am a trait that encapsulates all event handling of a Class index.
In this way I can be used in different implementations. There are a Trie based and a Table based one.
"
Trait {
	#name : #TAlpClassesIndex,
	#category : #'Aleph-Indexes'
}

{ #category : #'updating - classes' }
TAlpClassesIndex >> class: aClass renamedFrom: oldName to: newName [

	aClass isMeta ifTrue: [ ^ self ].

	self removeEntry: oldName.
	self atEntry: newName add: aClass
]

{ #category : #'updating - classes' }
TAlpClassesIndex >> classAdded: aClass [

	aClass isMeta ifTrue: [ ^ self ].

	self atEntry: aClass name add: aClass.

]

{ #category : #'updating - classes' }
TAlpClassesIndex >> classRemoved: aClass [

	aClass isMeta ifTrue: [ ^ self ].
	self atEntry: aClass name remove: aClass.

]

{ #category : #updating }
TAlpClassesIndex >> initialTableSize [

	^ self statistics at: #numberOfClasses
]
