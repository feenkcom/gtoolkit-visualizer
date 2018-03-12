*GToolkit-Diagrammer
editorForArrowHeadIn: anEditor
	| container fromArrowHeadLabel fromArrowHeadPicker toArrowHeadLabel toArrowHeadPicker |
	container := BlElement new.
	container padding: (BlInsets all: 10).
	container layout: BlLinearLayout vertical.
	container
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	
	fromArrowHeadLabel := BlTextElement text: 'From head' asRopedText.
	fromArrowHeadPicker := GtDiagrammerArrowheadPicker new.
	fromArrowHeadPicker select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ nil ]) class.
	fromArrowHeadPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			| aHead |
			aHead := anEvent entity new.
			aHead border: (self border copy).
			self fromHead: aHead.
			anEditor changed ].	
	
	toArrowHeadLabel := BlTextElement text: 'To head' asRopedText.
	toArrowHeadPicker := GtDiagrammerArrowheadPicker new.
	toArrowHeadPicker select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ nil ]) class.
	toArrowHeadPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			| aHead |
			aHead := anEvent entity new.
			aHead border: (self border copy).
			self toHead: aHead.
			anEditor changed ].

	^ container addChildren: { fromArrowHeadLabel . fromArrowHeadPicker . toArrowHeadLabel . toArrowHeadPicker }