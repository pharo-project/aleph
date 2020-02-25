Class {
	#name : #AlpLiteralCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'literals'
	],
	#category : #Aleph
}

{ #category : #initialization }
AlpLiteralCollector >> initialize [

	super initialize.
	literals := Set new
]

{ #category : #accessing }
AlpLiteralCollector >> literals [

	^ literals
]

{ #category : #visiting }
AlpLiteralCollector >> visitLiteralNode: aLiteralNode [
	| value |
	
	value := aLiteralNode value.
	value isSymbol ifFalse: [ ^ self ].
	literals add: value
]

{ #category : #visiting }
AlpLiteralCollector >> visitMessageNode: aRBMessageNode [

	literals add: aRBMessageNode selector.
	super visitMessageNode: aRBMessageNode
]

{ #category : #visiting }
AlpLiteralCollector >> visitPragmaNode: aPragmaNode [

	literals add: aPragmaNode selector.
	super visitPragmaNode: aPragmaNode
]
