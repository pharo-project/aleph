"
I represent the common interface of all the indexes in Aleph.
I am stored in an AlpIndexManager and I should be used through it.

There is two different behavior: 

 - During the build of the index, the manager will call #beginRebuild, and then classAdded: and methodAdded: for each class and method in the system. Then I will receive #endRebuild. 

 - During normal image modification I will be notified by the manager by #methodAdded:, #methodRemoved: and #methodModifiedFrom:to: and #classAdded: , #classRemoved: and #class:renamedFrom:to:

My subclasses should implement this methods.
Also I have an statistics Dictionary with some information passed by the manager so the indexes can improve the process of generation of the index. 
"
Class {
	#name : #AlpIndex,
	#superclass : #Object,
	#instVars : [
		'statistics'
	],
	#category : #'Aleph-Indexes'
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
AlpIndex >> clear [

	^ self subclassResponsibility 
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

{ #category : #resetting }
AlpIndex >> shutdown [
	self subclassResponsibility
]

{ #category : #accessing }
AlpIndex >> statistics [

	^ statistics
]

{ #category : #accessing }
AlpIndex >> statistics: aDictionary [

	statistics := aDictionary
]
