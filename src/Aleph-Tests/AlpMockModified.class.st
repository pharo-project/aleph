Class {
	#name : #AlpMockModified,
	#superclass : #Object,
	#category : #'Aleph-Tests'
}

{ #category : #templates }
AlpMockModified >> method1 [
	<aPragma>

	^ self className, 
		(1 - 1) printString, 
		ProtoObject name
]
