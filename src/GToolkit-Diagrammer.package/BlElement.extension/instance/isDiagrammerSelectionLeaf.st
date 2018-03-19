*GToolkit-Diagrammer
isDiagrammerSelectionLeaf
	<return: #Boolean>

	^ self userData
		at: #diagrammerSelectionLeaf
		ifAbsent: [ false ]