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
		'active',
		'worker'
	],
	#classVars : [
		'Current'
	],
	#category : #Aleph
}

{ #category : #accessing }
AlpIndexManager class >> activate [
	<script>

	self current active: true.

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

	^ Processor userSchedulingPriority
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
	Current shutDown.
	Current := nil
]

{ #category : #accessing }
AlpIndexManager >> active: aBoolean [

	active := aBoolean
]

{ #category : #updating }
AlpIndexManager >> classAdded: ann [ 

	self withTaskDo: [ :each | each classAdded: ann classAdded ]
]

{ #category : #updating }
AlpIndexManager >> classRemoved: ann [ 

	ann classRemoved methodsDo: [ :each |
		self doMethodRemoved: each ].
	
	self withTaskDo: [ :each | each classRemoved: ann classRemoved ]
]

{ #category : #updating }
AlpIndexManager >> classRenamed: ann [ 

	self withTaskDo: [ :each | each class: ann classRenamed renamedFrom: ann oldName to: ann newName  ]
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

{ #category : #building }
AlpIndexManager >> doRebuildIndexes [

	indexes values 
		do: [ :eachIndex | 
			eachIndex beginRebuild.
			self navigation allBehaviors 
				do: [ :eachBehavior | 
					eachIndex classAdded: eachBehavior.
					eachBehavior methodsDo: [ :eachMethod | 
						eachIndex methodAdded: eachMethod ].
				] displayingProgress: [:eachBehavior| 'Indexing ' , eachBehavior name].
			eachIndex endRebuild] 
		displayingProgress: [ :eachIndex | eachIndex class name].

]

{ #category : #private }
AlpIndexManager >> ensureWorkerRunning [

	worker isRunning ifTrue: [ ^ self ].
	worker start
]

{ #category : #query }
AlpIndexManager >> findImplementorsOf: aLiteral [

	^ (self indexAt: #implementors) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findReferencesTo: aLiteral [

	^ (self indexAt: #references) referencesTo: aLiteral
]

{ #category : #query }
AlpIndexManager >> findSendersOf: aLiteral [

	^ (self indexAt: #senders) referencesTo: aLiteral
]

{ #category : #private }
AlpIndexManager >> indexAt: aType [

	^ indexes at: aType
]

{ #category : #initialization }
AlpIndexManager >> initialize [

	super initialize.
	self active: false.
	worker := TKTWorker new
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

	self 
		doMethodModifiedFrom: ann oldMethod 
		to: ann newMethod
]

{ #category : #updating }
AlpIndexManager >> methodRemoved: ann [ 

	self doMethodRemoved: ann methodRemoved
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

	^ { #implementors -> AlpImplementorsIndex new.
		 #references -> AlpReferencesIndex new.
		 #classes -> AlpClassesIndex new.
		 #senders -> AlpSendersIndex new. } asDictionary 
]

{ #category : #building }
AlpIndexManager >> rebuildAll [
	| oldActive |

	oldActive := self isActive.
	self unsubscribeFromSystemAnnouncer.
	active := false.

	[ indexes := self newDefaultIndexes.
		self doRebuildIndexes ]
	ensure: [ 
		self subscribeToSystemAnnouncer.
		self active: oldActive ]
]

{ #category : #'system startup' }
AlpIndexManager >> shutDown [
 
	self unsubscribeFromSystemAnnouncer.
	worker stop
]

{ #category : #initialization }
AlpIndexManager >> subscribeToSystemAnnouncer [

	self unsubscribeFromSystemAnnouncer.

	SystemAnnouncer uniqueInstance weak
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassAdded send: #classAdded: to: self;
		when: ClassRenamed send: #classRenamed: to: self;

		when: MethodAdded send: #methodAdded: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: MethodModified send: #methodModified: to: self.
	
]

{ #category : #initialization }
AlpIndexManager >> unsubscribeFromSystemAnnouncer [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #private }
AlpIndexManager >> withTaskDo: aBlock [

	self ensureWorkerRunning.
	worker schedule: [ indexes values do: aBlock ]
]
