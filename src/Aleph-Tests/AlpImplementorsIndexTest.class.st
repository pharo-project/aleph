Class {
	#name : #AlpImplementorsIndexTest,
	#superclass : #AlpIndexTestCase,
	#category : #'Aleph-Tests'
}

{ #category : #accessing }
AlpImplementorsIndexTest >> indexClass [

	^ AlpImplementorsIndex
]

{ #category : #tests }
AlpImplementorsIndexTest >> testIndexMethod [
	
	self index indexMethod: AlpIndexTestCase >> #method1.
	
	self 
		assert: (self index referencesTo: #method1) size
		equals: 1
]
