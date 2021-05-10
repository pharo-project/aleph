Extension { #name : #ClyVariableReadersQuery }

{ #category : #'*Aleph' }
ClyVariableReadersQuery >> buildResult: aQueryResult [
	| vars navigation |

	vars := variableQuery execute items.
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: ((vars 
		flatCollect: [ :each | navigation allReferencesTo: each ]) 
		select: [ :each | self doesMethod: each useAnyOf: vars ])
]
