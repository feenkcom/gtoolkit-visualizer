Class {
	#name : #GtWardleyMapNodeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'container'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'private - updating' }
GtWardleyMapNodeEditorElement >> contextMenuItems [
	^ self wardleyMapNodeViewModel contextMenuItems
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createPropertiesEditorContainer [
	| aContainer |
	aContainer := BrVerticalPane new
			hFitContent;
			vFitContentLimited.

	^ aContainer
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> initialize [
	super initialize.

	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	container := self createPropertiesEditorContainer.
	
	self
		addChild:
			(BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: container)
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onContentChanged [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	
	self updateElement.
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onEvolveVisibilityChanged [
	
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onEvolveVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEvolveVisibilityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeSizeChanged [
	
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeSizeChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeSizeChanged ]
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onPipelineVisibilityChanged [
	
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onPipelineVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onPipelineVisibilityChanged ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onContentChanged.
	self onNodeSizeChanged.
	self onPipelineVisibilityChanged.
	self onEvolveVisibilityChanged.
]

{ #category : #'api - wardley map view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"

	
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"

	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelResized
			send: #onNodeSizeChanged:
			to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged
			send: #onPipelineVisibilityChanged:
			to: self;
		when: GtWardleyMapNodeViewModelEvolveVisibilityChanged
			send: #onEvolveVisibilityChanged:
			to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtWardleyMapNodeEditorElement >> updateElement [
	| aContext |
	aContext := GtWardleyMapNodeEditorContext new editorElement: self.

	GtWardleyMapUtility
		updateMenuContainer: container
		menuItems: self contextMenuItems
		usingContext: aContext
]
