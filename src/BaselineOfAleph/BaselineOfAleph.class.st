Class {
	#name : #BaselineOfAleph,
	#superclass : #BaselineOf,
	#category : #BaselineOfAleph
}

{ #category : #baselines }
BaselineOfAleph >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec
			baseline: 'ContainersTrie'
			with: [ spec repository: 'github://pharo-containers/Containers-Trie/src' ].

		spec 
			package: #'Aleph';
			package: #'Aleph-Tests' ]
]
