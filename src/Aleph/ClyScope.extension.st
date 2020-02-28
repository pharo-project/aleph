Extension { #name : #ClyScope }

{ #category : #'*Aleph' }
ClyScope >> allBehaviors [
	
	^ self subclassResponsibility
]

{ #category : #'*Aleph' }
ClyScope >> asSystemNavigation [
	
	^ SystemNavigation default 
		environment: self;
		yourself
]

{ #category : #'*Aleph' }
ClyScope >> hasClassNamed: aString [ 

	^ self allBehaviors anySatisfy: [ :each | each name = aString ]
]
