Trait {
	#name : #TGtWithWardleyMapNoteModel,
	#instVars : [
		'wardleyMapNoteModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> hasWardleyMapNote [
	"Return a true if wardleyMapNote model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ wardleyMapNoteModel notNil
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> onWardleyMapNoteModelChanged [
	"Is sent when a new wardleyMapNote model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> subscribeToWardleyMapNoteModel [
	"Is sent after a new wardleyMapNote model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromWardleyMapNoteModel if view model subscribes to them"
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> unsubscribeFromWardleyMapNoteModel [
	"Is sent before a new wardleyMapNote model is assigned to the view model.
	View models that subscribe to wardleyMapNote model are required to implement this methods"
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> wardleyMapNoteModel [
	"Return a not-null wardleyMapNote model assigned to the receiver view model"
	self
		assert: [ wardleyMapNoteModel notNil ]
		description: [ 'wardleyMapNoteModel model should be initialized' ].

	^ wardleyMapNoteModel
]

{ #category : #'api - wardley map node model' }
TGtWithWardleyMapNoteModel >> wardleyMapNoteModel: aWardleyMapNoteModel [
	"Set a not-null wardleyMapNote domain model assigned to the receiver view model"
	self
		assert: [ aWardleyMapNoteModel notNil ]
		description: [ 'wardleyMapNote model must not be nil' ].

	wardleyMapNoteModel == aWardleyMapNoteModel 
		ifTrue: [ ^ self ].

	wardleyMapNoteModel ifNotNil: [ self unsubscribeFromWardleyMapNoteModel ].
	wardleyMapNoteModel := aWardleyMapNoteModel.

	self onWardleyMapNoteModelChanged.
	self subscribeToWardleyMapNoteModel
]
