"
I implement a Implementors index by using a table. 
I have an additional collection for the mapping of a symbol to the methods implementing it.
I split the words of a selector by using camel case.
"
Class {
	#name : #AlpImplementorsIndexWithTable,
	#superclass : #AlpTableBasedIndex,
	#traits : 'TAlpImplementorsIndex',
	#classTraits : 'TAlpImplementorsIndex classTrait',
	#instVars : [
		'selectorsMap'
	],
	#category : #'Aleph-TableBased'
}

{ #category : #updating }
AlpImplementorsIndexWithTable >> atEntry: aKey add: aValue [ 

	| aSet |
	super atEntry: aKey add: aValue.
	aSet := selectorsMap at: aKey ifAbsentPut: [ Set new ].
	aSet add: aValue.

		
]

{ #category : #updating }
AlpImplementorsIndexWithTable >> atEntry: aKey remove: aMethod [

	| aSet |
	aSet := selectorsMap at: aKey ifAbsent: [ ^ self removeEntry: aKey ].
	aSet remove: aMethod ifAbsent: [  ].
	
	aSet ifEmpty: [ ^ self removeEntry: aKey ].
]

{ #category : #updating }
AlpImplementorsIndexWithTable >> beginRebuild [ 

	super beginRebuild.

	selectorsMap := Dictionary new: (self statistics at: #numberOfSymbols) 
]

{ #category : #initialization }
AlpImplementorsIndexWithTable >> initialize [
	
	super initialize.
	selectorsMap := Dictionary new
	
]

{ #category : #updating }
AlpImplementorsIndexWithTable >> removeEntry: aKey [

	super removeEntry: aKey.
	selectorsMap removeKey: aKey ifAbsent: [ ^ self ].
	
		
]

{ #category : #private }
AlpImplementorsIndexWithTable >> resolveName: aString do: aBlock [

	^ selectorsMap
		  at: aString
		  ifPresent: [ :aSet | aSet do: aBlock ]
		  ifAbsent: [  ]
]

{ #category : #private }
AlpImplementorsIndexWithTable >> withWordsOf: aMethod do: aBlock [

	^ aMethod selector splitCamelCase do: aBlock
]
