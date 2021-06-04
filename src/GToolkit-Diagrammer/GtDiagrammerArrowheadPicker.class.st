"
I allow users to pick an arrowhead for a curve


"
Class {
	#name : #GtDiagrammerArrowheadPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerArrowheadPicker >> initialize [
	super initialize.
		
	self display: [ { 
		GtDiagrammerArrowheadFilledCircleStencil new scale: 5.
		GtDiagrammerArrowheadHollowCircleStencil new scale: 5.
		GtDiagrammerArrowheadSimpleArrowStencil new arrowLengthFraction: 12; arrowNoseAngle: 45.
		GtDiagrammerArrowheadFilledTriangleStencil new scale: 5.
		GtDiagrammerArrowheadHollowTriangleStencil new scale: 5.
		GtDiagrammerArrowheadNoneStencil new
	 } ].

	self shape: [ :anArrowheadStencil |	
		BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			icon: anArrowheadStencil icon;
			margin: (BlInsets all: 3) ]
]
