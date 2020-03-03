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
