"
I allow users to pick an element outskirts


"
Class {
	#name : #GtDiagrammerOutskirtsPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerOutskirtsPicker >> initialize [
	| cellSize previewSize borderWidth |
	super initialize.
	
	cellSize := 60@30.
	previewSize := 16@16.
	borderWidth := 4.
	
	self display: [ { 
		BlOutskirts inside.
		BlOutskirts centered.
		BlOutskirts outside.
	 } ].

	self shape: [ :theOutskirts |
		| anIconElement |	
		anIconElement := BlElement new
			size: cellSize;
			layout: BlFrameLayout new;
			addChild: (BlElement new
				outskirts: theOutskirts;
				background: (Color gray alpha: 0.3);
				geometry: BlEllipseGeometry new;
				border: (BlBorder paint: (Color blue alpha: 0.2) width: borderWidth);
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				size: previewSize);
			addChild: (BlElement new
				outskirts: BlOutskirts centered;
				geometry: BlEllipseGeometry new;
				border: (BlBorder builder dashedSmall paint: (Color black alpha: 0.5); width: 1; build);
				constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				size: previewSize).
		BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			icon: anIconElement;
			padding: (BlInsets empty);
			margin: (BlInsets all: 3) ].

]
