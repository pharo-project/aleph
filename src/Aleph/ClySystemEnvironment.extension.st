Extension { #name : #ClySystemEnvironment }

{ #category : #'*Aleph' }
ClySystemEnvironment >> hasClassNamed: aString [

	^ self includesClassNamed: aString
]
