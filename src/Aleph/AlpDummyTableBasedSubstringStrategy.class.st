"
I have a really dummy implementation for the substring strategy.
I just traverse all entries in the index and calculates the contains. 
I am the smallest possible implementation but also the slowest
"
Class {
	#name : #AlpDummyTableBasedSubstringStrategy,
	#superclass : #Object,
	#category : #'Aleph-TableBased'
}

{ #category : #updating }
AlpDummyTableBasedSubstringStrategy >> atEntry: aString add: aValue for: anIndex [ 
	
	"I do nothing, I am dummy"
]

{ #category : #updating }
AlpDummyTableBasedSubstringStrategy >> beginRebuildFor: anIndex [
]

{ #category : #querying }
AlpDummyTableBasedSubstringStrategy >> findSubstring: aString in: index thenDo: aBlock [ 

	index entries do: [ :anEntry | 
		(anEntry asLowercase includesSubstring: aString asLowercase)
			ifTrue: [ index resolveName: anEntry do: aBlock ]]

]

{ #category : #updating }
AlpDummyTableBasedSubstringStrategy >> removeEntry: aString for: anIndex [	
	"I do nothing, I am dummy"
]
