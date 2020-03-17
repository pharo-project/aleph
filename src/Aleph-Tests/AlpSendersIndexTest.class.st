Class {
	#name : #AlpSendersIndexTest,
	#superclass : #AlpIndexTestCase,
	#category : #'Aleph-Tests'
}

{ #category : #accessing }
AlpSendersIndexTest >> indexClass [

	^ AlpSendersIndex
]

{ #category : #tests }
AlpSendersIndexTest >> testIndexMethod [
	
	self index methodAdded: self compiledMethod1.
	
	self assert: (self index referencesTo: #className) size equals: 1.
	self assert: (self index referencesTo: #name) size equals: 1.
	self assert: (self index referencesTo: #+) size equals: 1.
	self assert: (self index referencesTo: #,) size equals: 1.	
	self assert: (self index referencesTo: #aPragma) size equals: 1.
	self assert: (self index referencesTo: #otherPragma:) size equals: 1.
	
	self assert: (self index referencesTo: #doesNotExit) isEmpty

]

{ #category : #tests }
AlpSendersIndexTest >> testMethodAdded [
	"Same as index method"

	self testIndexMethod
]

{ #category : #tests }
AlpSendersIndexTest >> testMethodModifiedFromTo [

	self index methodAdded: self compiledMethod1.
	self index 
		methodModifiedFrom: self compiledMethod1
		to: self compiledMethod1Modified.
	
	"remains"
	self assert: (self index referencesTo: #className) size equals: 1.
	self assert: (self index referencesTo: #name) size equals: 1.
	self assert: (self index referencesTo: #,) size equals: 1.	
	self assert: (self index referencesTo: #aPragma) size equals: 1.
	"removed"
	self assert: (self index referencesTo: #+) size equals: 0.
	self assert: (self index referencesTo: #otherPragma:) size equals: 0.
	"added"
	self assert: (self index referencesTo: #-) size equals: 1.

]

{ #category : #tests }
AlpSendersIndexTest >> testMethodRemoved [

	self index methodAdded: self compiledMethod1.
	self index methodRemoved: self compiledMethod1.
	
	self assert: (self index referencesTo: #className) size equals: 0.
	self assert: (self index referencesTo: #name) size equals: 0.
	self assert: (self index referencesTo: #+) size equals: 0.
	self assert: (self index referencesTo: #,) size equals: 0.	
	self assert: (self index referencesTo: #aPragma) size equals: 0.
	self assert: (self index referencesTo: #otherPragma:) size equals: 0
]
