Trait {
	#name : #TGtWithSequenceDiagramParticipant,
	#instVars : [
		'participant'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #converting }
TGtWithSequenceDiagramParticipant >> asHeadElement [
	<return: #BlElement>
	^ self explicitRequirement
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> hasParticipant [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #participant>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ participant notNil
]

{ #category : #accessing }
TGtWithSequenceDiagramParticipant >> name [
	self hasParticipant ifFalse: [ ^ '?' ].
	^ self participant name
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> onParticipantChanged [
	"Is sent when a new participant is assigned to the receiver.
	Note: #onParticipantChanged is sent before #subscribeToParticipant
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostParticipantChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> onPostParticipantChanged [
	"I am an optional hook method that is sent after #subscribeToParticipant.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> participant [
	"Return a not-null participant assigned to the receiver"
	<objectGetter: #participant>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ participant notNil ]
		description: [ 'participant should be initialized' ].

	^ participant
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> participant: aParticipant [
	"Set a not-null participant assigned to the receiver"
	<objectSetter: #participant>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aParticipant notNil ]
		description: [ 'participant must not be nil' ].

	participant == aParticipant
		ifTrue: [ ^ self ].

	participant ifNotNil: [ self unsubscribeFromParticipant ].
	participant := aParticipant.

	self onParticipantChanged.
	self subscribeToParticipant.
	self onPostParticipantChanged
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> subscribeToParticipant [
	"Is sent after a new participant is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromParticipant if the receiver subscribes to them"
	<objectSubscriber: #participant>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - participant' }
TGtWithSequenceDiagramParticipant >> unsubscribeFromParticipant [
	"Is sent before a new participant is assigned to the receiver.
	Objects that subscribe to participant are required to implement this method."
	<objectUnsubscriber: #participant>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
