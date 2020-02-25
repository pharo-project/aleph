Class {
	#name : #AlpGlobalCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'globals'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpGlobalCollector >> globals [

	^ globals
]

{ #category : #initialization }
AlpGlobalCollector >> initialize [

	super initialize.
	globals := Set new
]

{ #category : #visiting }
AlpGlobalCollector >> visitGlobalNode: aRBGlobalNode [ 
	
	globals add: aRBGlobalNode name.
	super visitGlobalNode: aRBGlobalNode
]

{ #category : #visiting }
AlpGlobalCollector >> visitVariableNode: aVariableNode [
	| name |
	
	name := aVariableNode name.
	(name first isUppercase 
		and: [ Smalltalk globals includesKey: name ])
		ifTrue: [ globals add: name ].
		
	^ super visitVariableNode: aVariableNode
]
