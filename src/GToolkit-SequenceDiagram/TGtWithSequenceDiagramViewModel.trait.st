Trait {
	#name : #TGtWithSequenceDiagramViewModel,
	#instVars : [
		'sequenceDiagramViewModel'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> hasSequenceDiagramViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #sequenceDiagramViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ sequenceDiagramViewModel notNil
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> onPostSequenceDiagramViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSequenceDiagramViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> onSequenceDiagramViewModelChanged [
	"Is sent when a new sequenceDiagramViewModel is assigned to the receiver.
	Note: #onSequenceDiagramViewModelChanged is sent before #subscribeToSequenceDiagramViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSequenceDiagramViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> sequenceDiagramDo: aBlock [
	self hasSequenceDiagramViewModel ifFalse: [ ^ self ].
	aBlock cull: self sequenceDiagramViewModel
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> sequenceDiagramDo: aBlock ifAbsent: absentBlock [
	self hasSequenceDiagramViewModel ifFalse: [ ^ absentBlock value ].
	aBlock cull: self sequenceDiagramViewModel
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> sequenceDiagramViewModel [
	"Return a not-null sequenceDiagramViewModel assigned to the receiver"
	<objectGetter: #sequenceDiagramViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ sequenceDiagramViewModel notNil ]
		description: [ 'sequenceDiagramViewModel should be initialized' ].

	^ sequenceDiagramViewModel
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> sequenceDiagramViewModel: aSequenceDiagramViewModel [
	"Set a not-null sequenceDiagramViewModel assigned to the receiver"
	<objectSetter: #sequenceDiagramViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSequenceDiagramViewModel notNil ]
		description: [ 'sequenceDiagramViewModel must not be nil' ].

	sequenceDiagramViewModel == aSequenceDiagramViewModel
		ifTrue: [ ^ self ].

	sequenceDiagramViewModel ifNotNil: [ self unsubscribeFromSequenceDiagramViewModel ].
	sequenceDiagramViewModel := aSequenceDiagramViewModel.

	self onSequenceDiagramViewModelChanged.
	self subscribeToSequenceDiagramViewModel.
	self onPostSequenceDiagramViewModelChanged
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> subscribeToSequenceDiagramViewModel [
	"Is sent after a new sequenceDiagramViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSequenceDiagramViewModel if the receiver subscribes to them"
	<objectSubscriber: #sequenceDiagramViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - sequence diagram view model' }
TGtWithSequenceDiagramViewModel >> unsubscribeFromSequenceDiagramViewModel [
	"Is sent before a new sequenceDiagramViewModel is assigned to the receiver.
	Objects that subscribe to sequenceDiagramViewModel are required to implement this method."
	<objectUnsubscriber: #sequenceDiagramViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
