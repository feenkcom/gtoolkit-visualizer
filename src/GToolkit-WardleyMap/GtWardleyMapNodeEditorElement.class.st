Class {
	#name : #GtWardleyMapNodeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement',
		'nodeSizeEditor',
		'pipelineVisibilityElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createColorPicker [
	^ GtWardleyMapColorPickerElement new
		hFitContent;
		vFitContentLimited;
		columnCount: 8;
		cellSpacing: 5
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeColorLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin:
			(BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0);
		text: 'Node color:'
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeDeleteButton [
	^ BrButton new
		beSmallSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		margin:
			(BlInsets
				top: 10
				left: 5
				bottom: 5
				right: 0);
		label: 'Delete';
		action: [ self wardleyMapNodeViewModel removeFromMap.
			self fireEvent: BrDropdownHideWish new ]
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodePipelineVisibilityCheckbox [
	^ GtWardleyMapPipelineVisibilityCheckbox new
		checked: false;
		whenCheckedDo: [ :anEvent |  ];
		whenUncheckedDo: [ :anEvent |  ];
		margin:
			(BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0)
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodePipelineVisibilityLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin:
			(BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0);
		text: 'Pipeline:'
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeSizeLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin:
			(BlInsets
				top: 10
				left: 5
				bottom: 2
				right: 0);
		text: 'Node size:'
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeSizePicker [
	| aPicker |

	aPicker := BrHorizontalPane new
		fitContent;
		alignCenterLeft;
		cellSpacing: 5.

	aPicker addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		beSmallSize;
		label: '-';
		action: [ self wardleyMapNodeViewModel decreaseNodeSize ]).
		
	aPicker addChild: (nodeSizeEditor := BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new fontSize: 0.9 fontEm);
		fitContent;
		text: '1.0';
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| aNewNodeSize |
			aNewNodeSize := aWish text asString asNumber.
			self wardleyMapNodeViewModel nodeSize: aNewNodeSize asPoint ]).

	aPicker addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: '+';
		beSmallSize;
		action: [ self wardleyMapNodeViewModel increaseNodeSize ]).
	
	^ aPicker
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createPropertiesEditorContainer [
	| aContainer |

	aContainer := BrVerticalPane new hFitContent vFitContentLimited.
	aContainer addChildren: self createPropertyEditorElements.
	aContainer addChild: self createNodeDeleteButton.

	^ aContainer
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createPropertyEditorElements [
	^ {
		self createNodeColorLabel.
		(predefinedColorsElement := self createColorPicker).
		self createNodeSizeLabel.
		self createNodeSizePicker.
		self createNodePipelineVisibilityLabel.
		pipelineVisibilityElement := self createNodePipelineVisibilityCheckbox.
	}
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> initialize [
	| aContainer |
	super initialize.

	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	aContainer := self createPropertiesEditorContainer.
	
	pipelineVisibilityElement
		whenCheckedDo: [ :anEvent | self wardleyMapNodeViewModel isPipelineVisible: true ];
		whenUncheckedDo: [ :anEvent | self wardleyMapNodeViewModel isPipelineVisible: false ].

	self
		addChild:
			(BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: aContainer)
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeSizeChanged [
	nodeSizeEditor text: (self wardleyMapNodeViewModel nodeSize min asString)
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onPipelineVisibilityChanged [
	pipelineVisibilityElement
		checked: self wardleyMapNodeViewModel isPipelineVisible
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onNodeSizeChanged.
	self onPipelineVisibilityChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	predefinedColorsElement
		colors: self wardleyMapViewModel predefinedColors;
		whenColorPickedDo: [ :aColor |
			self wardleyMapNodeViewModel changeColorTo: aColor.
			self wardleyMapViewModel defaultColor: aColor ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"

	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelResized
			send: #onNodeSizeChanged
			to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged
			send: #onPipelineVisibilityChanged to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
