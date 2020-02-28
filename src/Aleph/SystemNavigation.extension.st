Extension { #name : #SystemNavigation }

{ #category : #'*Aleph' }
SystemNavigation >> allMethodsDo: aBlock [

	self allBehaviorsDo: [ :eachBehavior |
		eachBehavior methodDict valuesDo: aBlock ]
]

{ #category : #'*Aleph' }
SystemNavigation class >> default [

	^ self new
]

{ #category : #'*Aleph' }
SystemNavigation class >> new [

	AlpManager isActive ifTrue: [ 
		^ AlpSystemNavigation basicNew initialize ].
	^ self basicNew initialize
]
