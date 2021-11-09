"
I am a trait that encapsulates all event handling of a Implementors index.
In this way I can be used in different implementations. There are a Trie based and a Table based one.
"
Trait {
	#name : #TAlpImplementorsIndex,
	#category : #'Aleph-Indexes'
}

{ #category : #updating }
TAlpImplementorsIndex >> initialTableSize [

	^ self statistics at: #numberOfSymbols
]

{ #category : #'updating - methods' }
TAlpImplementorsIndex >> methodAdded: aMethod [

	self atEntry: aMethod selector add: aMethod.

]

{ #category : #'updating - methods' }
TAlpImplementorsIndex >> methodRemoved: aMethod [

	self atEntry: aMethod selector remove: aMethod
]
