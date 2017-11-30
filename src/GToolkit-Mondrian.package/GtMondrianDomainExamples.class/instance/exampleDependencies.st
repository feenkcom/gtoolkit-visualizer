examples
exampleDependencies
	<gtExample>
	| view |
	view := self emptyView.
	view nodes 
		shape: [ :each | 
			| text styler editor editorElement |
			text := BrRopedText string: each method sourceCode.
			styler := GtExamplesStyler new classOrMetaClass: each methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor.
			editorElement ];
		with: ((BlBezierExamples>>#quadraticCurveWithAnchors) gtExample withDeepCollect: #directDependencies) asSet.
	view edges 
		fromRightCenter; toLeftCenter;
		connectToAll: #directDependencies.
	view layout horizontalDominanceTree layered horizontalGap: 100.
	^ view