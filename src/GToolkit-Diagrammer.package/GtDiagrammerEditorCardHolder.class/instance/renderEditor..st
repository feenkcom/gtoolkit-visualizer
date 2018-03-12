rendering
renderEditor: anEditor
	^ GtDiagrammerTitledCard new
		margin: (BlInsets empty);
		constraintsDo: [ :c | c horizontal matchParent ];
		border: BlBorder empty;
		title: anEditor title;
		titleTextDo: [ :aText | aText foreground: Color black ];
		content: anEditor editor