Class {
	#name : #BaselineOfAleph,
	#superclass : #BaselineOf,
	#category : #BaselineOfAleph
}

{ #category : #baselines }
BaselineOfAleph >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec package: #'Aleph' ]	
]
