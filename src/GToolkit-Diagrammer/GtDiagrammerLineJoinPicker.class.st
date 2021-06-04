"
I allow users to pick a line join


"
Class {
	#name : #GtDiagrammerLineJoinPicker,
	#superclass : #GtDiagrammerPicker,
	#category : #'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerLineJoinPicker >> initialize [
	| cellSize anchorSize anchorY lineWidth lineOffset |
	super initialize.
	
	cellSize := 60@30.
	anchorSize := 6@6.
	
	anchorY := (cellSize y / 2.0) rounded.
	lineWidth := (cellSize y / 2.2) rounded asFloat.
	lineOffset := cellSize x * 0.18.
	
	self display: [ { 
		BlStrokeLineJoin bevel.
		BlStrokeLineJoin miter.
		BlStrokeLineJoin round.
	 } ].

	self shape: [ :aLineJoin |	
		| anIconElement |	
		anIconElement := BlElement new
			size: cellSize;
			addChild: (BlElement new
				transformDo: [ :t | t
					scaleBy: 0.8;
					translateBy: (0 @ ((lineWidth / 2.0) - 1)) negated ];
				outskirts: BlOutskirts centered;
				geometry: (BlPolyline vertices: { (lineOffset) @ (cellSize y) . (cellSize x / 2.0) @ (lineWidth / 1) . (cellSize x - lineOffset) @ cellSize y });
				border: (BlBorder builder lineJoin: aLineJoin; width: lineWidth; paint: (Color gray alpha: 0.5); build)).
		
		BrToggle new
			aptitude: BrMaterialToggleIconifiedAptitude;
			icon: anIconElement;
			margin: (BlInsets all: 3);
			padding: (BlInsets all: 0) ].
]
