Trait {
	#name : #TGtWithWardleyMapNoteViewModel,
	#instVars : [
		'wardleyMapNoteViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> hasWardleyMapNoteViewModel [
	"Return a true if WardleyMapNote view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ wardleyMapNoteViewModel notNil
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> onWardleyMapNoteViewModelChanged [
	"Is sent when a new WardleyMapNote view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> subscribeToWardleyMapNoteViewModel [
	"Is sent after a new WardleyMapNote view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNoteViewModel if elements subscribe to them"
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> unsubscribeFromWardleyMapNoteViewModel [
	"Is sent before a new WardleyMapNote view model is assigned to the element.
	Elements that subscribe to WardleyMapNote view model in domain model are required to implement this methods"
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> wardleyMapNoteViewModel [
	"Return a not-null WardleyMapNote view model assigned to the receiver element"
	self
		assert: [ wardleyMapNoteViewModel notNil ]
		description: [ 'WardleyMapNote view model should be initialized' ].

	^ wardleyMapNoteViewModel
]

{ #category : #'api - wardley map node view model' }
TGtWithWardleyMapNoteViewModel >> wardleyMapNoteViewModel: aWardleyMapNoteViewModel [
	"Set a not-null WardleyMapNote view model assigned to the receiver element"
	self
		assert: [ aWardleyMapNoteViewModel notNil ]
		description: [ 'WardleyMapNote view model must not be nil' ].

	wardleyMapNoteViewModel == aWardleyMapNoteViewModel 
		ifTrue: [ ^ self ].

	wardleyMapNoteViewModel ifNotNil: [ self unsubscribeFromWardleyMapNoteViewModel ].
	wardleyMapNoteViewModel := aWardleyMapNoteViewModel.

	self onWardleyMapNoteViewModelChanged.
	self subscribeToWardleyMapNoteViewModel
]
