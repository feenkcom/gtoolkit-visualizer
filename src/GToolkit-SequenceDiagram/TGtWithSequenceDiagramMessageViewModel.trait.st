Trait {
	#name : #TGtWithSequenceDiagramMessageViewModel,
	#instVars : [
		'messageViewModel'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> hasMessageViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #messageViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ messageViewModel notNil
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> messageViewModel [
	"Return a not-null messageViewModel assigned to the receiver"
	<objectGetter: #messageViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ messageViewModel notNil ]
		description: [ 'messageViewModel should be initialized' ].

	^ messageViewModel
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> messageViewModel: aMessageViewModel [
	"Set a not-null messageViewModel assigned to the receiver"
	<objectSetter: #messageViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aMessageViewModel notNil ]
		description: [ 'messageViewModel must not be nil' ].

	messageViewModel == aMessageViewModel
		ifTrue: [ ^ self ].

	messageViewModel ifNotNil: [ self unsubscribeFromMessageViewModel ].
	messageViewModel := aMessageViewModel.

	self onMessageViewModelChanged.
	self subscribeToMessageViewModel.
	self onPostMessageViewModelChanged
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> onMessageViewModelChanged [
	"Is sent when a new messageViewModel is assigned to the receiver.
	Note: #onMessageViewModelChanged is sent before #subscribeToMessageViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostMessageViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> onPostMessageViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToMessageViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> subscribeToMessageViewModel [
	"Is sent after a new messageViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromMessageViewModel if the receiver subscribes to them"
	<objectSubscriber: #messageViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - message view model' }
TGtWithSequenceDiagramMessageViewModel >> unsubscribeFromMessageViewModel [
	"Is sent before a new messageViewModel is assigned to the receiver.
	Objects that subscribe to messageViewModel are required to implement this method."
	<objectUnsubscriber: #messageViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
