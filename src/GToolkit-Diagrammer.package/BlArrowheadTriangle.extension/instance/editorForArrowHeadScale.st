*GToolkit-Diagrammer
editorForArrowHeadScale
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker select: self border width.
	aPicker layout: BlFlowLayout horizontal.
	aPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self scale: anEvent model ].
		
	^ aPicker