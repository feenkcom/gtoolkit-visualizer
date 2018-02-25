*GToolkit-Diagrammer
diagrammerBorderEditor: aComposite
	<diagrammerEditor: 20>

	^ aComposite with
		title: 'Border';
		editor: [ self editorForBorder ]