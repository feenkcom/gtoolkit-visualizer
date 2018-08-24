"
I allow users to pick a line cap
"
Class {
	#name : #GtDiagrammerLineCapPicker,
	#superclass : #GtDiagrammerPicker,
	#category : 'GToolkit-Diagrammer-UI-Pickers'
}

{ #category : #initialization }
GtDiagrammerLineCapPicker >> initialize [
	| cellSize anchorSize anchorY lineWidth |
	super initialize.
	
	cellSize := 60@30.
	anchorSize := 6@6.
	
	anchorY := (cellSize y / 2) rounded.
	lineWidth := (cellSize y / 1.6) rounded.
	
	self display: [ { 
		BlStrokeLineCap butt.
		BlStrokeLineCap round.
		BlStrokeLineCap square.
	 } ].

	self shape: [ :aLineCap |
		| fromAnchor toAnchor iconElement |
		
		fromAnchor := BlElement new
			size: anchorSize;
			geometry: BlEllipse new;
			relocate: (cellSize y / 2.0) @ (anchorY) - (anchorSize / 2.0);
			background: (Color gray alpha: 0.5).

		toAnchor := BlElement new
			size: anchorSize;
			geometry: BlEllipse new;
			relocate: (cellSize x - (cellSize y / 2.0))@(anchorY) - (anchorSize / 2.0);
			background: (Color gray alpha: 0.5).

		iconElement := BlElement new
			size: cellSize;
			addChildren: { fromAnchor . toAnchor };
			addChild: (BlLineElement new
				fromAnchor: (BlElementCenterAnchor element: fromAnchor);
				toAnchor: (BlElementCenterAnchor element: toAnchor);
				border: (BlBorder builder lineCap: aLineCap; width: lineWidth; paint: (Color gray alpha: 0.3); build));
			addChild: (BlLineElement new
				fromAnchor: (BlElementCenterAnchor element: fromAnchor);
				toAnchor: (BlElementCenterAnchor element: toAnchor);
				border: (BlBorder builder width: 1; paint: (Color blue alpha: 0.4); build)).
		BrToggle new
			look: BrMaterialToggleIconifiedLook;
			icon: iconElement;
			padding: (BlInsets empty);
			margin: (BlInsets all: 3) ].
]
