Class {
	#name : #GtWardleyMapEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'canvas',
		'container'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEditorElement >> canvas [
	<return: #GtWardleyMapCanvasElement>
	^ canvas
]

{ #category : #initialization }
GtWardleyMapEditorElement >> canvas: aWardleyMapCanvasElement [
	canvas := aWardleyMapCanvasElement
]

{ #category : #'private - updating' }
GtWardleyMapEditorElement >> contextMenuItems [
	^ self wardleyMapViewModel contextMenuItems
]

{ #category : #initialization }
GtWardleyMapEditorElement >> createPropertiesEditorContainer [
	container := BrVerticalPane new
			hFitContent;
			vFitContent.

	^ container
]

{ #category : #initialization }
GtWardleyMapEditorElement >> initialize [
	super initialize.
	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3);
		background: self theme default contentBackground.
	self createPropertiesEditorContainer.
	self
		addChild: (BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: container)
]

{ #category : #'event handling' }
GtWardleyMapEditorElement >> onContentChanged [
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	
	self updateElement.
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"

	self
		assert: [ self canvas isNotNil ]
		description: [ 'Define the canvas element first.' ].
	self onContentChanged
]

{ #category : #'private - updating' }
GtWardleyMapEditorElement >> updateElement [
	| aContext |
	aContext := GtWardleyMapEditorContext new editorElement: self.

	GtWardleyMapUtility
		updateMenuContainer: container
		menuItems: self contextMenuItems
		usingContext: aContext
]
