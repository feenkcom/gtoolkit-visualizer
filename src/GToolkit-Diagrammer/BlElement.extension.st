Extension { #name : #BlElement }

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> beDiagrammerSelectionLeaf [
	self userData
		at: #diagrammerSelectionLeaf
		put: true
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> diagrammerBackgroundEditor: aComposite [
	<diagrammerEditor: 10>

	^ aComposite with
		title: 'Background';
		editor: [ self editorForBackground ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> diagrammerBorderEditor: aComposite [
	<diagrammerEditor: 20>

	^ aComposite with
		title: 'Border';
		editor: [ self editorForBorder ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> diagrammerGeometryEditor: aComposite [
	<diagrammerEditor: 20>

	^ aComposite with
		title: 'Geometry';
		editor: [ self editorForGeometry ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> editorForBackground [
	| container colorPicker alphaPicker |
	
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	
	colorPicker := GtDiagrammerColorPicker new.
	colorPicker layout: BlFlowLayout horizontal.
	colorPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	colorPicker constraintsDo: [ :c | c linear vertical alignCenter ].
	colorPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self background: anEvent model ].

	alphaPicker := GtDiagrammerNumberPicker new.
	alphaPicker format: [ :aNumber | aNumber printShowingDecimalPlaces: 1 ].
	alphaPicker display: [ (0 to: 1 by: 0.1) ].
	alphaPicker layout: BlFlowLayout horizontal.
	alphaPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	alphaPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent |  ].

	^ container addChildren: { colorPicker . "alphaPicker" }
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> editorForBorder [
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
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> editorForGeometry [
	| picker |

	picker := GtDiagrammerGeometryPicker new.
	picker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self geometry: anEvent model class new ].
	^ picker
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> gtInspectorEditorIn: aComposite [
	<gtInspectorPresentationOrder: 12>
	^ aComposite bloc
		title: 'Editor';
		element: [ | theEditors container |
			theEditors := GtDiagrammerFigureEditor editorsOf: self.
			
			container := BlElement new.
			container layout: BlLinearLayout vertical.
			container constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			theEditors do: [ :anEditor |
				| aTitle |
				aTitle := BlTextEditElement new text: (anEditor title asRopedText).
				aTitle margin: (BlInsets all: 5). 
				container addChild: aTitle.
				container addChild: anEditor editor ].
			
			container ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlElement >> isDiagrammerSelectionLeaf [
	<return: #Boolean>

	^ self userData
		at: #diagrammerSelectionLeaf
		ifAbsent: [ false ]
]
