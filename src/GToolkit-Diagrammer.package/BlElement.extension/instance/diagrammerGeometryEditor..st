*GToolkit-Diagrammer
diagrammerGeometryEditor: anEditor
	<diagrammerEditor: 20>

	^ anEditor
		title: 'Geometry';
		editor: [ self editorForGeometry ]