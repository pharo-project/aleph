"
I implement a simple substring lookup by using two collections.
A SortedCollection with the words, and then a Dictionary that maps the words to the names containing that word.
Like this I have a balanced version between speed and space.
"
Class {
	#name : #AlpWordBasedTableBasedSubstringStrategy,
	#superclass : #Object,
	#instVars : [
		'words',
		'wordsCollections'
	],
	#category : #'Aleph-TableBased'
}

{ #category : #updating }
AlpWordBasedTableBasedSubstringStrategy >> atEntry: aKey add: aValue for: anIndex [

	| aSet |

	anIndex withWordsOf: aValue do: [ :aWord |
		aWord size >= 4  ifTrue: [ 		
			(words binarySearchIncludes: aWord) ifFalse: [words add: aWord].
			aSet := wordsCollections at: aWord ifAbsentPut: [ Set new ].
			aSet add: aKey ]]. 
]

{ #category : #updating }
AlpWordBasedTableBasedSubstringStrategy >> beginRebuildFor: anIndex [

	wordsCollections := Dictionary new: anIndex initialTableSize.
	words := SortedCollection new: anIndex initialTableSize
]

{ #category : #enumerating }
AlpWordBasedTableBasedSubstringStrategy >> findSubstring: aString in: index thenDo: aBlock [ 

	| first found |
	first := words binarySearchMinimalIndexOf: aString.
	first to: words size do: [ :i | 
		found := words at: i.
		(found beginsWith: aString)
			ifTrue: [ 
				(wordsCollections at: found) do: [ :e | index resolveName: e do: aBlock  ]]
			ifFalse: [ ^ self ] ]
]

{ #category : #initialization }
AlpWordBasedTableBasedSubstringStrategy >> initialize [

	super initialize.
	words := SortedCollection new.
	wordsCollections := Dictionary new.
]

{ #category : #updating }
AlpWordBasedTableBasedSubstringStrategy >> removeEntry: aString for: anIndex [	

	| myWords aSet |
	myWords := wordsCollections associations 
		select: [ :assoc | assoc value includes: aString ] 
		thenCollect: [:assoc | assoc key].

	myWords do: [ :aWord |
		aSet := wordsCollections at: aWord.
		aSet remove: aString.
		aSet 
			ifEmpty: [ words remove: aWord ifAbsent: [] ] ].
]
