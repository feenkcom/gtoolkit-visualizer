"
I allow users to pick a color


"
Class {
	#name : #GtDiagrammerColorPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerColorPicker >> initialize [
	super initialize.
	
	self display: [ Color registeredColorNames collect: [ :aName | Color named: aName ] ].
	self shape: [ :aColor |
		BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			aptitudeDo: [ :aLook | aLook background checkedBackground: Color blue ];
			icon: (BlElement new
				size: 20@20;
				background: aColor;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 3));
			padding: (BlInsets all: 1);
			margin: (BlInsets all: 3) ]
]
