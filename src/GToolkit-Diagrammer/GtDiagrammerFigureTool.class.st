"
I am responsible for instantiation of new figures from stencils


"
Class {
	#name : #GtDiagrammerFigureTool,
	#superclass : #GtDiagrammerTool,
	#instVars : [
		'creator',
		'styles',
		'hoverOver',
		'hoverOut',
		'overlay'
	],
	#category : #'GToolkit-Diagrammer-Tools'
}

{ #category : #initialization }
GtDiagrammerFigureTool >> initialize [
	super initialize.

	styles := GtDiagrammerElementStencil allSubclasses collect: #new.
	
	overlay := BlOverlayElement new.
	overlay border: (BlBorder paint: (Color blue alpha: 0.1) width: 5).
	overlay clipChildren: false.

	self style: styles anyOne
]

{ #category : #'api - diagrammer' }
GtDiagrammerFigureTool >> instantiate: aStencil at: aPoint in: aTarget [
	<return: #BlElement>
	| anElement |

	anElement := aStencil create.

	"we need to force layout process of the element in order to relocate it in such a way that its center is at aPoint"
	anElement forceLayout.
	
	(anElement extent) > (aTarget extent / 2.0)
		ifTrue: [
			anElement size: aTarget extent / 2.0.
			anElement forceLayout ].
	
	anElement relocate: aPoint - (anElement extent / 2.0) asIntegerPoint.
	anElement addEventHandler: BlPullHandler new.

	aTarget addChild: anElement.

	^ anElement
]

{ #category : #'api - hooks' }
GtDiagrammerFigureTool >> onInstalledIn: aDiagrammerElement [
	super onInstalledIn: aDiagrammerElement.
	
	creator := BlEventHandler on: BlClickEvent do: [ :anEvent |
		| aLocation aFigureElement aTargetElement |
		
		aTargetElement := anEvent target.
		
		"`anEvent currentTarget` is already a canvas"
		aLocation := aTargetElement globalPointToLocal: anEvent position.

		aFigureElement := self
			instantiate: self style
			at: aLocation
			in: aTargetElement.

		self onInstantiated: aFigureElement in: aDiagrammerElement ].
	
	hoverOver := BlEventHandler on: BlMouseOverEvent do: [ :anEvent |
		(anEvent target ~= self canvas)
			ifTrue: [
				overlay geometry: anEvent target geometry copy.
				overlay attachTo: anEvent target.
				overlay hasParent ifFalse: [ self canvas addChild: overlay ] ] ].

	hoverOut := BlEventHandler
		on: BlMouseOutEvent
		do: [ :anEvent |
			(anEvent target ~= self canvas)
				ifTrue: [
					overlay detach.
					overlay removeFromParent ] ].

	aDiagrammerElement canvas addEventHandler: creator.
	aDiagrammerElement canvas addEventHandler: hoverOver.
	aDiagrammerElement canvas addEventHandler: hoverOut
]

{ #category : #hooks }
GtDiagrammerFigureTool >> onInstantiated: aFigureElement in: aDiagrammerElement [
	"Is sent after an element was instantiated and added to the diagrammer"

	aDiagrammerElement select: aFigureElement.
	aDiagrammerElement edit: aFigureElement
]

{ #category : #'api - hooks' }
GtDiagrammerFigureTool >> onUninstalledIn: aDiagrammerElement [
	super onUninstalledIn: aDiagrammerElement.

	aDiagrammerElement canvas removeEventHandler: creator.
	aDiagrammerElement canvas removeEventHandler: hoverOver.
	aDiagrammerElement canvas removeEventHandler: hoverOut.
	
	overlay detach.
	overlay removeFromParent
]

{ #category : #'api - accessing' }
GtDiagrammerFigureTool >> styles [
	^ styles
]

{ #category : #styles }
GtDiagrammerFigureTool >> stylesIn: aPicker [
	aPicker
		display: [ self styles ];
		shape: [ :aStencil |
			BrToggle new
				aptitude: BrMaterialToggleIconifiedAptitude;
				icon: (BlScalableElement new
					size: 28@28;
					"stencil preview must not receive mouse events,
					otherwise text editors for example will consume them and
					make toggle button unclickable"
					contentElement: aStencil create preventMeAndChildrenMouseEvents);
				padding: (BlInsets all: 3);
				margin: (BlInsets all: 3) ]
]

{ #category : #accessing }
GtDiagrammerFigureTool >> symbol [
	^ 'Figure'
]
