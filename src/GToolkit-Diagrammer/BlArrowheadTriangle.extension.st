Extension { #name : #BlArrowheadTriangle }

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadTriangle >> diagrammerArrowHeadScaleEditor: anEditor [
	<diagrammerEditor: 6>
	
	anEditor with
		title: 'Scale';
		editor: [ self editorForArrowHeadScale ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadTriangle >> editorForArrowHeadScale [
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker select: self scale.
	aPicker layout: BlFlowLayout horizontal.
	aPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self scale: anEvent model ].
		
	^ aPicker
]
