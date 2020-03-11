Class {
	#name : #AlpIndex,
	#superclass : #Object,
	#category : #Aleph
}

{ #category : #updating }
AlpIndex >> beginRebuild [
]

{ #category : #updating }
AlpIndex >> endRebuild [
]

{ #category : #updating }
AlpIndex >> indexMethod: aMethod [

	self subclassResponsibility 
]

{ #category : #updating }
AlpIndex >> methodAdded: aMethod [

	self subclassResponsibility
]

{ #category : #updating }
AlpIndex >> methodModifiedFrom: oldMethod to: newMethod [ 

	self subclassResponsibility
]

{ #category : #updating }
AlpIndex >> methodRemoved: aMethod [

	self subclassResponsibility
]

{ #category : #'instance creation' }
AlpIndex >> referencesTo: aString [ 

	self subclassResponsibility
]
