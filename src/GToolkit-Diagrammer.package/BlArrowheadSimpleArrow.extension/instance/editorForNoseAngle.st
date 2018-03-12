*GToolkit-Diagrammer
editorForNoseAngle
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker display: [ 15 to: 165 by: 15 ].
	aPicker select: self border width.
	aPicker layout: BlFlowLayout horizontal.
	aPicker margin: (BlInsets top: 0 left: 10 bottom: 10 right: 0).
	aPicker constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self arrowNoseAngle: anEvent model ].
		
	^ aPicker