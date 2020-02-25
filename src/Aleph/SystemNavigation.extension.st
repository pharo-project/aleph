Extension { #name : #SystemNavigation }

{ #category : #'*Aleph' }
SystemNavigation >> allMethodsDo: aBlock [

	self allBehaviorsDo: [ :eachBehavior |
		eachBehavior methodDict valuesDo: aBlock ]
]
