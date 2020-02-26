Extension { #name : #BytecodeEncoder }

{ #category : #'*Aleph' }
BytecodeEncoder class >> encodedSpecialLiteralMap [

	^ AlpEncodedSpecialLiteralMap mapFor: self
]
