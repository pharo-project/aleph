Class {
	#name : #AlpGlobalCollectorTest,
	#superclass : #TestCase,
	#category : #Aleph
}

{ #category : #tests }
AlpGlobalCollectorTest >> testClass [
	| ast visitor |
	
	ast := RBParser parseMethod: 'test 
	self test: Object new'.
	
	visitor := AlpGlobalCollector new.
	
	ast acceptVisitor: visitor.
	
	self assert: (visitor globals size) equals: 1.
	self assert: (visitor globals includes: #Object)
]
