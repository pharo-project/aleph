Extension { #name : #ClyMessageImplementorsQuery }

{ #category : #'*Aleph' }
ClyMessageImplementorsQuery >> buildResult: aQueryResult [
	| navigation |
	
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (selectors flatCollect: [ :each | navigation allImplementorsOf: each ]) 
]
