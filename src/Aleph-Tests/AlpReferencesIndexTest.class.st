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
	
	self index indexMethod: AlpIndexTestCase >> #method1.
	
	self assert: (self index referencesTo: #Object) size equals: 1.
	self assert: (self index referencesTo: #DoesNotExist) isEmpty

]
