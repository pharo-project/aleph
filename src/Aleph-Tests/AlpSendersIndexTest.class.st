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
	
	self index indexMethod: AlpIndexTestCase >> #method1.
	
	self assert: (self index referencesTo: #className) size equals: 1.
	self assert: (self index referencesTo: #name) size equals: 1.
	self assert: (self index referencesTo: #+) size equals: 1.
	self assert: (self index referencesTo: #,) size equals: 1.	
	self assert: (self index referencesTo: #aPragma) size equals: 1.
	self assert: (self index referencesTo: #otherPragma:) size equals: 1.
	
	self assert: (self index referencesTo: #doesNotExit) isEmpty

]
