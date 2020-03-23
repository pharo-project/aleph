Class {
	#name : #AlpEncodedSpecialLiteralMap,
	#superclass : #Object,
	#instVars : [
		'literals',
		'initialBytecode'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpEncodedSpecialLiteralMap >> at:anIndex ifPresent: aBlock [ 

	(anIndex between: initialBytecode and: initialBytecode + literals size)
		ifFalse: [ ^ self ].
		
	^ aBlock value: (literals at: anIndex - initialBytecode)
]

{ #category : #accessing }
AlpEncodedSpecialLiteralMap >> at: anIndex put: aValue [

	literals at: anIndex - initialBytecode put: aValue
]

{ #category : #accessing }
AlpEncodedSpecialLiteralMap >> firstSpecialSelectorByte: aValue [

	initialBytecode := aValue
]

{ #category : #accessing }
AlpEncodedSpecialLiteralMap >> size: aSize [

	literals := Array new: aSize
]
