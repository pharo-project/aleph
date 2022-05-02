"
I am an implementation with a SortedCollection of the names stored in my.
I do the lookup for perfect match and for begins with queries by doing a binary search in the SortedCollection.
The contains is delegated to an strategy. This strategy can handle different ways (fasters vs smallers).
I only know how to store string keys to string values. My subclasses knows how to resolve the name to the proper values.
"
Class {
	#name : #AlpTableBasedIndex,
	#superclass : #AlpIndex,
	#instVars : [
		'entries',
		'substringStrategy'
	],
	#category : #'Aleph-TableBased'
}

{ #category : #updating }
AlpTableBasedIndex >> atEntry: aKey add: aValue [ 

	entries add: aKey.

	substringStrategy atEntry: aKey add: aValue for: self.

]

{ #category : #updating }
AlpTableBasedIndex >> atEntry: aKey remove: aValue [ 

	self removeEntry: aKey.

]

{ #category : #updating }
AlpTableBasedIndex >> beginRebuild [ 

	super beginRebuild.

	entries := SortedCollection new: self initialTableSize.
	substringStrategy beginRebuildFor: self
]

{ #category : #updating }
AlpTableBasedIndex >> clear [

	self initialize
]

{ #category : #accessing }
AlpTableBasedIndex >> entries [
	^ entries
]

{ #category : #updating }
AlpTableBasedIndex >> initialTableSize [ 

	self subclassResponsibility 
]

{ #category : #'instance creation' }
AlpTableBasedIndex >> initialize [
	
	super initialize.
	entries := SortedCollection new.
	substringStrategy := AlpDummyTableBasedSubstringStrategy new

]

{ #category : #querying }
AlpTableBasedIndex >> referencesBeginningWith: aString do: aBlockClosure [ 

	self withAllValuesBeginningWith: aString do: [ :aResult | aBlockClosure value: { aResult } ] 
]

{ #category : #querying }
AlpTableBasedIndex >> referencesContaining: aString do: aBlock [

	self withAllValuesWithSubstring: aString do: [ :aResult | aBlock value: { aResult } ]
]

{ #category : #querying }
AlpTableBasedIndex >> referencesTo: aString [ 

	| results |

	(entries binarySearchIncludes: aString) ifFalse: [ ^#() ].

	results := OrderedCollection new.
	self resolveName: aString do: [ :aResult | results add: aResult ]. 
	^ results.

]

{ #category : #updating }
AlpTableBasedIndex >> removeEntry: aString [ 
	
	entries remove: aString ifAbsent: [  ].

	substringStrategy removeEntry: aString for: self.

"	myWords := wordsCollections associations 
		select: [ :assoc | assoc value includes: aString ] 
		thenCollect: [:assoc | assoc key].

	myWords do: [ :aWord |
		wordCollection := wordsCollections at: aWord.
		wordCollection remove: aString.
		wordCollection 
			ifEmpty: [ words remove: aWord ifAbsent: [] ] ]. "
]

{ #category : #private }
AlpTableBasedIndex >> resolveName: aString do: aBlock [

	self subclassResponsibility 
]

{ #category : #resetting }
AlpTableBasedIndex >> shutdown [
	
	entries := nil.
]

{ #category : #query }
AlpTableBasedIndex >> withAllSelectorsBeginningWith: aString do: aBlockClosure [
	| first found |
	first := entries binarySearchMinimalIndexOf: aString.
	first isZero ifTrue: [^self].
	first to: entries size
		do: 
			[:i |
			found := entries at: i.
			(found beginsWith: aString)
				ifTrue: [aBlockClosure value: found]
				ifFalse: [^self]]
]

{ #category : #querying }
AlpTableBasedIndex >> withAllValuesBeginningWith: aString do: aBlockClosure [ 
	
	| first found |
	first := entries binarySearchMinimalIndexOf: aString.
	first to: entries size do: [ :i | 
		found := entries at: i.
		(found beginsWith: aString)
			ifTrue: [ self resolveName: found do: aBlockClosure ]
			ifFalse: [ ^ self ] ]
]

{ #category : #querying }
AlpTableBasedIndex >> withAllValuesWithSubstring: aString do: aBlock [ 
	
	self withAllValuesBeginningWith: aString do: aBlock.
		
	substringStrategy findSubstring: aString in: self thenDo: aBlock.

]

{ #category : #private }
AlpTableBasedIndex >> withWordsOf: aValue do: aBlock [

	self subclassResponsibility 
]
