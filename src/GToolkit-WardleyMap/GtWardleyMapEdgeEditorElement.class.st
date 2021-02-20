Class {
	#name : #GtWardleyMapEdgeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapEdgeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement',
		'lineWidthEditor'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEdgeEditorElement >> createLineWidthPicker [
	| aPicker |

	aPicker := BrHorizontalPane new
		fitContent;
		alignCenterLeft;
		cellSpacing: 5.

	aPicker addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: '-';
		action: [ self wardleyMapEdgeViewModel decreaseWidth ]).
		
	aPicker addChild: (lineWidthEditor := BrEditableLabel new
		look: (BrGlamorousEditableLabelLook new fontSize: 0.9 fontEm);
		fitContent;
		text: '1.0';
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| aNewLineWidth |
			aNewLineWidth := aWish text asString asNumber.
			self wardleyMapEdgeViewModel lineWidth: aNewLineWidth ]).

	aPicker addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
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

	predefinedColorsElement := BrHorizontalGrid new
		hFitContent;
		vFitContentLimited;
		columnCount: 8;
		margin: (BlInsets top: 0 left: 5 bottom: 0 right: 5).
	
	aContainer addChildren: {
		BrLabel new
			look: (BrGlamorousLabelLook new foreground: Color darkGray);
			margin: (BlInsets top: 5 left: 5 bottom: 2 right: 0);
			text: 'Line color:'.
		predefinedColorsElement.
		BrLabel new
			look: (BrGlamorousLabelLook new foreground: Color darkGray);
			margin: (BlInsets top: 10 left: 5 bottom: 2 right: 0);
			text: 'Line width:'.
		self createLineWidthPicker.
		
		BrButton new
			beSmallSize;
			look: (BrGlamorousButtonWithLabelLook new);
			margin: (BlInsets top: 10 left: 5 bottom: 5 right: 0);
			label: 'Delete';
			action: [
				self wardleyMapEdgeViewModel removeFromMap.
				self fireEvent: BrDropdownHideWish new ] }.
	
	self addChild: (BrScrollPane new
		look: BrScrollPaneLook + BrGlamorousWithVerticalScrollbarLook;
		vFitContentLimited;
		hFitContent;
		content: aContainer)
]

{ #category : #private }
GtWardleyMapEdgeEditorElement >> onLineWidthChanged [
	lineWidthEditor text: (self wardleyMapEdgeViewModel lineWidth printShowingDecimalPlaces: 2)
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"

	self onLineWidthChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEdgeEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	predefinedColorsElement removeChildren.
	predefinedColorsElement addChildren: (self wardleyMapViewModel predefinedColors collect: [ :eachColor |
		BlElement new
			size: 16@16;
			margin: (BlInsets all: 3);
			background: eachColor;
			border: (eachColor luminance >= Color lightGray luminance
				ifTrue: [ BlBorder paint: Color darkGray width: 1 ]
				ifFalse: [ BlBorder empty ]);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget fireEvent: BrDropdownHideWish new.

				self wardleyMapEdgeViewModel changeColorTo: eachColor.
				self wardleyMapViewModel defaultColor: eachColor ] ])
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
	
	self wardleyMapEdgeViewModel weak when: GtWardleyMapEdgeViewModelResized send: #onLineWidthChanged to: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]
