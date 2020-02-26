Extension { #name : #ClyCompositeScope }

{ #category : #'*Aleph' }
ClyCompositeScope >> allBehaviors [

	^ self subscopes flatCollect: [ :each | each allBehaviors ]
]
