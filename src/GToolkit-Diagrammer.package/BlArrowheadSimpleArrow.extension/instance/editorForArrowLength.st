*GToolkit-Diagrammer
editorForArrowLength
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker select: self border width.
	aPicker layout: BlFlowLayout horizontal.
	aPicker margin: (BlInsets top: 0 left: 10 bottom: 10 right: 0).
	aPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self arrowLengthFraction: anEvent model ].
		
	^ aPicker