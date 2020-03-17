Class {
	#name : #AlpReferencesIndexTest,
	#superclass : #AlpIndexTestCase,
	#category : #'Aleph-Tests'
}

{ #category : #accessing }
AlpReferencesIndexTest >> indexClass [

	^ AlpReferencesIndex
]

{ #category : #tests }
AlpReferencesIndexTest >> testIndexMethod [
	
	self index methodAdded: self compiledMethod1.
	
	self assert: (self index referencesTo: #Object) size equals: 1.
	self assert: (self index referencesTo: #DoesNotExist) isEmpty

]

{ #category : #tests }
AlpReferencesIndexTest >> testMethodAdded [
	"Self as indexMethod"

	self testIndexMethod
]

{ #category : #tests }
AlpReferencesIndexTest >> testMethodModifiedFromTo [

	self index methodAdded: self compiledMethod1.

	self index
		methodModifiedFrom: self compiledMethod1
		to: self compiledMethod1Modified.

	self assert: (self index referencesTo: #Object) size equals: 0.
	self assert: (self index referencesTo: #ProtoObject) size equals: 1
]

{ #category : #tests }
AlpReferencesIndexTest >> testMethodRemoved [
	
	self index methodAdded: self compiledMethod1.
	self index methodRemoved: self compiledMethod1.
	
	self assert: (self index referencesTo: #Object) size equals: 0
]
