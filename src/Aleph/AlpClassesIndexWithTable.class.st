"
I implement the trait for classes index.
Also I resolve the names looking in the current environment. 
When using a word based query for the substrings, I split the name of the class removing the prefix. 
"
Class {
	#name : #AlpClassesIndexWithTable,
	#superclass : #AlpTableBasedIndex,
	#traits : 'TAlpClassesIndex',
	#classTraits : 'TAlpClassesIndex classTrait',
	#category : #'Aleph-TableBased'
}

{ #category : #private }
AlpClassesIndexWithTable >> resolveName: aName do: aBlock [

	^ self class environment
		  at: aName
		  ifPresent: [ :aClass | aBlock value: aClass ]
]

{ #category : #private }
AlpClassesIndexWithTable >> withWordsOf: aClass do: aBlock [

	| name |

	name := aClass name.
	aClass package prefixes 
		detect: [ :e | aClass name beginsWith: e ] 
		ifFound: [ :e | 
			name := aClass name allButFirst: e size. 
			(name isNotEmpty and: [name first isLowercase])
			 ifTrue: [ name := aClass name allButFirst: e size - 1  ].
			
			[name isNotEmpty and: [name first isDigit]]
				whileTrue: [ name := name allButFirst ]].
		
	name ifNotEmpty: [name splitCamelCase do: aBlock]
]
