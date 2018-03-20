*GToolkit-Diagrammer
editorForArrowLength
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker select: self arrowLengthFraction.
	aPicker layout: BlFlowLayout horizontal.
	aPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self arrowLengthFraction: anEvent model ].
		
	^ aPicker