Class {
	#name : #AlpTrieIndex,
	#superclass : #AlpIndex,
	#instVars : [
		'initialTable',
		'beginsWithTrie',
		'substringTrie'
	],
	#category : #Aleph
}

{ #category : #updating }
AlpTrieIndex >> atEntry: aKey add: aMethod [

	self isRebuild ifTrue: [ 
		^ initialTable
			at: aKey asLowercase
			update: [ :previous | previous copyWith: aMethod ]
			initial: [ {aMethod} ] ].
			
	self updateBeginsWith: aKey asLowercase with: {aMethod}.				
	self updateSubstrings: aKey asLowercase with: {aMethod}.
]

{ #category : #accessing }
AlpTrieIndex >> atEntry: aString remove: aMethod [ 
	
	beginsWithTrie 
		at: aString asLowercase 
		update: [ :previous | 
			| newValue |
			newValue := previous copyWithout: aMethod.
			newValue 
				ifNotEmpty: [ newValue ]
				ifEmpty: [ nil ] ]
		initial: [ nil ].
	
	self remove: {aMethod} fromSubstring: aString
]

{ #category : #updating }
AlpTrieIndex >> beginRebuild [

	initialTable := IdentityDictionary new.
	beginsWithTrie := nil.
	substringTrie := nil.
]

{ #category : #updating }
AlpTrieIndex >> endRebuild [

	beginsWithTrie := CTOptimizedTrie new.
	substringTrie := CTOptimizedTrie new.

	initialTable associationsDo: [ :assoc |
		self updateBeginsWith: assoc key asLowercase with: assoc value.
		self updateSubstrings: assoc key asLowercase with: assoc value].


	initialTable := nil.
]

{ #category : #initialization }
AlpTrieIndex >> initialize [

	super initialize.
	beginsWithTrie := CTOptimizedTrie new.
	substringTrie := CTOptimizedTrie new
]

{ #category : #testing }
AlpTrieIndex >> isRebuild [

	^ initialTable isNotNil
]

{ #category : #accessing }
AlpTrieIndex >> navigation [

	^ SystemNavigation new
]

{ #category : #querying }
AlpTrieIndex >> referencesBeginningWith: aString do: aBlock [

	^ beginsWithTrie withAllValuesBeginningWith: aString do: aBlock
]

{ #category : #querying }
AlpTrieIndex >> referencesContaining: aString do: aBlock [

	^ substringTrie withAllValuesBeginningWith: aString do: aBlock
]

{ #category : #querying }
AlpTrieIndex >> referencesTo: aString [ 
	
	^ beginsWithTrie at: aString asLowercase ifAbsent: [ ^#() ].
]

{ #category : #accessing }
AlpTrieIndex >> remove: aCollectionOfMethods fromSubstring: aKey [

	self
		withSuffixesOf: aKey
		do: [ :each | 
			substringTrie
				at: each asLowercase
				update: [ :previous | | newValue |
					(newValue := previous copyWithoutAll: aCollectionOfMethods) 
						ifEmpty: [ nil ] ifNotEmpty: [ newValue ] ]
				initial: [ nil ] ]
]

{ #category : #accessing }
AlpTrieIndex >> removeEntry: aString [
	
	beginsWithTrie 
		at: aString asLowercase 
		update: [ :previous | nil ]
		initial: [ nil ].
	
	self
		withSuffixesOf: aString
		do: [ :each | 
			substringTrie
				at: each asLowercase
				update: [ :previous | nil ]
				initial: [ nil ] ]
]

{ #category : #initialization }
AlpTrieIndex >> startSize [

	^ 1000000
]

{ #category : #updating }
AlpTrieIndex >> updateBeginsWith: aKey with: aCollectionOfMethods [

	beginsWithTrie
		at: aKey
		update: [ :previous | previous , aCollectionOfMethods ]
		initial: [ aCollectionOfMethods ]
]

{ #category : #updating }
AlpTrieIndex >> updateSubstrings: aKey with: aCollectionOfMethods [

	self
		withSuffixesOf: aKey
		do: [ :each | 
			substringTrie
				at: each asLowercase
				update: [ :previous | previous , aCollectionOfMethods ]
				initial: [ aCollectionOfMethods ] ]
]

{ #category : #querying }
AlpTrieIndex >> withAllValuesBeginningWith: aString do: aBlockClosure [ 

	^ beginsWithTrie 
		withAllValuesBeginningWith: aString asLowercase 
		do: [ :aCollectionOfMethods | aCollectionOfMethods do: aBlockClosure ]
]

{ #category : #updating }
AlpTrieIndex >> withSuffixesOf: aString do: aBlock [

	aString suffixes
		select: [ :each | each ~= aString and: [ each size > 2 ] ]
		thenDo: aBlock
]
