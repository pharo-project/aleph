Extension { #name : #ClyPackageScope }

{ #category : #'*Aleph' }
ClyPackageScope >> allBehaviors [
	
	^ self basisObjects flatCollect: [ :each | each definedClasses ]
]
