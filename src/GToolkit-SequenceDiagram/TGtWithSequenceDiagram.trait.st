Trait {
	#name : #TGtWithSequenceDiagram,
	#instVars : [
		'sequenceDiagram'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> hasSequenceDiagram [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #sequenceDiagram>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ sequenceDiagram notNil
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> onPostSequenceDiagramChanged [
	"I am an optional hook method that is sent after #subscribeToSequenceDiagram.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> onSequenceDiagramChanged [
	"Is sent when a new sequenceDiagram is assigned to the receiver.
	Note: #onSequenceDiagramChanged is sent before #subscribeToSequenceDiagram
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSequenceDiagramChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> sequenceDiagram [
	"Return a not-null sequenceDiagram assigned to the receiver"
	<objectGetter: #sequenceDiagram>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ sequenceDiagram notNil ]
		description: [ 'sequenceDiagram should be initialized' ].

	^ sequenceDiagram
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> sequenceDiagram: aSequenceDiagram [
	"Set a not-null sequenceDiagram assigned to the receiver"
	<objectSetter: #sequenceDiagram>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSequenceDiagram notNil ]
		description: [ 'sequenceDiagram must not be nil' ].

	sequenceDiagram == aSequenceDiagram
		ifTrue: [ ^ self ].

	sequenceDiagram ifNotNil: [ self unsubscribeFromSequenceDiagram ].
	sequenceDiagram := aSequenceDiagram.

	self onSequenceDiagramChanged.
	self subscribeToSequenceDiagram.
	self onPostSequenceDiagramChanged
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> subscribeToSequenceDiagram [
	"Is sent after a new sequenceDiagram is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSequenceDiagram if the receiver subscribes to them"
	<objectSubscriber: #sequenceDiagram>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - sequence diagram' }
TGtWithSequenceDiagram >> unsubscribeFromSequenceDiagram [
	"Is sent before a new sequenceDiagram is assigned to the receiver.
	Objects that subscribe to sequenceDiagram are required to implement this method."
	<objectUnsubscriber: #sequenceDiagram>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
