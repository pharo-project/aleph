Class {
	#name : #AlpImplementorsIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpImplementorsIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpImplementorsIndex >> indexMethod: aMethod [

	(self indexAt: aMethod selector) add: aMethod
]

{ #category : #'as yet unclassified' }
AlpImplementorsIndex >> methodRemoved: aMethod [
	| set |

	set := self indexAt: aMethod selector.
	set remove: aMethod.
	set ifEmpty: [ 
		table removeKey: aMethod selector ]
	
]
