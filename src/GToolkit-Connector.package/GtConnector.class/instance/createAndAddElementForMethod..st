private
createAndAddElementForMethod: method
	| editor editorElement text styler |	
	
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical fitContent.
			c maxHeight: 200.
			c padding: (BlInsets all: 10) ].
	editorElement
		background: Color white;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).

	styler := GtConnectorExampleStyler new.
	styler exampleAction: [ :anExampleMethod | self addMethod: anExampleMethod ].
	styler classOrMetaClass: method methodClass.
	styler addEventHandler: stylerListener.

	editor := BrTextEditor new.
	editor styler: styler.

	editorElement userData at: #editedMethod put: method.
	editorElement editor: editor.

	editorElement beConnectorTarget.
	editorElement connectorTarget: method.

	text := method sourceCode asRopedText.

	self addChild: editorElement.
	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editor text: text.	
	
	^ editorElement