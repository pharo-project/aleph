Class {
	#name : #AptMockOriginal,
	#superclass : #Object,
	#category : #'Aleph-Tests'
}

{ #category : #templates }
AptMockOriginal >> method1 [
	<aPragma>
	<otherPragma: 42>

	^ self className, 
		(1 + 1) printString, 
		Object name
]
