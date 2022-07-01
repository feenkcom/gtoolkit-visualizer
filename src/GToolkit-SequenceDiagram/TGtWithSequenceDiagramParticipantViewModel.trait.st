Trait {
	#name : #TGtWithSequenceDiagramParticipantViewModel,
	#instVars : [
		'participantViewModel'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> hasParticipantViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #participantViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ participantViewModel notNil
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> onParticipantViewModelChanged [
	"Is sent when a new participantViewModel is assigned to the receiver.
	Note: #onParticipantViewModelChanged is sent before #subscribeToParticipantViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostParticipantViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> onPostParticipantViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToParticipantViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> participantViewModel [
	"Return a not-null participantViewModel assigned to the receiver"
	<objectGetter: #participantViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ participantViewModel notNil ]
		description: [ 'participantViewModel should be initialized' ].

	^ participantViewModel
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> participantViewModel: aParticipantViewModel [
	"Set a not-null participantViewModel assigned to the receiver"
	<objectSetter: #participantViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aParticipantViewModel notNil ]
		description: [ 'participantViewModel must not be nil' ].

	participantViewModel == aParticipantViewModel
		ifTrue: [ ^ self ].

	participantViewModel ifNotNil: [ self unsubscribeFromParticipantViewModel ].
	participantViewModel := aParticipantViewModel.

	self onParticipantViewModelChanged.
	self subscribeToParticipantViewModel.
	self onPostParticipantViewModelChanged
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> subscribeToParticipantViewModel [
	"Is sent after a new participantViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromParticipantViewModel if the receiver subscribes to them"
	<objectSubscriber: #participantViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - participant view model' }
TGtWithSequenceDiagramParticipantViewModel >> unsubscribeFromParticipantViewModel [
	"Is sent before a new participantViewModel is assigned to the receiver.
	Objects that subscribe to participantViewModel are required to implement this method."
	<objectUnsubscriber: #participantViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
