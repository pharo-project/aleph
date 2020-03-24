Class {
	#name : #AlpIndex,
	#superclass : #Object,
	#instVars : [
		'statistics'
	],
	#category : #Aleph
}

{ #category : #updating }
AlpIndex >> beginRebuild [
]

{ #category : #'updating - classes' }
AlpIndex >> class: aClass renamedFrom: oldName to: newName [

	"This method should be overriden if the index is interested in aClass"
]

{ #category : #'updating - classes' }
AlpIndex >> classAdded: aClass [

	"This method should be overriden if the index is interested in Classes"
]

{ #category : #'updating - classes' }
AlpIndex >> classRemoved: aClass [

	"This method should be overriden if the index is interested in aClass"
]

{ #category : #updating }
AlpIndex >> endRebuild [
]

{ #category : #'updating - methods' }
AlpIndex >> methodAdded: aMethod [

	"This method should be overriden if the index is interested in methods"
]

{ #category : #'updating - methods' }
AlpIndex >> methodModifiedFrom: oldMethod to: newMethod [ 

	self methodRemoved: oldMethod.
	self methodAdded: newMethod
	
]

{ #category : #'updating - methods' }
AlpIndex >> methodRemoved: aMethod [

	"This method should be overriden if the index is interested in methods"
]

{ #category : #'instance creation' }
AlpIndex >> referencesTo: aString [ 

	self subclassResponsibility
]

{ #category : #accessing }
AlpIndex >> statistics: aDictionary [

	statistics := aDictionary
]
