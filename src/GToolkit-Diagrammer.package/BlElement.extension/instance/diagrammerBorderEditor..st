*GToolkit-Diagrammer
diagrammerBorderEditor: anEditor
	<diagrammerEditor: 20>

	^ anEditor
		title: 'Border';
		editor: [ self editorForBorder ]