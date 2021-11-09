Extension { #name : #SortedCollection }

{ #category : #'*Aleph' }
SortedCollection >> binarySearch: aString [ 
	
	| foundIndex |
	self ifEmpty: [ ^ nil ].
	
	foundIndex := self binarySearchMinimalIndexOf: aString.
	
	foundIndex > self size ifTrue: [ ^ nil ].
	
	(self at: foundIndex) = aString ifTrue: [ ^ foundIndex ] ifFalse: [ ^ nil ]
]

{ #category : #'*Aleph' }
SortedCollection >> binarySearchIncludes: aString [ 
	
	^ (self binarySearch: aString) isNotNil
]

{ #category : #'*Aleph' }
SortedCollection >> binarySearchMinimalIndexOf: aString [ 

	self ifEmpty: [ ^ nil ].
	^ self binarySearchMinimalIndexOf: aString from: 1 to: self size
]

{ #category : #'*Aleph' }
SortedCollection >> binarySearchMinimalIndexOf: aString from: start to: end [ 
	
	| mid found comparator result |
	
	start > end ifTrue: [ ^ start ].
	
	mid := (end - start / 2) floor + start.
	found := self at: mid.
	
	comparator := self sortBlock 
		ifNil: [ SortFunction default ]
		ifNotNil: [ :x | x asSortFunction ]. 
	
	result := comparator collate: found with: aString. 
	result == 0 ifTrue: [ ^ mid ]. 
	
	end == start ifTrue: [ 
		result < 0 ifTrue: [ ^ mid + 1 ].
		^ mid ].
	
	result < 0 
		ifTrue: [^ self binarySearchMinimalIndexOf: aString from: mid + 1 to: end]
		ifFalse: [^ self binarySearchMinimalIndexOf: aString from: start to: mid -1 ]
]
