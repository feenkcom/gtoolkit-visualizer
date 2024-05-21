Class {
	#name : #GtWardleyMapEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'canvas'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEditorElement >> canvas: aWardleyMapCanvasElement [
	canvas := aWardleyMapCanvasElement
]

{ #category : #accessing }
GtWardleyMapEditorElement >> contextMenuHandlerPositionOnEvent: anEvent [
	self
		allParentsDo: [ :aParent | 
			(aParent isKindOf: BrAnchoredElement)
				ifTrue: [ aParent
						childWithId: #handle
						ifFound: [ :aHandle | ^ aHandle bounds inSpace position ]
						ifNone: [ ^ anEvent position ] ] ].

	^ anEvent position
]

{ #category : #accessing }
GtWardleyMapEditorElement >> createBasicButtonElement [
	^ BrButton new
		beSmallSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		margin: (BlInsets
				top: 3
				left: 3
				bottom: 3
				right: 3)
]

{ #category : #accessing }
GtWardleyMapEditorElement >> createNodeButtonElement [
	^ self createBasicButtonElement
		label: 'Add node';
		action: [ :aButtonElement :aButtonModel :anEvent | self onAddNodeEvent: anEvent ]
]

{ #category : #accessing }
GtWardleyMapEditorElement >> createNoteButtonElement [
	^ self createBasicButtonElement
		label: 'Add note';
		action: [ :aButtonElement :aButtonModel :anEvent | self onAddNoteEvent: anEvent ]
]

{ #category : #accessing }
GtWardleyMapEditorElement >> createSwitchSectionsButtonElement [
	^ self createBasicButtonElement
		label: 'Switch sections';
		action: [ canvas parent hasEvolutionAxisLayer
				ifFalse: [ canvas parent
						evolutionSections: {'genesis'.
								'custom built'.
								'product (+rental)'.
								'commodity'} ]
				ifTrue: [ canvas parent removeChildAt: 1 ] ]
]

{ #category : #accessing }
GtWardleyMapEditorElement >> initialize [
	| aContainer |
	super initialize.

	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	aContainer := BrVerticalPane new hFitContent vFitContentLimited.

	aContainer addChildren: {
		self createNoteButtonElement.
		self createNodeButtonElement.
		self createSwitchSectionsButtonElement}.

	self
		addChild: (BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: aContainer)
]

{ #category : #accessing }
GtWardleyMapEditorElement >> normalizedItemPositionOnEvent: anEvent [
	| aGlobalPosition |
	aGlobalPosition := self contextMenuHandlerPositionOnEvent: anEvent.
	^ (canvas globalPointToLocal: aGlobalPosition) / canvas extent
]

{ #category : #'private - event handling' }
GtWardleyMapEditorElement >> onAddNodeEvent: anEvent [
	| aNormalizedPosition |
	anEvent consumed: true.
	(canvas width isZero or: [ canvas height isZero ]) ifTrue: [ ^ self ].
	aNormalizedPosition := self normalizedItemPositionOnEvent: anEvent.
	canvas wardleyMapViewModel addNewNodeAt: aNormalizedPosition.
	^ self fireEvent: BrContextMenuHideWish new
]

{ #category : #'private - event handling' }
GtWardleyMapEditorElement >> onAddNoteEvent: anEvent [
	| aNormalizedPosition |
	anEvent consumed: true.
	(canvas width isZero or: [ canvas height isZero ]) ifTrue: [ ^ self ].
	aNormalizedPosition := self normalizedItemPositionOnEvent: anEvent.
	canvas wardleyMapViewModel addNewNoteAt: aNormalizedPosition.
	self fireEvent: BrContextMenuHideWish new
]
