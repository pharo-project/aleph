"
I implement an index on top of all the implemented methods in the system.
Providing full-text search.

I provide an access to all the implementors and this is heavily used by the Spotter implementation.
"
Class {
	#name : #AlpImplementorsIndex,
	#superclass : #AlpTrieIndex,
	#category : #Aleph
}

{ #category : #updating }
AlpImplementorsIndex >> initialTableSize [

	^ statistics at: #numberOfSymbols
]

{ #category : #'updating - methods' }
AlpImplementorsIndex >> methodAdded: aMethod [

	self atEntry: aMethod selector add: aMethod.

]

{ #category : #'updating - methods' }
AlpImplementorsIndex >> methodRemoved: aMethod [

	self atEntry: aMethod selector remove: aMethod
]
