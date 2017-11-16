private
createAndAddElementForMethod: method
	| editor editorElement text |	
	
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c maxHeight: 200.
			c padding: (BlInsets all: 10) ].
	editorElement
		background: Color white;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).

	styler := GtConnectorExampleStyler new.
	"What happens when we click on a button"
	styler exampleAction: [ :exampleMethod :messageNode :buttonElement |
			(self hasOpenedMethod: exampleMethod)
				"method is not yet opened"
				ifFalse: [ self openMethod: exampleMethod relativeTo: editorElement linkedTo: buttonElement ]
				"method is already opened"
				ifTrue: [ self closeMethod: exampleMethod ] ];
		classOrMetaClass: method methodClass.
	styler
		addEventHandlerOn: BrTextStyledEvent
		do: [ :aStyledEvent |
			aStyledEvent currentTarget buttonAttributes
				do: [ :aButtonAttribute | aButtonAttribute addEventHandler: buttonCreatedListener ] ].

	editor := BrTextEditor new.
	editor styler: styler.

	editorElement userData at: #editedMethod put: method.
	editorElement editor: editor.

	editorElement beConnectorTarget.
	editorElement connectorTarget: method.

	text := BrRopedText string: method sourceCode.

	self addChild: editorElement.
	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editor text: text.	
	
	^ editorElement