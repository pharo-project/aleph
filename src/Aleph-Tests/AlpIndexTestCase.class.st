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

{ #category : #running }
AlpIndexTestCase >> setUp [

	index := self indexClass new
]
