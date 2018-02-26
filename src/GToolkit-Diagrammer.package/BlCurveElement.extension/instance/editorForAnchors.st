*GToolkit-Diagrammer
editorForAnchors
	| container fromAnchorLabel fromAnchorPicker toAnchorLabel toAnchorPicker |
	container := BlElement new.
	container padding: (BlInsets all: 10).
	container layout: BlLinearLayout vertical.
	container
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	
	fromAnchorLabel := BlTextElement text: 'From anchor' asRopedText.
	fromAnchorPicker := GtDiagrammerRelativeGeometryAnchorPicker new.
	fromAnchorPicker select: self fromAnchor class.
	fromAnchorPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			self fromAnchor: (anEvent entity
				referenceElement: self fromAnchor referenceElement
				relatedTo: self toAnchor referenceElement) ].
	
	toAnchorLabel := BlTextElement text: 'To anchor' asRopedText.
	toAnchorPicker := GtDiagrammerRelativeGeometryAnchorPicker new.
	toAnchorPicker select: self toAnchor class.
	toAnchorPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			self toAnchor: (anEvent entity
				referenceElement: self toAnchor referenceElement
				relatedTo: self fromAnchor referenceElement) ].

	^ container addChildren: { fromAnchorLabel . fromAnchorPicker . toAnchorLabel . toAnchorPicker }