Class {
	#name : #AlpEncodedSpecialLiteralMapProvider,
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
AlpEncodedSpecialLiteralMapProvider class >> mapFor: anEncoderClass [

	^ self uniqueInstance mapAt: anEncoderClass
]

{ #category : #'instance creation' }
AlpEncodedSpecialLiteralMapProvider class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : #'instance creation' }
AlpEncodedSpecialLiteralMapProvider class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #private }
AlpEncodedSpecialLiteralMapProvider >> createMapFor: anEncoderClass [
	| specialLiterals specialLiteralMap |

	specialLiterals := (Smalltalk specialObjectsArray at: 24) select: [ :each | each isSymbol ].
	specialLiteralMap := AlpEncodedSpecialLiteralMap new.
	specialLiteralMap size: specialLiterals size.
	specialLiteralMap firstSpecialSelectorByte: anEncoderClass firstSpecialSelectorByte.
	
	specialLiterals do: [ :literal | 
		specialLiteralMap 
			at: (anEncoderClass firstSpecialSelectorByte + (Smalltalk specialSelectorIndexOrNil: literal))
			put: literal ].	
			
	^ specialLiteralMap
]

{ #category : #initialization }
AlpEncodedSpecialLiteralMapProvider >> initialize [

	super initialize.
	maps := SmallDictionary new
]

{ #category : #accessing }
AlpEncodedSpecialLiteralMapProvider >> mapAt: anEncoderClass [

	^ maps 
		at: anEncoderClass 
		ifAbsentPut: [ self createMapFor: anEncoderClass ]
]
