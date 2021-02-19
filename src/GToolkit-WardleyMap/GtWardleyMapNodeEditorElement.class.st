Class {
	#name : #GtWardleyMapNodeEditorElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'colorsPane',
		'predefinedColorsElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeEditorElement >> initialize [
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

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"

	
]

{ #category : #'api - wardley map view model' }
GtWardleyMapNodeEditorElement >> onWardleyMapViewModelChanged [
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
				
				self wardleyMapNodeViewModel changeColorTo: eachColor.
				self wardleyMapViewModel defaultColor: eachColor ] ])
]
