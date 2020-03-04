Class {
	#name : #BaselineOfAleph,
	#superclass : #BaselineOf,
	#category : #BaselineOfAleph
}

{ #category : #baselines }
BaselineOfAleph >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		self taskit: spec.
		spec 
			package: #'Aleph';
			package: #'Aleph-Tests' ]	
]

{ #category : #'external projects' }
BaselineOfAleph >> taskit: spec [

	spec 
		baseline: 'TaskIt' 
		with: [ spec repository: 'github://sbragagnolo/taskit' ]
]
