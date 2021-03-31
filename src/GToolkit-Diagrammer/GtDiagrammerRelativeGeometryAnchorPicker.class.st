"
I allow users to pick a relative geometry anchor
"
Class {
	#name : #GtDiagrammerRelativeGeometryAnchorPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerRelativeGeometryAnchorPicker >> initialize [
	super initialize.
	
	self display: [ { 
		BlElementTopLeftAnchor . BlElementTopCenterAnchor . BlElementTopRightAnchor .
		BlElementCenterLeftAnchor . BlElementCenterAnchor . BlElementCenterRightAnchor .
		BlElementBottomLeftAnchor . BlElementBottomCenterAnchor . BlElementBottomRightAnchor .
		BlNearestPositionBoundsAnchor . BlNearestPositionLooseCircleAnchor . BlNearestPositionEllipseAnchor
	 } ].

	self shape: [ :anAnchorClass | BrToggle new
		margin: (BlInsets all: 3);
		aptitude: BrMaterialToggleLabelledAptitude;
		label: anAnchorClass label ]
]
