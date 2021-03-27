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
		BlRectangleGeometry new.
		BlEllipseGeometry new.
	 } ].

	self shape: [ :aGeometry |
		BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			icon: (aGeometry class new asElement size: 20@20);
			margin: (BlInsets all: 3) ]
]
