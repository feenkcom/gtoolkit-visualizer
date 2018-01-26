instance creation
create
	| uml |
	uml := GtMondrianUMLClassElement withDefaultContainer label: 'View'.
	uml graph addChildren: {
			BlTextElement new text: ' - width: Int' asRopedText.
			BlTextElement new text: ' - height: Int' asRopedText.
			BlTextElement new text: ' - color: Color' asRopedText.
		} inChildrenContainer: #default.
	^ uml