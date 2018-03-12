*GToolkit-Diagrammer
diagrammerAnchorEditor: aComposite
	<diagrammerEditor: 6>
		
	aComposite with
		title: 'Anchors';
		and: [ :newEditor |
			newEditor
				title: 'From anchor';
				editor: [ self editorForFromAnchor ] ];
		and: [ :newEditor |
			newEditor
				title: 'To anchor';
				editor: [ self editorForToAnchor ] ]