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

{ #category : #updating }
AlpImplementorsIndex >> methodAdded: aMethod [

	self indexMethod: aMethod
]

{ #category : #updating }
AlpImplementorsIndex >> methodModifiedFrom: oldMethod to: newMethod [
	"Do nothing. Modify a method does not change implementor name"
]

{ #category : #'as yet unclassified' }
AlpImplementorsIndex >> methodRemoved: aMethod [
	
	self 
		remove: aMethod 
		fromEntry: aMethod selector
]
