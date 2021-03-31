"
I allow users to pick a diagrammer tool
"
Class {
	#name : #GtDiagrammerToolPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerToolPicker >> initialize [
	super initialize.

	self padding: (BlInsets all: 0).
	self shape: [ :aTool | BrToggle new
		aptitude: BrMaterialToggleLabelledAptitude - BrShadowAptitude - BrMaterialRoundedAptitude;
		label: aTool symbol asString ]
]
