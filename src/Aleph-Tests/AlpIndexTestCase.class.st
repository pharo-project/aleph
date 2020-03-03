Class {
	#name : #AlpIndexTestCase,
	#superclass : #TestCase,
	#instVars : [
		'index'
	],
	#category : #'Aleph-Tests'
}

{ #category : #testing }
AlpIndexTestCase class >> isAbstract [

	^ self = AlpIndexTestCase
]

{ #category : #templates }
AlpIndexTestCase >> compiledMethod1 [
	
	^ AlpIndexTestCase >> #method1
]

{ #category : #templates }
AlpIndexTestCase >> compiledMethod1Modified [
	
	^ (AlpIndexTestCase >> #method1) copyWithSource: (AlpIndexTestCase >> #method1Modified) sourceCode
]

{ #category : #accessing }
AlpIndexTestCase >> index [

	^ index
]

{ #category : #accessing }
AlpIndexTestCase >> indexClass [

	^ self subclassResponsibility
]

{ #category : #templates }
AlpIndexTestCase >> method1 [
	<aPragma>
	<otherPragma: 42>

	^ self className, 
		(1 + 1) printString, 
		Object name
]

{ #category : #templates }
AlpIndexTestCase >> method1Modified [
	<aPragma>
	<otherPragma: 42>

	^ self className, 
		(1 - 1) printString, 
		ProtoObject name
]

{ #category : #running }
AlpIndexTestCase >> setUp [

	index := self indexClass new
]
