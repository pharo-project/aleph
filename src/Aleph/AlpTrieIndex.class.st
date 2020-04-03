"
I am an index that uses two CTOptimizedTrie as the storage of the index.
One trie is used to store the beginnings of the keys and the other the suffixes.
My subclasses provide fulltext search on top of the index. 
I am heavily used by the implementation of Spotter.

My creation goes in two stages:

1) During the building of the index, all the collection of the information is done using two Dictionaries to store the intermediate data. 

2) Aftr all the data is calculated, the Optimized Tries are built to enhance the access to the index.

Once the index is created the update is done directly on the tries.
"
Class {
	#name : #AlpTrieIndex,
	#superclass : #AlpIndex,
	#instVars : [
		'initialTable',
		'initialSubstringTable',
		'beginsWithTrie',
		'substringTrie'
	],
	#category : #Aleph
}

{ #category : #updating }
AlpTrieIndex >> atEntry: aKey add: aMethod [

	self isRebuild ifTrue: [ 
		(initialTable
			at: aKey asLowercase ifAbsentPut: [ OrderedCollection new: 100 ])
			add: aMethod. 

		self withSuffixesOf: aKey asLowercase do: [ :aSuffix | 
			(initialSubstringTable 
				at: aSuffix ifAbsentPut: [ OrderedCollection new: 100 ])
				add: aMethod].
			
		^ self ].
			
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

	initialTable := Dictionary new: self initialTableSize.
	initialSubstringTable := Dictionary new:self initialTableSize * 40.

	beginsWithTrie := nil.
	substringTrie := nil.
]

{ #category : #updating }
AlpTrieIndex >> clear [

	self initialize
]

{ #category : #updating }
AlpTrieIndex >> endRebuild [

	beginsWithTrie := CTOptimizedTrie new.
	substringTrie := CTOptimizedTrie new.
	
	initialTable associations 
		do: [ :assoc | | methods | 
			methods := assoc value asArray.
			self updateBeginsWith: assoc key asLowercase with: methods]
		displayingProgress: [ :assoc | 'Indexing Trie:', assoc key ].

	initialSubstringTable associations 
		do: [ :assoc | | methods | 
			methods := assoc value asArray.
			substringTrie at: assoc key asLowercase put: methods]
		displayingProgress: [ :assoc | 'Indexing Suffixes Trie:', assoc key ].

	initialTable := nil.
	initialSubstringTable := nil.
]

{ #category : #updating }
AlpTrieIndex >> initialTableSize [

	^ self subclassResponsibility
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

{ #category : #resetting }
AlpTrieIndex >> shutdown [
	beginsWithTrie := nil.
	initialTable := nil.
	substringTrie := nil.
	initialSubstringTable := nil.
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

{ #category : #querying }
AlpTrieIndex >> withAllValuesWithSubstring: aString do: aBlockClosure [ 

	beginsWithTrie 
		withAllValuesBeginningWith: aString asLowercase 
		do: [ :aCollectionOfMethods | aCollectionOfMethods do: aBlockClosure ].

	substringTrie 
		withAllValuesBeginningWith: aString asLowercase 
		do: [ :aCollectionOfMethods | aCollectionOfMethods do: aBlockClosure ]
]

{ #category : #updating }
AlpTrieIndex >> withSuffixesOf: aString do: aBlock [

	aString suffixesDo: aBlock minLength: 2.

]
