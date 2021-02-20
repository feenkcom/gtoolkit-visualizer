Trait {
	#name : #TGtWithWardleyMapEdgeModel,
	#instVars : [
		'wardleyMapEdgeModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> hasWardleyMapEdge [
	"Return a true if wardleyMapEdge model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ wardleyMapEdgeModel notNil
]

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> onWardleyMapEdgeModelChanged [
	"Is sent when a new wardleyMapEdge model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> subscribeToWardleyMapEdgeModel [
	"Is sent after a new wardleyMapEdge model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapEdgeModel if view model subscribes to them"
]

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> unsubscribeFromWardleyMapEdgeModel [
	"Is sent before a new wardleyMapEdge model is assigned to the view model.
	View models that subscribe to wardleyMapEdge model are required to implement this methods"
]

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> wardleyMapEdgeModel [
	"Return a not-null wardleyMapEdge model assigned to the receiver view model"
	self
		assert: [ wardleyMapEdgeModel notNil ]
		description: [ 'wardleyMapEdge model should be initialized' ].

	^ wardleyMapEdgeModel
]

{ #category : #'api - wardley map edge model' }
TGtWithWardleyMapEdgeModel >> wardleyMapEdgeModel: aWardleyMapEdgeModel [
	"Set a not-null wardleyMapEdge domain model assigned to the receiver view model"
	self
		assert: [ aWardleyMapEdgeModel notNil ]
		description: [ 'wardleyMapEdge model must not be nil' ].

	wardleyMapEdgeModel == aWardleyMapEdgeModel 
		ifTrue: [ ^ self ].

	wardleyMapEdgeModel ifNotNil: [ self unsubscribeFromWardleyMapEdgeModel ].
	wardleyMapEdgeModel := aWardleyMapEdgeModel.

	self onWardleyMapEdgeModelChanged.
	self subscribeToWardleyMapEdgeModel
]
