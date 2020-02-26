Extension { #name : #ClyMessageImplementorsQuery }

{ #category : #'*Aleph' }
ClyMessageImplementorsQuery >> buildResult: aQueryResult [
	| navigation |
	
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (selectors collect: [ :each | navigation allImplementorsOf: each ]) flattened
]
