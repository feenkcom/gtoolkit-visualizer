"
I am the main element. Beside the canvas, I offer a tool bar and the sidebar where editors are displayed. 

```
	| space |
	space := BlSpace new.
	space root addChild: GtDiagrammerElement new.
	space show
```


"
Class {
	#name : #GtDiagrammerElement,
	#superclass : #BlElement,
	#instVars : [
		'tool',
		'canvas',
		'tools',
		'availableTools',
		'styles',
		'sidebar',
		'topbar',
		'canvasContainer'
	],
	#category : #'GToolkit-Diagrammer-UI'
}

{ #category : #'instance creation' }
GtDiagrammerElement class >> open [
	<script: 'self open'>
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: 'GT-Diagrammer'.
	aSpace extent: 1200@800.
	aSpace root addChild: GtDiagrammerElement new.
	aSpace show
]

{ #category : #initialization }
GtDiagrammerElement >> availableTools [
	^ availableTools ifNil: [ availableTools := {
		GtDiagrammerSelectionTool new.
		GtDiagrammerFigureTool new.
		GtDiagrammerLineTool new } ]
]

{ #category : #accessing }
GtDiagrammerElement >> canvas [
	^ canvas
]

{ #category : #editing }
GtDiagrammerElement >> closeEditor [
	sidebar
		childNamed: #editor
		ifFound: [ :anEditorList | anEditorList dataSource editors: #() ]
		ifNone: [ self error: 'Editor list must exist' ]
]

{ #category : #editing }
GtDiagrammerElement >> edit: anElement [
	| theEditors |
	
	theEditors := GtDiagrammerFigureEditor editorsOf: anElement.

	sidebar
		childNamed: #editor
		ifFound: [ :anEditorList | anEditorList dataSource editors: theEditors ]
		ifNone: [ self error: 'Editor list must exist' ]
]

{ #category : #initialization }
GtDiagrammerElement >> initialize [
	super initialize.

	tool := GtDiagrammerDummyTool new.

	self background: (Color gray alpha: 0.1).
	
	self layout: (BlGridLayout new cellSpacing: 20; columnCount: 2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self initializeCanvas.
	self initializeTopbar.
	self initializeSidebar.
	self initializeTools.
	self initializeExports.

	self addChildren: { topbar . sidebar . canvasContainer }.

	"select a tool by default"
	self tool: self availableTools anyOne
]

{ #category : #initialization }
GtDiagrammerElement >> initializeCanvas [
	canvasContainer := GtDiagrammerCard new.
	canvasContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvasContainer background: Color white.
	
	canvas := BlElement new.
	canvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	canvasContainer addChild: canvas
]

{ #category : #initialization }
GtDiagrammerElement >> initializeExports [
	| aContainer asSvg asPdf asPng asJpg asForm |
	
	asSvg := BrButton new
		aptitude: BrMaterialButtonLayoutAptitude + BrShadowAptitude + BrMaterialRoundedAptitude + (BrTextLabelAptitude new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'SVG';
		action: [ self canvas exportAsSVG ].

	asPdf := BrButton new
		aptitude: BrMaterialButtonLayoutAptitude + BrShadowAptitude + BrMaterialRoundedAptitude + (BrTextLabelAptitude new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'PDF';
		action: [ self canvas exportAsPDF ].
		
	asPng := BrButton new
		aptitude: BrMaterialButtonLayoutAptitude + BrShadowAptitude + BrMaterialRoundedAptitude  + (BrTextLabelAptitude new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'PNG';
		action: [ self canvas exportAsPNG ].

	asJpg := BrButton new
		aptitude: BrMaterialButtonLayoutAptitude + BrShadowAptitude + BrMaterialRoundedAptitude + (BrTextLabelAptitude new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'JPG';
		action: [ self canvas exportAsJPEG ].
		
	asForm := BrButton new
		aptitude: BrMaterialButtonLayoutAptitude + BrShadowAptitude + BrMaterialRoundedAptitude + (BrTextLabelAptitude new fontSize: 11);
		background: (Color fromHexString: 'fafafa');
		label: 'Form';
		action: [ self canvas exportAsForm inspect ].

	aContainer := BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 5);
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { asSvg . asPdf . asPng . asJpg . asForm }.
	
	topbar addChild: aContainer.
]

{ #category : #initialization }
GtDiagrammerElement >> initializeSidebar [
	sidebar := BlElement new.
	sidebar width: 300.
	sidebar layout: (BlLinearLayout vertical).
	sidebar clipChildren: false.
	sidebar constraintsDo: [ :c |
		c vertical matchParent.
		c frame horizontal alignRight.
		c grid vertical span: 2 ].
		
	sidebar
		addChild: (GtDiagrammerEditorList new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ])
		as: #editor
]

{ #category : #initialization }
GtDiagrammerElement >> initializeTools [
	| aToolsCard |

	aToolsCard := BlElement new.
	aToolsCard layout: (BlGridLayout new cellSpacing: 2; columnCount: 1).
	aToolsCard constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	tools := GtDiagrammerToolPicker new.
	tools layout: BlLinearLayout horizontal.
	tools aptitude: BrShadowAptitude new.
	tools margin: (BlInsets all: 5).
	tools display: [ self availableTools ].
	tools when: BrToggleActivatedEvent do: [ :anEvent | self tool: anEvent model ].

	styles := GtDiagrammerPicker new.
	styles layout: BlLinearLayout horizontal.
	styles padding: (BlInsets empty).
	styles shape: [ :aStyle |
		BrToggle new
			size: 20@20;
			background: Color random ].
	styles constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	styles when: BrToggleActivatedEvent do: [ :anEvent | self tool style: anEvent model ].

	aToolsCard addChild: tools.
	aToolsCard addChild: styles.

	topbar addChild: aToolsCard
]

{ #category : #initialization }
GtDiagrammerElement >> initializeTopbar [
	topbar := BlElement new.
	topbar layout: (BlLinearLayout horizontal).
	topbar clipChildren: false.
	topbar constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]
]

{ #category : #'api - selection' }
GtDiagrammerElement >> select: anElement [

	"selection is only possible when corresponding tool is activated"	
	self tool: GtDiagrammerSelectionTool new.
	self tool select: anElement
]

{ #category : #accessing }
GtDiagrammerElement >> tool [
	<return: #GtDiagrammerTool>

	^ tool
]

{ #category : #accessing }
GtDiagrammerElement >> tool: aGtDiagrammerTool [

	self tool = aGtDiagrammerTool
		ifTrue: [ ^ self ].

	self removeEventHandler: self tool.
	tool := aGtDiagrammerTool.
	self addEventHandler: self tool.

	tools select: self tool.
	self tool stylesIn: styles.
	styles selectFirst
]
