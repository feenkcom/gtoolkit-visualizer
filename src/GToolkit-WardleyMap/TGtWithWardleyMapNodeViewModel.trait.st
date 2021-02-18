Trait {
	#name : #TGtWithWardleyMapNodeViewModel,
	#instVars : [
		'wardleyMapNodeViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> hasWardleyMapNodeViewModel [
	"Return a true if WardleyMapNode view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ wardleyMapNodeViewModel notNil
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> wardleyMapNodeViewModel [
	"Return a not-null WardleyMapNode view model assigned to the receiver element"
	self
		assert: [ wardleyMapNodeViewModel notNil ]
		description: [ 'WardleyMapNode view model should be initialized' ].

	^ wardleyMapNodeViewModel
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNodeViewModel >> wardleyMapNodeViewModel: aWardleyMapNodeViewModel [
	"Set a not-null WardleyMapNode view model assigned to the receiver element"
	self
		assert: [ aWardleyMapNodeViewModel notNil ]
		description: [ 'WardleyMapNode view model must not be nil' ].

	wardleyMapNodeViewModel == aWardleyMapNodeViewModel 
		ifTrue: [ ^ self ].

	wardleyMapNodeViewModel ifNotNil: [ self unsubscribeFromWardleyMapNodeViewModel ].
	wardleyMapNodeViewModel := aWardleyMapNodeViewModel.

	self onWardleyMapNodeViewModelChanged.
	self subscribeToWardleyMapNodeViewModel
]
