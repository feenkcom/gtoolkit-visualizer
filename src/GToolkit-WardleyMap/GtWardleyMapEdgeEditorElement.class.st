Class {
	#name : #GtWardleyMapEdgeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapEdgeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'colorsPane',
		'predefinedColorsElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEdgeEditorElement >> initialize [
	super initialize.
	
	self 
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	colorsPane := BrVerticalPane new
		hFitContent
		vFitContentLimited.

	predefinedColorsElement := BrHorizontalGrid new
		hFitContent;
		vFitContentLimited;
		columnCount: 8.
	
	colorsPane addChildren: { predefinedColorsElement }.
	
	self addChild: (BrScrollPane new
		look: BrScrollPaneLook + BrGlamorousWithVerticalScrollbarLook;
		vFitContentLimited;
		hFitContent;
		content: colorsPane)
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgeEditorElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"
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
