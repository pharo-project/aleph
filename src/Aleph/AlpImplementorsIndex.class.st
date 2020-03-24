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
