Trait {
	#name : #TGtWithWardleyMapModel,
	#instVars : [
		'wardleyMapModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - export / import' }
TGtWithWardleyMapModel >> gtJSONFor: aView [
	<gtView>
	
	^ aView forward
		title: 'JSON';
		priority: 8;
		object: [ self wardleyMapModel ];
		view: #gtJSONFor:
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> hasWardleyMap [
	"Return a true if wardleyMap model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ wardleyMapModel notNil
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> onWardleyMapModelChanged [
	"Is sent when a new wardleyMap model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> subscribeToWardleyMapModel [
	"Is sent after a new wardleyMap model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapModel if view model subscribes to them"
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> unsubscribeFromWardleyMapModel [
	"Is sent before a new wardleyMap model is assigned to the view model.
	View models that subscribe to wardleyMap model are required to implement this methods"
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> wardleyMapModel [
	"Return a not-null wardleyMap model assigned to the receiver view model"
	self
		assert: [ wardleyMapModel notNil ]
		description: [ 'wardleyMap model should be initialized' ].

	^ wardleyMapModel
]

{ #category : #'api - wardley map model' }
TGtWithWardleyMapModel >> wardleyMapModel: aWardleyMapModel [
	"Set a not-null wardleyMap domain model assigned to the receiver view model"
	self
		assert: [ aWardleyMapModel notNil ]
		description: [ 'wardleyMap model must not be nil' ].

	wardleyMapModel == aWardleyMapModel 
		ifTrue: [ ^ self ].

	wardleyMapModel ifNotNil: [ self unsubscribeFromWardleyMapModel ].
	wardleyMapModel := aWardleyMapModel.

	self onWardleyMapModelChanged.
	self subscribeToWardleyMapModel
]
