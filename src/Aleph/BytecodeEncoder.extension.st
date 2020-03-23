Extension { #name : #BytecodeEncoder }

{ #category : #'*Aleph' }
BytecodeEncoder class >> encodedSpecialLiteralMap [

	^ AlpEncodedSpecialLiteralMapProvider mapFor: self
]
