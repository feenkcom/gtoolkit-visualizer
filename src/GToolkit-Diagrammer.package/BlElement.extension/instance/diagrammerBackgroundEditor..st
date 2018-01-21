*GToolkit-Diagrammer
diagrammerBackgroundEditor: anEditor
	<diagrammerEditor: 10>

	^ anEditor
		title: 'Background';
		editor: [ self editorForBackground ]