Class {
	#name : #AlpEncodedSpecialLiteralMap,
	#superclass : #Object,
	#instVars : [
		'maps'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpEncodedSpecialLiteralMap class >> mapFor: anEncoderClass [

	^ self uniqueInstance mapAt: anEncoderClass
]

{ #category : #'instance creation' }
AlpEncodedSpecialLiteralMap class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : #'instance creation' }
AlpEncodedSpecialLiteralMap class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #private }
AlpEncodedSpecialLiteralMap >> createMapFor: anEncoderClass [
	| specialLiterals specialLiteralMap |

	specialLiterals := (Smalltalk specialObjectsArray at: 24) select: [ :each | each isSymbol ].
	specialLiteralMap := SmallDictionary new: specialLiterals size.
	specialLiterals do: [ :literal | 
		specialLiteralMap 
			at: (anEncoderClass firstSpecialSelectorByte + (Smalltalk specialSelectorIndexOrNil: literal)) 
			put: literal ].	
			
	^ specialLiteralMap
]

{ #category : #initialization }
AlpEncodedSpecialLiteralMap >> initialize [

	super initialize.
	maps := SmallDictionary new
]

{ #category : #accessing }
AlpEncodedSpecialLiteralMap >> mapAt: anEncoderClass [

	^ maps 
		at: anEncoderClass 
		ifAbsentPut: [ self createMapFor: anEncoderClass ]
]
