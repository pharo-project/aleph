Class {
	#name : #AlpImplementorsIndex,
	#superclass : #AlpTrieIndex,
	#category : #Aleph
}

{ #category : #building }
AlpImplementorsIndex >> indexMethod: aMethod [

	self atEntry: aMethod selector add: aMethod.

]

{ #category : #updating }
AlpImplementorsIndex >> methodRemoved: aMethod [

	self atEntry: aMethod selector remove: aMethod
]
