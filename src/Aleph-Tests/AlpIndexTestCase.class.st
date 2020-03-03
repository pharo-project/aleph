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
	
	^ AptMockOriginal >> #method1
]

{ #category : #templates }
AlpIndexTestCase >> compiledMethod1Modified [
	
	^ AptMockModified >> #method1
]

{ #category : #accessing }
AlpIndexTestCase >> index [

	^ index
]

{ #category : #accessing }
AlpIndexTestCase >> indexClass [

	^ self subclassResponsibility
]

{ #category : #running }
AlpIndexTestCase >> setUp [

	index := self indexClass new
]
