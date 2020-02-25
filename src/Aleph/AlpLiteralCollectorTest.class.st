Class {
	#name : #AlpLiteralCollectorTest,
	#superclass : #TestCase,
	#category : #Aleph
}

{ #category : #tests }
AlpLiteralCollectorTest >> testMessage [
	| ast visitor |
	
	ast := RBParser parseMethod: 'test 
	self test: 42'.
	
	visitor := AlpLiteralCollector new.
	
	ast acceptVisitor: visitor.
	
	self assert: (visitor literals size) equals: 1.
	self assert: (visitor literals includes: #test:)
]

{ #category : #tests }
AlpLiteralCollectorTest >> testMessages [
	| ast visitor |
	
	ast := RBParser parseMethod: 'test 
	self test: 42.
	self test: 43.
	self otherMessage'.
	
	visitor := AlpLiteralCollector new.
	
	ast acceptVisitor: visitor.
	
	self assert: (visitor literals size) equals: 2.
	self assert: (visitor literals includes: #test:).
	self assert: (visitor literals includes: #otherMessage)	
]

{ #category : #tests }
AlpLiteralCollectorTest >> testPragmas [
	| ast visitor |
	
	ast := RBParser parseMethod: 'test 
	<aPragma>
	<aPragma: true>
	
	self test: 42 = 42.
	self test: 43 < 42.
	self otherMessage'.
	
	visitor := AlpLiteralCollector new.
	ast acceptVisitor: visitor.

	self assert: (visitor literals includes: #aPragma).
	self assert: (visitor literals includes: #aPragma:)
]

{ #category : #tests }
AlpLiteralCollectorTest >> testSpecialLiterals [
	| ast visitor |
	
	ast := RBParser parseMethod: 'test 
	self test: 42 = 42.
	self test: 43 < 42.
	self otherMessage'.
	
	visitor := AlpLiteralCollector new.
	ast acceptVisitor: visitor.

	self assert: (visitor literals includes: #=).
	self assert: (visitor literals includes: #<)
]
