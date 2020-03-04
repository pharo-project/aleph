Extension { #name : #ClyVariableReadersQuery }

{ #category : #'*Aleph' }
ClyVariableReadersQuery >> buildResult: aQueryResult [
	| vars navigation |

	vars := variableQuery execute items.
	navigation := scope asSystemNavigation.
	aQueryResult fillWith: (((vars 
		collect: [ :each | navigation allReferencesTo: each ]) flattened) 
		select: [ :each | vars anySatisfy: [ :eachVar | each readsRef: eachVar ] ])
]
