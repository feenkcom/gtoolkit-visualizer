"
I allow users to pick an element geometry
"
Class {
	#name : #GtDiagrammerGeometryPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerGeometryPicker >> initialize [
	super initialize.

	self display: [ { 
		BlRoundedRectangleGeometry new.
		BlEllipse new.
	 } ].

	self shape: [ :aGeometry |
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			icon: (aGeometry class new asElement size: 20@20);
			margin: (BlInsets all: 3) ]
]
