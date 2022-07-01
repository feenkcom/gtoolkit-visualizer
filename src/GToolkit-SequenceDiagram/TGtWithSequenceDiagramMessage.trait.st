Trait {
	#name : #TGtWithSequenceDiagramMessage,
	#instVars : [
		'message'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> hasMessage [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #message>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ message notNil
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> message [
	"Return a not-null message assigned to the receiver"
	<objectGetter: #message>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ message notNil ]
		description: [ 'message should be initialized' ].

	^ message
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> message: aMessage [
	"Set a not-null message assigned to the receiver"
	<objectSetter: #message>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aMessage notNil ]
		description: [ 'message must not be nil' ].

	message == aMessage
		ifTrue: [ ^ self ].

	message ifNotNil: [ self unsubscribeFromMessage ].
	message := aMessage.

	self onMessageChanged.
	self subscribeToMessage.
	self onPostMessageChanged
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> onMessageChanged [
	"Is sent when a new message is assigned to the receiver.
	Note: #onMessageChanged is sent before #subscribeToMessage
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostMessageChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> onPostMessageChanged [
	"I am an optional hook method that is sent after #subscribeToMessage.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> subscribeToMessage [
	"Is sent after a new message is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromMessage if the receiver subscribes to them"
	<objectSubscriber: #message>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - message' }
TGtWithSequenceDiagramMessage >> unsubscribeFromMessage [
	"Is sent before a new message is assigned to the receiver.
	Objects that subscribe to message are required to implement this method."
	<objectUnsubscriber: #message>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
