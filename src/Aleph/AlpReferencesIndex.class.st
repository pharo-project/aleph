Class {
	#name : #AlpReferencesIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpReferencesIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpReferencesIndex >> indexMethod: aMethod [
	| collector |

	collector := AlpGlobalCollector new.
	aMethod ast acceptVisitor: collector.
	collector globals
		do: [ :each | (self indexAt: each) add: aMethod ]	
]
