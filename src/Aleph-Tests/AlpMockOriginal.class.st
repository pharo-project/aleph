Class {
	#name : #AlpMockOriginal,
	#superclass : #Object,
	#category : #'Aleph-Tests'
}

{ #category : #templates }
AlpMockOriginal >> method1 [
	<aPragma>
	<otherPragma: 42>

	^ self className, 
		(1 + 1) printString, 
		Object name
]

{ #category : #templates }
AlpMockOriginal >> method2WithBlock [
	<aPragma>
	<otherPragma: 42>
	[ Class printString ] value.
	^ self className, 
		(1 + 1) printString, 
		Object name
]
