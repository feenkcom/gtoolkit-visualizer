examples
editorElements
	<gtExample>
	| text element editor view |
	text := BrRopeExamples new textWithAttributes.
	element := BrEditorElement new.
	editor := BrTextEditor new.
	editor text: text.
	editor moveCursorTo: 30.
	element editor: editor.
	element constraintsDo: [ :c | c vertical fitContent. c horizontal fitContent ].
	element forceLayout.
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			| form content container label labelText |
			container := BlElement new 
				constraintsDo: [:c | 
					c vertical fitContent. 
					c horizontal fitContent.
					c padding: (BlInsets top: 5 bottom: 5)];
				layout: (BlGridLayout vertical cellSpacing: 1).
			labelText := (((each class name withoutPrefix: 'Br') withoutPrefix: 'Bl') withoutSuffix: 'Element') asRopedText.
			labelText attributes: { BrFontSizeAttribute size: 9 . BrTextForegroundAttribute paint: Color lightGray }.
			label := BlTextElement new text: labelText. 
			label constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: label.
			form := each asSpartaForm.
			content := BlElement new
				size: form extent;
				background: (BlBackground image: form).
			container addChild: content.
			container ];
		with: element withAllChildrenBreadthFirst.
	view edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	view layout tree horizontalGap: 10; verticalGap: 40.
	^ view
		