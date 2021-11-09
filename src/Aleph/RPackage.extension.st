Extension { #name : #RPackage }

{ #category : #'*Aleph' }
RPackage >> prefixes [
	
	| prefixes prefixesBag possiblePrefixes possiblePrefixesBag biggestSize |
	prefixesBag := Bag new.

	possiblePrefixesBag := Bag new.
	possiblePrefixes := Set new.

	self definedClasses collect: [ :aClass |
		biggestSize := aClass name splitCamelCase first size.
		
		biggestSize to: 2 by: -1 do: [ :length |
			(aClass name size >= length)
				ifTrue: [ possiblePrefixesBag add: (aClass name first: length) ] ]	].
	
	possiblePrefixesBag keysAndValuesDo: [:k :v | v > 1 ifTrue: [ possiblePrefixes add: k ]].

	possiblePrefixes := possiblePrefixes sorted: #size descending.

	self definedClasses collect: [ :aClass |
		possiblePrefixes detect: [ :e | aClass name beginsWith: e ] ifFound: [ :e | prefixesBag add: e ]].
	
	prefixes := (prefixesBag valuesAndCounts associations select: [ :e | e value > 1 ]) asDictionary keys.
	
	^ prefixes copy select: [ :each | 
			prefixes noneSatisfy: [ :other | other ~= each and: [ each beginsWith: other ] ] ]
]
