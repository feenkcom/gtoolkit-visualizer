*GToolkit-Diagrammer
diagrammerGeometryEditor: aComposite
	<diagrammerEditor: 20>

	^ aComposite with
		title: 'Geometry';
		editor: [ self editorForGeometry ]