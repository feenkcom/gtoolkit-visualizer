Trait {
	#name : #TGtWithWardleyMapNodeModel,
	#instVars : [
		'wardleyMapNodeModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> hasWardleyMapNode [
	"Return a true if wardleyMapNode model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ wardleyMapNodeModel notNil
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> onWardleyMapNodeModelChanged [
	"Is sent when a new wardleyMapNode model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> subscribeToWardleyMapNodeModel [
	"Is sent after a new wardleyMapNode model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNodeModel if view model subscribes to them"
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> unsubscribeFromWardleyMapNodeModel [
	"Is sent before a new wardleyMapNode model is assigned to the view model.
	View models that subscribe to wardleyMapNode model are required to implement this methods"
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> wardleyMapNodeModel [
	"Return a not-null wardleyMapNode model assigned to the receiver view model"
	self
		assert: [ wardleyMapNodeModel notNil ]
		description: [ 'wardleyMapNode model should be initialized' ].

	^ wardleyMapNodeModel
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNodeModel >> wardleyMapNodeModel: aWardleyMapNodeModel [
	"Set a not-null wardleyMapNode domain model assigned to the receiver view model"
	self
		assert: [ aWardleyMapNodeModel notNil ]
		description: [ 'wardleyMapNode model must not be nil' ].

	wardleyMapNodeModel == aWardleyMapNodeModel 
		ifTrue: [ ^ self ].

	wardleyMapNodeModel ifNotNil: [ self unsubscribeFromWardleyMapNodeModel ].
	wardleyMapNodeModel := aWardleyMapNodeModel.

	self onWardleyMapNodeModelChanged.
	self subscribeToWardleyMapNodeModel
]
