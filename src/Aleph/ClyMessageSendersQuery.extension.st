Extension { #name : #ClyMessageSendersQuery }

{ #category : #'*Aleph' }
ClyMessageSendersQuery >> buildResult: aQueryResult [
	| navigation |
	
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (selectors collect: [ :each | navigation allSendersOf: each ]) flattened
]
