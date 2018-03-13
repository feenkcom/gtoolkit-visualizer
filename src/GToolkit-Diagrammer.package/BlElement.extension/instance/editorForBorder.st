*GToolkit-Diagrammer
editorForBorder
	| container widthPicker colorPicker outskirtsPicker lineCapPicker lineJoinPicker |
	
	container := BlElement new.
	container padding: (BlInsets all: 10).
	container layout: BlLinearLayout vertical.
	container
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	colorPicker := GtDiagrammerColorPicker new.
	colorPicker layout: BlFlowLayout horizontal.
	colorPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	colorPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self border: (self border copyWithPaint: anEvent model) ].

	outskirtsPicker := GtDiagrammerOutskirtsPicker new.
	outskirtsPicker select: self outskirts.
	outskirtsPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self outskirts: anEvent model ].

	lineCapPicker := GtDiagrammerLineCapPicker new.
	lineCapPicker select: self border style lineCap.
	lineCapPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self border: (self border copyWithStyle: (self border style copyWithLineCap: anEvent model)) ].

	lineJoinPicker := GtDiagrammerLineJoinPicker new.
	lineJoinPicker select: self border style lineJoin.
	lineJoinPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self border: (self border copyWithStyle: (self border style copyWithLineJoin: anEvent model)) ].
	
	widthPicker := GtDiagrammerNumberPicker new.
	widthPicker select: self border width.
	widthPicker layout: BlFlowLayout horizontal.
	widthPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	widthPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self border: (self border copyWithWidth: anEvent model) ].
	
	^ container addChildren: { colorPicker . outskirtsPicker . lineCapPicker . lineJoinPicker . widthPicker }