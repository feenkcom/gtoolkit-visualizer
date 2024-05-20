Class {
	#name : #GtWardleyMapNoteEditorElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithWardleyMapNoteViewModel + TGtWithWardleyMapViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithWardleyMapNoteViewModel classTrait + TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'predefinedColorsElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> createColorPicker [
	^ GtWardleyMapColorPickerElement new
		hFitContent;
		vFitContentLimited;
		columnCount: 8;
		cellSpacing: 5
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> createNodeColorLabel [
	^ GtWardleyMapUtility newColorLabelElement text: 'Note color'
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> createNodeDeleteButton [
	^ GtWardleyMapUtility newDeleteButtonElement
		label: 'Delete note';
		action: [ 
			self wardleyMapNoteViewModel removeFromMap.
			self fireEvent: BrDropdownHideWish new ]
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> createPropertiesEditorContainer [
	| aContainer |
	aContainer := BrVerticalPane new
			hFitContent;
			vFitContentLimited.
	aContainer addChildren: self createPropertyEditorElements.
	aContainer addChild: self createNodeDeleteButton.

	^ aContainer
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> createPropertyEditorElements [
	^ {
		self createNodeColorLabel.
		(predefinedColorsElement := self createColorPicker).
	}
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtWardleyMapNoteEditorElement >> initialize [
	| aContainer |
	super initialize.

	self
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	aContainer := self createPropertiesEditorContainer.

	self
		addChild:
			(BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
				vFitContentLimited;
				hFitContent;
				content: aContainer)
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNoteEditorElement >> onWardleyMapNoteViewModelChanged [
	"Is sent when a new WardleyMapNote view model is assigned to the element"
	
	
]

{ #category : #'api - wardley map view model' }
GtWardleyMapNoteEditorElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	predefinedColorsElement
		colors: self wardleyMapViewModel predefinedColors;
		whenColorPickedDo: [ :aColor |
			self wardleyMapNoteViewModel changeColorTo: aColor.
			self wardleyMapViewModel defaultColor: aColor ]
]
