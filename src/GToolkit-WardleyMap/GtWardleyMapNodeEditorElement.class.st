Class {
	#name : #GtWardleyMapNodeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement',
		'nodeSizeEditor'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> createNodeSizePicker [
	| aPicker |

	aPicker := BrHorizontalPane new
		fitContent;
		alignCenterLeft;
		cellSpacing: 5.

	aPicker addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: '-';
		action: [ self wardleyMapNodeViewModel decreaseNodeSize ]).
		
	aPicker addChild: (nodeSizeEditor := BrEditableLabel new
		look: (BrGlamorousEditableLabelLook new fontSize: 0.9 fontEm);
		fitContent;
		text: '1.0';
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| aNewNodeSize |
			aNewNodeSize := aWish text asString asNumber.
			self wardleyMapNodeViewModel nodeSize: aNewNodeSize asPoint ]).

	aPicker addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: '+';
		beSmallSize;
		action: [ self wardleyMapNodeViewModel increaseNodeSize ]).
	
	^ aPicker
]

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> initialize [
	| aContainer |
	super initialize.
	
	self 
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	aContainer := BrVerticalPane new
		hFitContent
		vFitContentLimited.

	predefinedColorsElement := GtWardleyMapColorPickerElement new
		hFitContent;
		vFitContentLimited;
		columnCount: 8;
		cellSpacing: 5.
	
	aContainer addChildren: {
		BrLabel new
			look: (BrGlamorousLabelLook new foreground: Color darkGray);
			margin: (BlInsets top: 5 left: 5 bottom: 2 right: 0);
			text: 'Node color:'.
		predefinedColorsElement.
		BrLabel new
			look: (BrGlamorousLabelLook new foreground: Color darkGray);
			margin: (BlInsets top: 10 left: 5 bottom: 2 right: 0);
			text: 'Node size:'.
		self createNodeSizePicker. 
		
		BrButton new
			beSmallSize;
			look: (BrGlamorousButtonWithLabelLook new);
			margin: (BlInsets top: 10 left: 5 bottom: 5 right: 0);
			label: 'Delete';
			action: [
				self wardleyMapNodeViewModel removeFromMap.
				self fireEvent: BrDropdownHideWish new ] }.
	
	self addChild: (BrScrollPane new
		look: BrScrollPaneLook + BrGlamorousWithVerticalScrollbarLook;
		vFitContentLimited;
		hFitContent;
		content: aContainer)
]

{ #category : #'event handling' }
GtWardleyMapNodeEditorElement >> onNodeSizeChanged [
	nodeSizeEditor text: (self wardleyMapNodeViewModel nodeSize min asString)
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	self onNodeSizeChanged
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
	
	self wardleyMapNodeViewModel weak when: GtWardleyMapNodeViewModelResized send: #onNodeSizeChanged to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
