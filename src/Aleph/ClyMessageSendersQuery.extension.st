Extension { #name : #ClyMessageSendersQuery }

{ #category : #'*Aleph' }
ClyMessageSendersQuery >> buildResult: aQueryResult [
	| navigation |
	
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (selectors flatCollect: [ :each | navigation allSendersOf: each ]) 
]
