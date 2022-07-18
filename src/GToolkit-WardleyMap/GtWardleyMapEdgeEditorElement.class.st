Class {
	#name : #GtWardleyMapEdgeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapEdgeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement',
		'lineWidthEditor',
		'arrowHeadCheckbox'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEdgeEditorElement >> createLineArrowPicker [
	| aPicker |
	aPicker := BrHorizontalPane new
			fitContent;
			alignCenterLeft;
			cellSpacing: 5.

	aPicker
		addChild: (arrowHeadCheckbox := BrCheckbox new
					uncheck;
					aptitude: BrGlamorousCheckboxAptitude;
					whenCheckedDo: [ self wardleyMapEdgeViewModel addLineArrow ];
					whenUncheckedDo: [ self wardleyMapEdgeViewModel removeLineArrow ]).

	aPicker addChild: (BrLabel new text: 'arrowhead').

	aPicker
		addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Reverse';
				action: [ self wardleyMapEdgeViewModel reverse ]).

	^ aPicker
]

{ #category : #initialization }
GtWardleyMapEdgeEditorElement >> createLineWidthPicker [
	| aPicker |

	aPicker := BrHorizontalPane new
		fitContent;
		alignCenterLeft;
		cellSpacing: 5.

	aPicker addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		beSmallSize;
		label: '-';
		action: [ self wardleyMapEdgeViewModel decreaseWidth ]).
		
	aPicker addChild: (lineWidthEditor := BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new fontSize: 0.9 fontEm);
		fitContent;
		text: '1.0';
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| aNewLineWidth |
			aNewLineWidth := aWish text asString asNumber.
			self wardleyMapEdgeViewModel lineWidth: aNewLineWidth ]).

	aPicker addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: '+';beSmallSize;
		action: [ self wardleyMapEdgeViewModel increaseWidth ]).
	
	^ aPicker
]

{ #category : #initialization }
GtWardleyMapEdgeEditorElement >> initialize [
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
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			margin: (BlInsets top: 5 left: 5 bottom: 2 right: 0);
			text: 'Line color:'.
		predefinedColorsElement.
		BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
			margin: (BlInsets top: 10 left: 5 bottom: 2 right: 0);
			text: 'Line width:'.
		self createLineWidthPicker.
		self createLineArrowPicker margin: (BlInsets top: 5).
		
		BrButton new
			beSmallSize;
			aptitude: (BrGlamorousButtonWithLabelAptitude new);
			margin: (BlInsets top: 10 left: 5 bottom: 5 right: 0);
			label: 'Delete';
			action: [
				self wardleyMapEdgeViewModel removeFromMap.
				self fireEvent: BrDropdownHideWish new ] }.
	
	self addChild: (BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		vFitContentLimited;
		hFitContent;
		content: aContainer)
]

{ #category : #private }
GtWardleyMapEdgeEditorElement >> onLineArrowChanged [
	arrowHeadCheckbox checked: self wardleyMapEdgeViewModel hasLineArrow
]

{ #category : #private }
GtWardleyMapEdgeEditorElement >> onLineWidthChanged [
	lineWidthEditor text: (self wardleyMapEdgeViewModel lineWidth printShowingDecimalPlaces: 2)
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"

	self onLineWidthChanged.
	self onLineArrowChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEdgeEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	predefinedColorsElement
		colors: self wardleyMapViewModel predefinedColors;
		whenColorPickedDo: [ :aColor |
			self wardleyMapEdgeViewModel changeColorTo: aColor.
			self wardleyMapViewModel defaultColor: aColor ]
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"

	self wardleyMapEdgeViewModel weak
		when: GtWardleyMapEdgeViewModelResized send: #onLineWidthChanged to: self;
		when: GtWardleyMapEdgeViewModelArrowChanged send: #onLineArrowChanged to: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]
