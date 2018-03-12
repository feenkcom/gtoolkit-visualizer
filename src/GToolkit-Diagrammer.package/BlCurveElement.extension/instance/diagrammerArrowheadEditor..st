*GToolkit-Diagrammer
diagrammerArrowheadEditor: aComposite
	<diagrammerEditor: 5>

	aComposite with
		title: 'Arrow heads';
		and: [ :newEditor |
			newEditor
				title: 'From head';
				editor: [ self editorForFromArrowHeadIn: newEditor ].
			newEditor with
				title: 'From head style';
				from: [ self fromHead ];
				when: [ self hasFromHead ] ];
		and: [ :newEditor |
			newEditor
				title: 'To head';
				editor: [ self editorForToArrowHeadIn: newEditor ].
			newEditor with
				title: 'To head style';
				from: [ self toHead ];
				when: [ self hasToHead ] ]