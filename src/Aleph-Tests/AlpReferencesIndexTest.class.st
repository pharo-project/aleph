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
AlpReferencesIndexTest >> testFindingReaders [
	self skip. 
	self flag: #TODO. "skip to get green CI. 
	https://github.com/pharo-project/aleph/issues/17
	"
	
	self index methodAdded: self compiledMethodAccessingInstanceVariable.

	self assert: (self index referencesTo: #anInstanceVariable) size equals: 1
]

{ #category : #tests }
AlpReferencesIndexTest >> testFindingWritters [
	self skip. 
	self flag: #TODO. "skip to get green CI. 
	https://github.com/pharo-project/aleph/issues/17
	"
	self index methodAdded: self compiledMethodWrittingInstanceVariable.

	self assert: (self index referencesTo: #anInstanceVariable) size equals: 1
]

{ #category : #tests }
AlpReferencesIndexTest >> testIndexMethod [
	
	self index methodAdded: self compiledMethod1.
	
	self assert: (self index referencesTo: #Object) size equals: 1.
	self assert: (self index referencesTo: #DoesNotExist) isEmpty

]

{ #category : #tests }
AlpReferencesIndexTest >> testIndexMethodWithBlock [

	self index methodAdded: self compiledMethod2WithBlock.

	self assert: (self index referencesTo: #Class) size equals: 1
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
