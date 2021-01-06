Extension { #name : #CompiledCode }

{ #category : #'*Aleph' }
CompiledCode >> literalsEvenTheOnesInTheInnerBlocks [
	"Imported from 129625bdce8e3f751985d605d43fc4b16ed43847
	https://github.com/pharo-project/pharo/pull/8206"
	| literals numberLiterals |
	literals := OrderedCollection new:
		            (numberLiterals := self numLiterals
		                               - self literalsToSkip).
	1 to: numberLiterals do: [ :index | 
		| lit |
		lit := self literalAt: index.
		lit isEmbeddedBlock
			ifTrue: [ literals addAll: lit literalsEvenTheOnesInTheInnerBlocks ]
			ifFalse: [ literals addLast: lit ] ].
	^ literals asArray
]
