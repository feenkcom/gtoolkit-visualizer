Trait {
	#name : #TGtWithWardleyMapNodeLabelViewModel,
	#instVars : [
		'wardleyMapNodeLabelViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> hasWardleyMapNodeLabelViewModel [
	"Return a true if WardleyMapNodeLabel view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ wardleyMapNodeLabelViewModel notNil
]

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> onWardleyMapNodeLabelViewModelChanged [
	"Is sent when a new WardleyMapNodeLabel view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> subscribeToWardleyMapNodeLabelViewModel [
	"Is sent after a new WardleyMapNodeLabel view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeLabelViewModel if elements subscribe to them"
]

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> unsubscribeFromWardleyMapNodeLabelViewModel [
	"Is sent before a new WardleyMapNodeLabel view model is assigned to the element.
	Elements that subscribe to WardleyMapNodeLabel view model in domain model are required to implement this methods"
]

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> wardleyMapNodeLabelViewModel [
	"Return a not-null WardleyMapNodeLabel view model assigned to the receiver element"
	self
		assert: [ wardleyMapNodeLabelViewModel notNil ]
		description: [ 'WardleyMapNodeLabel view model should be initialized' ].

	^ wardleyMapNodeLabelViewModel
]

{ #category : #'api - wardley map node label view model' }
TGtWithWardleyMapNodeLabelViewModel >> wardleyMapNodeLabelViewModel: aWardleyMapNodeLabelViewModel [
	"Set a not-null WardleyMapNodeLabel view model assigned to the receiver element"
	self
		assert: [ aWardleyMapNodeLabelViewModel notNil ]
		description: [ 'WardleyMapNodeLabel view model must not be nil' ].

	wardleyMapNodeLabelViewModel == aWardleyMapNodeLabelViewModel 
		ifTrue: [ ^ self ].

	wardleyMapNodeLabelViewModel ifNotNil: [ self unsubscribeFromWardleyMapNodeLabelViewModel ].
	wardleyMapNodeLabelViewModel := aWardleyMapNodeLabelViewModel.

	self onWardleyMapNodeLabelViewModelChanged.
	self subscribeToWardleyMapNodeLabelViewModel
]
