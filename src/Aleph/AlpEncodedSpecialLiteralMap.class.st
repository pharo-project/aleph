"
I represent a more performant implementation of a map of bytecodes to literals. 
I play with the idea that all the encoded literals in bytecode are calculated from an initial bytecode and then using the array of bytecodes.

I am specific for a given Encoder.
Access to my instances through #AlpEncodedSpecialLiteralMapProvider
"
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
