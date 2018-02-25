*GToolkit-Diagrammer
diagrammerBackgroundEditor: aComposite
	<diagrammerEditor: 10>

	^ aComposite with
		title: 'Background';
		editor: [ self editorForBackground ]