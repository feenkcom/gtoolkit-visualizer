Trait {
	#name : #TGtWithWardleyMapDecoratorViewModel,
	#instVars : [
		'wardleyMapDecoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorViewModel >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorViewModel >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorViewModel >> unsubscribeFromWardleyMapDecoratorViewModel [
	"Is sent before a new wardleyMapDecorator view model is assigned to the element.
	Elements that subscribe to wardleyMapDecorator view model are required to implement this methods"
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorViewModel >> wardleyMapDecoratorViewModel [
	<return: #TGtWardleyMapDecoratorViewModel>
	^ wardleyMapDecoratorViewModel
]

{ #category : #'api - wardley map decorator model' }
TGtWithWardleyMapDecoratorViewModel >> wardleyMapDecoratorViewModel: aWardleyMapDecoratorViewModel [
	"Set a not-null wardleyMapDecorator view model assigned to the receiver model"
	self
		assert: [ aWardleyMapDecoratorViewModel notNil ]
		description: [ 'wardleyMapDecorator view model must not be nil' ].

	wardleyMapDecoratorViewModel == aWardleyMapDecoratorViewModel 
		ifTrue: [ ^ self ].

	wardleyMapDecoratorViewModel ifNotNil: [ self unsubscribeFromWardleyMapDecoratorViewModel ].
	wardleyMapDecoratorViewModel := aWardleyMapDecoratorViewModel.
	
	self onWardleyMapDecoratorViewModelChanged.
	self subscribeToWardleyMapDecoratorViewModel.
]
