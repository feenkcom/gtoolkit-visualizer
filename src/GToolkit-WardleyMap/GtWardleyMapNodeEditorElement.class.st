Class {
	#name : #GtWardleyMapNodeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement',
		'nodeSizeEditor',
		'pipelineVisibilityElement',
		'evolveTargetElement',
		'addEvolveElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createAddEvolveElement [
	^ GtWardleyMapUtility newButtonElement
		label: 'Add evolve node';
		action: [ 
			self wardleyMapNodeViewModel addEvolve.
			self fireEvent: BrDropdownHideWish new ]
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createBasicLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin: (BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0)
]

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
	^ GtWardleyMapUtility newColorLabelElement text: 'Node color:'
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeDeleteButton [
	^ GtWardleyMapUtility newDeleteButtonElement
		label: 'Delete node';
		action: [ 
			self wardleyMapNodeViewModel removeFromMap.
			self fireEvent: BrDropdownHideWish new ]
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeEvolveLabel [
	^ self createBasicLabel text: 'Evolve:'
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeEvolveTargetCheckbox [
	^ GtWardleyMapEvolveTargetCheckbox new
		checked: false;
		whenCheckedDo: [ :anEvent | ];
		whenUncheckedDo: [ :anEvent | ];
		margin:
			(BlInsets
				top: 5
				left: 5
				bottom: 2
				right: 0)
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
	^ {self createNodeColorLabel.
		predefinedColorsElement := self createColorPicker.
		self createNodeSizeLabel.
		self createNodeSizePicker.
		self createNodePipelineVisibilityLabel.
		pipelineVisibilityElement := self createNodePipelineVisibilityCheckbox.
		self createNodeEvolveLabel.
		evolveTargetElement := self createNodeEvolveTargetCheckbox.
		addEvolveElement := self createAddEvolveElement}
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
GtWardleyMapNodeEditorElement >> onEvolveTargetChecked: anEvent [
	| aCoordinateY |
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	aCoordinateY := self wardleyMapNodeViewModel coordinateY.
	self wardleyMapNodeViewModel convertToEvolveNode.
	(aCoordinateY closeTo: self wardleyMapNodeViewModel coordinateY)
		ifFalse: [ self fireEvent: BrContextMenuHideWish new ]
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onEvolveTargetUnchecked: anEvent [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel convertToRegularNode.
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeSizeChanged [
	nodeSizeEditor text: (self wardleyMapNodeViewModel nodeSize min asString)
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeTypeChanged [
	| anEvolveOption |
	anEvolveOption := GtWardleyMapNodeEvolveOption new
			nodeViewModel: self wardleyMapNodeViewModel.

	evolveTargetElement checked: anEvolveOption isEvolveTargetType.
	evolveTargetElement enabled: anEvolveOption canManipulateEvolveType.
	anEvolveOption canManipulateEvolveType
		ifTrue: [ evolveTargetElement
				whenCheckedDo: [ :anEvent | self onEvolveTargetChecked: anEvent ];
				whenUncheckedDo: [ :anEvent | self onEvolveTargetUnchecked: anEvent ] ].

	addEvolveElement enabled: anEvolveOption canAddEvolveNode
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onPipelineVisibilityChanged [
	pipelineVisibilityElement
		checked: self wardleyMapNodeViewModel isPipelineVisible.
		
	self wardleyMapNodeViewModel pipelineNodeViewModel 
		ifNil: [ pipelineVisibilityElement enabled: true ]
		ifNotNil: [ pipelineVisibilityElement enabled: false ].
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onNodeSizeChanged.
	self onPipelineVisibilityChanged.
	self onNodeTypeChanged.
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
			send: #onPipelineVisibilityChanged
			to: self;
		when: GtWardleyMapNodeViewModelTypeChanged
			send: #onNodeTypeChanged
			to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
