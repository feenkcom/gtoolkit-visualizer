Class {
	#name : #GtSequenceDiagramExamples,
	#superclass : #Object,
	#instVars : [
		'userActor',
		'securityLogon',
		'accountDb',
		'system'
	],
	#category : #'GToolkit-SequenceDiagram-Examples'
}

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> accountDbClassRole [
	<gtExample>
	<return: #GtSequenceDiagramClassRole>
	accountDb ifNotNil: [ :aParticipant | ^ aParticipant ].

	accountDb := self basicClassRole.
	accountDb classRole: 'AccountDB'.

	self assert: accountDb name equals: ':AccountDB'.

	^ accountDb
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> accountDbElement [
	<gtExample>
	<return: #GtSequenceDiagramClassRoleElement>
	| anElement aViewModel |
	anElement := self basicClassRoleElement.
	aViewModel := self accountDbViewModel.

	anElement participantViewModel: aViewModel.

	self assert: anElement hasParticipantViewModel.
	self assert: anElement participantViewModel equals: aViewModel.

	^ anElement
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> accountDbViewModel [
	<gtExample>
	<return: #GtSequenceDiagramParticipantViewModel>
	| aViewModel aParticipant allAnnouncements |
	aViewModel := self basicParticipantViewModel.
	aParticipant := self accountDbClassRole.

	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: GtSequenceDiagramParticipantChanged
		send: #add:
		to: allAnnouncements.

	aViewModel participant: aParticipant.
	self assert: aViewModel hasParticipant.
	self assert: aViewModel participant equals: aParticipant.
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne participant equals: aParticipant.

	^ aViewModel
]

{ #category : #'examples - actor' }
GtSequenceDiagramExamples >> actor [
	<gtExample>
	<return: #GtSequenceDiagramActor>
	userActor ifNotNil: [ :anActor | ^ anActor ].

	userActor := self basicActor.
	userActor name: 'User'.
	userActor
		model: {'firstname' -> 'Joe'.
				'familyname' -> 'Doe'.
				'username' -> 'Joe Doe'.
				'password' -> 'a secret password'.
				'city' -> 'Heaven'} asDictionary.

	self assert: userActor name equals: 'User'.

	^ userActor
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> actorElement [
	<gtExample>
	<return: #GtSequenceDiagramClassRoleElement>
	| anElement aViewModel |
	anElement := self basicClassRoleElement.
	aViewModel := self actorViewModel.

	anElement participantViewModel: aViewModel.

	self assert: anElement hasParticipantViewModel.
	self assert: anElement participantViewModel equals: aViewModel.

	^ anElement
]

{ #category : #'examples - actor' }
GtSequenceDiagramExamples >> actorViewModel [
	<gtExample>
	<return: #GtSequenceDiagramParticipantViewModel>
	| aViewModel aParticipant allAnnouncements |
	aViewModel := self basicParticipantViewModel.
	aParticipant := self actor.

	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: GtSequenceDiagramParticipantChanged
		send: #add:
		to: allAnnouncements.

	aViewModel participant: aParticipant.
	self assert: aViewModel hasParticipant.
	self assert: aViewModel participant equals: aParticipant.
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne participant equals: aParticipant.

	^ aViewModel
]

{ #category : #'examples - actor' }
GtSequenceDiagramExamples >> basicActor [
	<gtExample>
	<return: #GtSequenceDiagramActor>
	| aParticipant |
	aParticipant := GtSequenceDiagramActor new.

	self assert: aParticipant name equals: 'Actor'.

	^ aParticipant
]

{ #category : #'examples - builder' }
GtSequenceDiagramExamples >> basicBuilder [
	<gtExample>
	<return: #GtSequenceDiagramBuilder>
	| aBuilder |
	aBuilder := GtSequenceDiagram builder.

	^ aBuilder
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> basicClassRole [
	<gtExample>
	<return: #GtSequenceDiagramClassRole>
	| aParticipant |
	aParticipant := GtSequenceDiagramClassRole new.

	self assert: aParticipant classRole isNil.
	self assert: aParticipant name equals: ':Object'.

	^ aParticipant
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> basicClassRoleElement [
	<gtExample>
	<return: #GtSequenceDiagramClassRoleElement>
	| anElement |
	anElement := GtSequenceDiagramClassRoleElement new.

	self assert: anElement hasParticipantViewModel not.

	^ anElement
]

{ #category : #'examples - view model' }
GtSequenceDiagramExamples >> basicParticipantViewModel [
	<gtExample>
	<return: #GtSequenceDiagramParticipantViewModel>
	| aViewModel |
	aViewModel := GtSequenceDiagramParticipantViewModel new.

	self assert: aViewModel hasParticipant not.

	^ aViewModel
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> basicResponseMessage [
	<gtExample>
	<return: #GtSequenceDiagramResponseMessage>
	| aMessage |
	aMessage := GtSequenceDiagramResponseMessage new.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> basicSelfMessage [
	<gtExample>
	<return: #GtSequenceDiagramSelfMessage>
	| aMessage |
	aMessage := GtSequenceDiagramSelfMessage new.

	^ aMessage
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> basicSequenceDiagram [
	<gtExample>
	<return: #GtSequenceDiagram>
	| aDiagram |
	aDiagram := GtSequenceDiagram new.

	self assert: aDiagram participants size equals: 0.

	^ aDiagram
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> basicSequenceDiagramElement [
	<gtExample>
	<return: #GtSequenceDiagramElement>
	| anElement |
	anElement := GtSequenceDiagramElement new.

	self assert: anElement hasSequenceDiagramViewModel not.

	^ anElement
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> basicSequenceDiagramViewModel [
	<gtExample>
	<return: #GtSequenceDiagramViewModel>
	| aViewModel |
	aViewModel := GtSequenceDiagramViewModel new.

	self assert: aViewModel hasSequenceDiagram not.

	^ aViewModel
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> basicSynchronousMessage [
	<gtExample>
	<return: #GtSequenceDiagramSendMessage>
	| aMessage |
	aMessage := GtSequenceDiagramSendMessage new.

	^ aMessage
]

{ #category : #'examples - builder' }
GtSequenceDiagramExamples >> builderWithOneMessage [
	<gtExample>
	<return: #GtSequenceDiagramBuilder>
	| aBuilder aSender aReceiver |
	aBuilder := self basicBuilder.

	aBuilder participant classRole: 'AccountDB'.
	aSender := aBuilder participant classRole: 'AccountDB'.
	aReceiver := aBuilder participant classRole: 'System'.

	aBuilder message
		sender: aSender;
		receiver: aReceiver;
		name: 'isInDatabase(name)'.

	^ aBuilder
]

{ #category : #'examples - builder' }
GtSequenceDiagramExamples >> diagramWithOneMessage [
	<gtExample>
	<return: #GtSequenceDiagram>
	| aBuilder aDiagram |
	aBuilder := self builderWithOneMessage.
	aDiagram := aBuilder build.

	self assert: aDiagram participants size equals: 2.
	self assert: aDiagram participants first classRole equals: 'AccountDB'.
	self assert: aDiagram participants second classRole equals: 'System'.

	self assert: aDiagram messages size equals: 1.

	^ aDiagram
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> displayLogonScreenMessage [
	<gtExample>
	<return: #GtSequenceDiagramSelfMessage>
	| aMessage |
	aMessage := self basicSelfMessage.

	aMessage
		participant: self securityLogonClassRole;
		name: 'displayLogonScreen()'.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> isInDatabaseMessage [
	<gtExample>
	<return: #GtSequenceDiagramSendMessage>
	| aMessage aSystem anAccountDb |
	aMessage := self basicSynchronousMessage.

	anAccountDb := self accountDbClassRole.
	aSystem := self systemClassRole.

	aMessage
		sender: anAccountDb;
		receiver: aSystem;
		name: 'isInDatabase(name)';
		model: {'name' -> 'Joe Doe'} asDictionary.

	self assert: aMessage sender equals: anAccountDb.
	self assert: aMessage receiver equals: aSystem.
	self assert: aMessage name equals: 'isInDatabase(name)'.
	self assert: aMessage messages size equals: 0.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> isInDatabaseResponseMessage [
	<gtExample>
	<return: #GtSequenceDiagramResponseMessage>
	| aMessage aSystem anAccountDb |
	aMessage := self basicResponseMessage.

	anAccountDb := self accountDbClassRole.
	aSystem := self systemClassRole.

	aMessage
		sender: aSystem;
		receiver: anAccountDb;
		name: 'userType';
		model: {'userType' -> 'Client'} asDictionary.

	self assert: aMessage sender equals: aSystem.
	self assert: aMessage receiver equals: anAccountDb.
	self assert: aMessage name equals: 'userType'.
	self assert: aMessage messages size equals: 0.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> isValidMessage [
	<gtExample>
	<return: #GtSequenceDiagramSendMessage>
	| aMessage anInnerMessage aSecurityLogon anAccountDb aResponseMessage |
	aMessage := self basicSynchronousMessage.

	aSecurityLogon := self securityLogonClassRole.
	anAccountDb := self accountDbClassRole.
	anInnerMessage := self isInDatabaseMessage.
	aResponseMessage := self isInDatabaseResponseMessage.

	aMessage
		sender: aSecurityLogon;
		receiver: anAccountDb;
		name: 'isValid(name, password)';
		model: {'name' -> 'Joe Doe'.
				'password' -> 'a secret password'} asDictionary;
		message: anInnerMessage;
		message: aResponseMessage.

	self assert: aMessage receiver equals: anInnerMessage sender.
	self assert: aMessage sender equals: aSecurityLogon.
	self assert: aMessage receiver equals: anAccountDb.
	self assert: aMessage messages size equals: 2.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> isValidResponseMessage [
	<gtExample>
	<return: #GtSequenceDiagramResponseMessage>
	| aMessage aSecurityLogon anAccountDb |
	aMessage := self basicResponseMessage.

	aSecurityLogon := self securityLogonClassRole.
	anAccountDb := self accountDbClassRole.

	aMessage
		sender: anAccountDb;
		receiver: aSecurityLogon;
		name: 'valid';
		model: {'is_valid' -> true} asDictionary.

	self assert: aMessage sender equals: anAccountDb.
	self assert: aMessage receiver equals: aSecurityLogon.
	self assert: aMessage messages size equals: 0.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> nameAndPasswordMessage [
	<gtExample>
	<return: #GtSequenceDiagramSendMessage>
	| aMessage anInnerMessage aSecurityLogon anActor anInnerResponse |
	aMessage := self basicSynchronousMessage.

	anActor := self actor.
	aSecurityLogon := self securityLogonClassRole.
	anInnerMessage := self isValidMessage.
	anInnerResponse := self isValidResponseMessage.

	aMessage
		sender: anActor;
		receiver: aSecurityLogon;
		name: 'name and password';
		model: {'name' -> 'Joe Doe'.
				'password' -> 'a secret password'} asDictionary;
		message: anInnerMessage;
		message: anInnerResponse.

	self assert: aMessage receiver equals: anInnerMessage sender.
	self assert: aMessage sender equals: anActor.
	self assert: aMessage receiver equals: aSecurityLogon.

	^ aMessage
]

{ #category : #'examples - message' }
GtSequenceDiagramExamples >> requestLogonMessage [
	<gtExample>
	<return: #GtSequenceDiagramSendMessage>
	| aMessage anInnerMessage aSecurityLogon anActor |
	aMessage := self basicSynchronousMessage.

	anActor := self actor.
	aSecurityLogon := self securityLogonClassRole.
	anInnerMessage := self displayLogonScreenMessage.

	aMessage
		sender: anActor;
		receiver: aSecurityLogon;
		name: 'requestLogon()';
		message: anInnerMessage.

	self assert: aMessage receiver equals: anInnerMessage participant.
	self assert: aMessage sender equals: anActor.
	self assert: aMessage receiver equals: aSecurityLogon.

	^ aMessage
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> securityLogonClassRole [
	<gtExample>
	<return: #GtSequenceDiagramClassRole>
	securityLogon ifNotNil: [ :aParticipant | ^ aParticipant ].

	securityLogon := self basicClassRole.
	securityLogon classRole: 'SecurityLogon'.

	self assert: securityLogon name equals: ':SecurityLogon'.

	^ securityLogon
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> securityLogonElement [
	<gtExample>
	<return: #GtSequenceDiagramClassRoleElement>
	| anElement aViewModel |
	anElement := self basicClassRoleElement.
	aViewModel := self securityLogonViewModel.

	anElement participantViewModel: aViewModel.

	self assert: anElement hasParticipantViewModel.
	self assert: anElement participantViewModel equals: aViewModel.

	^ anElement
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> securityLogonViewModel [
	<gtExample>
	<return: #GtSequenceDiagramParticipantViewModel>
	| aViewModel aParticipant allAnnouncements |
	aViewModel := self basicParticipantViewModel.
	aParticipant := self securityLogonClassRole.

	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: GtSequenceDiagramParticipantChanged
		send: #add:
		to: allAnnouncements.

	aViewModel participant: aParticipant.
	self assert: aViewModel hasParticipant.
	self assert: aViewModel participant equals: aParticipant.
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne participant equals: aParticipant.

	^ aViewModel
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> sequenceDiagram [
	<gtExample>
	<return: #GtSequenceDiagram>
	| aDiagram anActor aLogon anAccountDB aLogonMessage nameAndPasswordMessage aSystem |
	aDiagram := self basicSequenceDiagram.
	anActor := self actor.
	aLogon := self securityLogonClassRole.
	anAccountDB := self accountDbClassRole.
	aSystem := self systemClassRole.
	aLogonMessage := self requestLogonMessage.
	nameAndPasswordMessage := self nameAndPasswordMessage.

	aDiagram participant: anActor.
	aDiagram participant: aLogon.
	aDiagram participant: anAccountDB.
	aDiagram participant: aSystem.
	aDiagram message: aLogonMessage.
	aDiagram message: nameAndPasswordMessage.

	self assert: aDiagram participants size equals: 4.
	self
		assert: aDiagram participants asArray
		equals: {anActor.
				aLogon.
				anAccountDB.
				aSystem}.

	self assert: aDiagram messages size equals: 2.
	self assert: aDiagram messages first equals: aLogonMessage.

	^ aDiagram
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> sequenceDiagramElement [
	<gtExample>
	<return: #BlPannableElement>
	| anElement aViewModel |
	anElement := self basicSequenceDiagramElement.
	aViewModel := self sequenceDiagramViewModel.

	anElement sequenceDiagramViewModel: aViewModel.

	self assert: anElement hasSequenceDiagramViewModel.
	self assert: anElement sequenceDiagramViewModel equals: aViewModel.

	^ anElement asPannableElement
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> sequenceDiagramViewModel [
	<gtExample>
	<return: #GtSequenceDiagramViewModel>
	| aViewModel aDiagram allAnnouncements |
	aViewModel := self basicSequenceDiagramViewModel.
	aDiagram := self sequenceDiagram.

	allAnnouncements := OrderedCollection new.
	aViewModel weak
		when: GtSequenceDiagramChangedAnnouncement
		send: #add:
		to: allAnnouncements.

	aViewModel sequenceDiagram: aDiagram.
	self assert: aViewModel hasSequenceDiagram.
	self assert: aViewModel sequenceDiagram equals: aDiagram.
	self assert: aViewModel participantViewModels size equals: 4.
	self assert: aViewModel messageViewModels size equals: 7.
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne sequenceDiagram equals: aDiagram.

	^ aViewModel
]

{ #category : #'examples - sequence diagram' }
GtSequenceDiagramExamples >> sequenceDiagram_messagesDepthFirstDo [
	<gtExample>
	<return: #GtSequenceDiagram>
	| aDiagram aMessage allMessages |
	aDiagram := self sequenceDiagram.

	self assert: aDiagram messages size equals: 2.
	aMessage := aDiagram messages anyOne.

	allMessages := OrderedCollection new.
	aDiagram messagesDepthFirstDo: [ :eachMessage | allMessages add: eachMessage ].

	self assert: allMessages size equals: 7.

	^ aDiagram
]

{ #category : #'examples - class role' }
GtSequenceDiagramExamples >> systemClassRole [
	<gtExample>
	<return: #GtSequenceDiagramClassRole>
	system ifNotNil: [ :aParticipant | ^ aParticipant ].

	system := self basicClassRole.
	system classRole: 'System'.

	self assert: system name equals: ':System'.

	^ system
]
