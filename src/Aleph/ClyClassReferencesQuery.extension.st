Extension { #name : #ClyClassReferencesQuery }

{ #category : #'*Aleph' }
ClyClassReferencesQuery >> buildResult: aQueryResult [
	| vars navigation |

	vars := variableQuery execute items.
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (vars flatCollect: [ :each | navigation allReferencesTo: each ]) 
]
