Extension { #name : #SequenceableCollection }

{ #category : #'*Aleph' }
SequenceableCollection >> takeFirst: anInteger [
	^ self first: (self size min: anInteger)
]
