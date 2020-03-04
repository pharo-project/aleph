"
I am an index manager, charged with the task of concentrate all system indexes and accessors to it. 
The find* methods provide access to the contained indexes.
The manager subscribes to SystemAnnouncer to listen system changes (method addition, modification and removals), in order to keep the indexes up-to date.

We use a special task it runner in low priority to update the indexes in background, when the system is idle.

The method rebuildAll will discard all previously existing indexes and re-build all from scratch. 
"
Class {
	#name : #AlpIndexManager,
	#superclass : #Object,
	#instVars : [
		'indexes',
		'navigation',
		'runner',
		'active'
	],
	#classVars : [
		'Current'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpIndexManager class >> activate [

	self current active: true
]

{ #category : #'instance creation' }
AlpIndexManager class >> current [

	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
AlpIndexManager class >> deactivate [

	self current active: false
]

{ #category : #accessing }
AlpIndexManager class >> indexPriority [

	^ Processor systemBackgroundPriority
]

{ #category : #accessing }
AlpIndexManager class >> indexWorkerName [

	^ 'Aleph Index Worker'
]

{ #category : #testing }
AlpIndexManager class >> isActive [

	^ self current isActive
]

{ #category : #'instance creation' }
AlpIndexManager class >> reset [
	<script>

	Current ifNil: [ ^ self ].
	Current unsubscribeFromSystemAnnouncer.
	Current := nil
]

{ #category : #accessing }
AlpIndexManager >> active: aBoolean [

	active := aBoolean
]

{ #category : #updating }
AlpIndexManager >> classRemoved: ann [ 

	ann classRemoved methodsDo: [ :each |
		self doMethodRemoved: each ]
]

{ #category : #private }
AlpIndexManager >> doMethodAdded: aMethod [

	self withTaskDo: [ :each | each methodAdded: aMethod ]
]

{ #category : #private }
AlpIndexManager >> doMethodModifiedFrom: oldMethod to: newMethod [

	self withTaskDo: [ :each | 
		each methodModifiedFrom: oldMethod to: newMethod ]
]

{ #category : #private }
AlpIndexManager >> doMethodRemoved: aMethod [

	self withTaskDo: [ :each | each methodRemoved: aMethod ]
]

{ #category : #query }
AlpIndexManager >> findImplementorsOf: aLiteral [

	^ (self indexAt: AlpImplementorsIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findReferencesTo: aLiteral [

	^ (self indexAt: AlpReferencesIndex) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findSendersOf: aLiteral [

	^ (self indexAt: AlpSendersIndex) referencesTo: aLiteral
]

{ #category : #private }
AlpIndexManager >> indexAt: aClass [

	^ indexes detect: [ :each | each class = aClass ]
]

{ #category : #initialization }
AlpIndexManager >> initialize [

	super initialize.
	self active: false.
	runner := TKTWorker new
		name: self class indexWorkerName;
		priority: self class indexPriority;
		start.
	self subscribeToSystemAnnouncer
]

{ #category : #testing }
AlpIndexManager >> isActive [

	^ active
]

{ #category : #updating }
AlpIndexManager >> methodAdded: ann [ 

	self doMethodAdded: ann methodAdded
]

{ #category : #updating }
AlpIndexManager >> methodModified: ann [ 

	self doMethodModifiedFrom: ann oldMethod to: ann newMethod
]

{ #category : #updating }
AlpIndexManager >> methodRemoved: ann [ 

	'Remove' crTrace.
	ann methodRemoved crTrace
]

{ #category : #accessing }
AlpIndexManager >> navigation [

	^ navigation ifNil: [ SystemNavigation default ]
]

{ #category : #accessing }
AlpIndexManager >> navigation: aNavigation [

	navigation := aNavigation
]

{ #category : #initialization }
AlpIndexManager >> newDefaultIndexes [

	^ { 
	AlpImplementorsIndex new.
	AlpReferencesIndex new.
	AlpSendersIndex new.
	 }
]

{ #category : #building }
AlpIndexManager >> rebuildAll [
	| oldActive |

	oldActive := self isActive.
	self unsubscribeFromSystemAnnouncer.
	[
		indexes := self newDefaultIndexes.
		self navigation allMethodsDo: [ :eachMethod |
			indexes do: [ :eachIndex | eachIndex indexMethod: eachMethod ] ] ]
	ensure: [ 
		self subscribeToSystemAnnouncer.
		self active: oldActive ]
]

{ #category : #initialization }
AlpIndexManager >> subscribeToSystemAnnouncer [

	self unsubscribeFromSystemAnnouncer.
	SystemAnnouncer uniqueInstance weak
		when: ClassRemoved send: #classRemoved: to: self;
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: MethodModified send: #methodModified: to: self
	
]

{ #category : #initialization }
AlpIndexManager >> unsubscribeFromSystemAnnouncer [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #private }
AlpIndexManager >> withTaskDo: aBlock [

	runner schedule: [ indexes do: aBlock ]
]
