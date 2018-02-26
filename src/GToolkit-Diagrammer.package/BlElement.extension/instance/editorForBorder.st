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
	colorPicker margin: (BlInsets top: 0 left: 10 bottom: 10 right: 0).
	colorPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self border: (self border copyWithPaint: anEvent entity) ].

	outskirtsPicker := GtDiagrammerOutskirtsPicker new.
	outskirtsPicker select: self outskirts.
	outskirtsPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self outskirts: anEvent entity ].

	lineCapPicker := GtDiagrammerLineCapPicker new.
	lineCapPicker select: self border style lineCap.
	lineCapPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self border: (self border copyWithStyle: (self border style copyWithLineCap: anEvent entity)) ].

	lineJoinPicker := GtDiagrammerLineJoinPicker new.
	lineJoinPicker select: self border style lineJoin.
	lineJoinPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self border: (self border copyWithStyle: (self border style copyWithLineJoin: anEvent entity)) ].
	
	widthPicker := GtDiagrammerNumberPicker new.
	widthPicker select: self border width.
	widthPicker layout: BlFlowLayout horizontal.
	widthPicker margin: (BlInsets top: 0 left: 10 bottom: 10 right: 0).
	widthPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	widthPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self border: (self border copyWithWidth: anEvent entity) ].
	
	^ container addChildren: { colorPicker . outskirtsPicker . lineCapPicker . lineJoinPicker . widthPicker }