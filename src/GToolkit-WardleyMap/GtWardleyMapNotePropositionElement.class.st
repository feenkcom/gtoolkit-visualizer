Class {
	#name : #GtWardleyMapNotePropositionElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNoteViewModel + TGtWithWardleyMapDecoratorViewModel',
	#classTraits : 'TGtWithWardleyMapNoteViewModel classTrait + TGtWithWardleyMapDecoratorViewModel classTrait',
	#instVars : [
		'noteElement',
		'highlightColor'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'as yet unclassified' }
GtWardleyMapNotePropositionElement >> beAddProposition [
	self highlightColor:  BrGlamorousColors successBackgroundColor
]

{ #category : #'as yet unclassified' }
GtWardleyMapNotePropositionElement >> beChangeProposition [
	self highlightColor: BrGlamorousColors failureBackgroundColor
]

{ #category : #'as yet unclassified' }
GtWardleyMapNotePropositionElement >> beHighlight [
	self highlightColor: BrGlamorousColors failureBackgroundColor
]

{ #category : #'as yet unclassified' }
GtWardleyMapNotePropositionElement >> beRemoveProposition [
	self highlightColor: BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
GtWardleyMapNotePropositionElement >> highlightColor [
	^ highlightColor
]

{ #category : #accessing }
GtWardleyMapNotePropositionElement >> highlightColor: aColor [
	highlightColor := aColor.
	self background: highlightColor
]

{ #category : #'as yet unclassified' }
GtWardleyMapNotePropositionElement >> initialize [
	super initialize.
	self beAddProposition.
	self size: 0 @ 0.
	self zIndex: GtWardleyMapConstants nodePropositionElevationIndex.
	self wardley beDecorator
]

{ #category : #accessing }
GtWardleyMapNotePropositionElement >> noteElement [
	^ noteElement
]

{ #category : #accessing }
GtWardleyMapNotePropositionElement >> noteElement: anObject [
	noteElement := anObject.
	self updatePosition
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNotePropositionElement >> onDecoratorRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> onNoteLabelChanged: anEvent [
	self updatePosition
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> onNoteMoved: anEvent [
	self updatePosition
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> onNoteRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNotePropositionElement >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> onWardleyMapNoteViewModelChanged [
	"Is sent when a new WardleyMapNote view model is assigned to the element"
	
	
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNotePropositionElement >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"

	self wardleyMapDecoratorViewModel weak
		when: GtWardleyMapNoteDecoratorViewModelRemoved
		send: #onDecoratorRemoved:
		to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> subscribeToWardleyMapNoteViewModel [
	"Is sent after a new WardleyMapNote view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNoteViewModel if elements subscribe to them"

	self wardleyMapNoteViewModel weak
		when: GtWardleyMapNoteViewModelMoved
			send: #onNoteMoved:
			to: self;
		when: GtWardleyMapNoteViewModelLabelChanged
			send: #onNoteLabelChanged:
			to: self;
		when: GtWardleyMapNoteViewModelRemoved
			send: #onNoteRemoved:
			to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNotePropositionElement >> updatePosition [
	self
		enqueueTask: [ self
				constraintsDo: [ :c | 
					c frame horizontal alignCenterAt: self wardleyMapNoteViewModel coordinateX.
					c frame vertical alignCenterAt: self wardleyMapNoteViewModel coordinateY ].
			noteElement ifNotNil: [ self size: noteElement size ] ] asBlTask
]
