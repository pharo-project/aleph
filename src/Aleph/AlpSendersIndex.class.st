Class {
	#name : #AlpSendersIndex,
	#superclass : #AlpIndex,
	#category : #Aleph
}

{ #category : #building }
AlpSendersIndex >> buildIndex [

	self navigation allMethodsDo: [ :each |
		self indexMethod: each ]
]

{ #category : #building }
AlpSendersIndex >> indexMethod: aMethod [
	| literalCollector |

	literalCollector := AlpLiteralCollector new.
	aMethod ast acceptVisitor: literalCollector.
	literalCollector literals 
		do: [ :each | (self indexAt: each) add: aMethod ]
]
