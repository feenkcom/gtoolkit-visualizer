Class {
	#name : #GtWardleyMapEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'canvas',
		'container',
		'titleVisibilityCheckbox'
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

{ #category : #initialization }
GtWardleyMapEditorElement >> createAddItemsLabel [
	^ GtWardleyMapUtility newContextMenuLabel text: 'Add item'
]

{ #category : #accessing }
GtWardleyMapEditorElement >> createBasicButtonElement [
	^ GtWardleyMapUtility newButtonElement
		margin: (BlInsets
				top: 0
				left: 5
				bottom: 3
				right: 0)
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createConfigureMapLabel [
	^ GtWardleyMapUtility newContextMenuLabel text: 'Map visibility'
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createNodeButtonElement [
	^ self createBasicButtonElement
		label: 'Add node';
		action: [ :aButtonElement :aButtonModel :anEvent | self onAddNodeEvent: anEvent ]
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createNoteButtonElement [
	^ self createBasicButtonElement
		label: 'Add note';
		action: [ :aButtonElement :aButtonModel :anEvent | self onAddNoteEvent: anEvent ]
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createPropertiesEditorContainer [
	container := BrVerticalPane new
			hFitContent;
			vFitContentLimited.

	container addChildren: self createPropertyEditorElements.

	^ container
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createPropertyEditorElements [
	^ {self createAddItemsLabel.
		self createNoteButtonElement.
		self createNodeButtonElement.
		self createConfigureMapLabel.
		titleVisibilityCheckbox := self createTitleVisibilityCheckbox.
		self createSwitchSectionsButtonElement}
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createSwitchSectionsButtonElement [
	^ self createBasicButtonElement
		label: 'Switch sections';
		action: [ canvas parent parent hasEvolutionAxisLayer
				ifFalse: [ canvas parent parent
						evolutionSections: {'genesis'.
								'custom built'.
								'product (+rental)'.
								'commodity'} ]
				ifTrue: [ canvas parent parent removeChildAt: 1 ] ]
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createTitleVisibilityCheckbox [
	^ GtWardleyMapUtility newContextMenuCheckbox
		enabledLabel: 'visible title';
		disabledLabel: 'cannot change title visibility';
		tooltipLabel: 'Toggle map title visibility';
		whenCheckedDo: [ :anEvent | self onTitleVisibilityChecked: anEvent ];
		whenUncheckedDo: [ :anEvent | self onTitleVisibilityUnchecked: anEvent ]
]

{ #category : #initialization }
GtWardleyMapEditorElement >> initialize [
	super initialize.
	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).
	self createPropertiesEditorContainer.
	self
		addChild: (BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: container)
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

{ #category : #'event handling' }
GtWardleyMapEditorElement >> onTitleVisibilityChanged [
	titleVisibilityCheckbox checked: self wardleyMapViewModel isTitleVisible
]

{ #category : #'event handling' }
GtWardleyMapEditorElement >> onTitleVisibilityChecked: anEvent [ 
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	
	self wardleyMapViewModel isTitleVisible: true
]

{ #category : #'event handling' }
GtWardleyMapEditorElement >> onTitleVisibilityUnchecked: anEvent [ 
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	
	self wardleyMapViewModel isTitleVisible: false
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	self onTitleVisibilityChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEditorElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapViewModelTitleVisibilityChanged send: #onTitleVisibilityChanged to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEditorElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
