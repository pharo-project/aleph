Class {
	#name : #AptMockModified,
	#superclass : #Object,
	#category : #'Aleph-Tests'
}

{ #category : #templates }
AptMockModified >> method1 [
	<aPragma>

	^ self className, 
		(1 - 1) printString, 
		ProtoObject name
]
