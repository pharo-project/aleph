Class {
	#name : #AlpImplementorsIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpImplementorsIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpImplementorsIndex >> indexMethod: aMethod [

	(self indexAt: aMethod selector) add: aMethod
]
