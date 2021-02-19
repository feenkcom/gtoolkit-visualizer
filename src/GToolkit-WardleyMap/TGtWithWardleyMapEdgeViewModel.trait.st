Trait {
	#name : #TGtWithWardleyMapEdgeViewModel,
	#instVars : [
		'wardleyMapEdgeViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> hasWardleyMapEdge [
	"Return a true if wardleyMapEdge view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ wardleyMapEdgeViewModel notNil
]

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
]

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
]

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> wardleyMapEdgeViewModel [
	"Return a not-null wardleyMapEdge view model assigned to the receiver element"
	self
		assert: [ wardleyMapEdgeViewModel notNil ]
		description: [ 'wardleyMapEdge view model should be initialized' ].

	^ wardleyMapEdgeViewModel
]

{ #category : #'api - wardley map edge view model' }
TGtWithWardleyMapEdgeViewModel >> wardleyMapEdgeViewModel: aWardleyMapEdgeViewModel [
	"Set a not-null wardleyMapEdge view model assigned to the receiver element"
	self
		assert: [ aWardleyMapEdgeViewModel notNil ]
		description: [ 'wardleyMapEdge view model must not be nil' ].

	wardleyMapEdgeViewModel == aWardleyMapEdgeViewModel 
		ifTrue: [ ^ self ].

	wardleyMapEdgeViewModel ifNotNil: [ self unsubscribeFromWardleyMapEdgeViewModel ].
	wardleyMapEdgeViewModel := aWardleyMapEdgeViewModel.

	self onWardleyMapEdgeViewModelChanged.
	self subscribeToWardleyMapEdgeViewModel
]
