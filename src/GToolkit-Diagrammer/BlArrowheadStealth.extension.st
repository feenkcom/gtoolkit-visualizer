Extension { #name : #BlArrowheadStealth }

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadStealth >> diagrammerArrowLengthEditor: anEditor [
	<diagrammerEditor: 6>
	
	anEditor with
		title: 'Scale';
		editor: [ self editorForArrowLength ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadStealth class >> diagrammerDefault [
	"Return a default instance for a diagrammer with predefined properties"
	<return: #BlArrowheadElement>

	^ self new
		arrowLengthFraction: 12
]

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadStealth >> diagrammerNoseAngleEditor: anEditor [
	<diagrammerEditor: 7>
	
	anEditor with
		title: 'Nose angle';
		editor: [ self editorForNoseAngle ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadStealth >> editorForArrowLength [
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
]

{ #category : #'*GToolkit-Diagrammer' }
BlArrowheadStealth >> editorForNoseAngle [
	| aPicker |
	aPicker := GtDiagrammerNumberPicker new.
	aPicker display: [ 15 to: 165 by: 15 ].
	aPicker select: self arrowNoseAngle.
	aPicker layout: BlFlowLayout horizontal.
	aPicker constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	aPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self arrowNoseAngle: anEvent model ].
		
	^ aPicker
]
