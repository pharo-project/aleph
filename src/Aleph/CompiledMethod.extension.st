Extension { #name : #CompiledMethod }

{ #category : #'*Aleph' }
CompiledMethod >> specialLiterals [
	| results specialLiteralMap |

	specialLiteralMap := self encoderClass encodedSpecialLiteralMap.
	results := Set new.
	(InstructionStream on: self) scanFor: [ :instr | 
		specialLiteralMap 
			at: instr 
			ifPresent: [ :selector | results add: selector ].
		false ].
	^ results asArray
]
