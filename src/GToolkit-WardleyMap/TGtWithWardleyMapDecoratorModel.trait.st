Trait {
	#name : #TGtWithWardleyMapDecoratorModel,
	#instVars : [
		'wardleyMapDecoratorModel'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorModel >> onWardleyMapDecoratorModelChanged [
	"Is sent when a new wardleyMapDecorator model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorModel >> subscribeToWardleyMapDecoratorModel [
	"Is sent after a new wardleyMapDecorator model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapDecoratorModel if view model subscribes to them"
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorModel >> unsubscribeFromWardleyMapDecoratorModel [
	"Is sent before a new wardleyMapDecorator model is assigned to the view model.
	View models that subscribe to wardleyMapDecorator model are required to implement this methods"
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorModel >> wardleyMapDecoratorModel [
	<return: #TGtWardleyMapDecoratorModel>
	^ wardleyMapDecoratorModel
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorModel >> wardleyMapDecoratorModel: aWardleyMapDecoratorModel [
	"Set a not-null wardleyMapDecorator domain model assigned to the receiver model"
	self
		assert: [ aWardleyMapDecoratorModel notNil ]
		description: [ 'wardleyMapDecorator model must not be nil' ].

	wardleyMapDecoratorModel == aWardleyMapDecoratorModel 
		ifTrue: [ ^ self ].

	wardleyMapDecoratorModel ifNotNil: [ self unsubscribeFromWardleyMapDecoratorModel ].
	wardleyMapDecoratorModel := aWardleyMapDecoratorModel.
	
	self onWardleyMapDecoratorModelChanged.
	self subscribeToWardleyMapDecoratorModel.
]
