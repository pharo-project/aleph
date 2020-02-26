Extension { #name : #SystemNavigation }

{ #category : #'*Aleph' }
SystemNavigation >> allMethodsDo: aBlock [

	self allBehaviorsDo: [ :eachBehavior |
		eachBehavior methodDict valuesDo: aBlock ]
]

{ #category : #'*Aleph' }
SystemNavigation class >> default [

	AlpSystemNavigation isActive ifTrue: [ ^ AlpSystemNavigation basicNew initialize ].
	^ self basicNew initialize
]

{ #category : #'*Aleph' }
SystemNavigation class >> new [ 

	^ self default
]
