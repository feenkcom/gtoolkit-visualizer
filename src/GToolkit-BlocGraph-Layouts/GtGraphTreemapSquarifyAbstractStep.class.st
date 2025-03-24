Class {
	#name : #GtGraphTreemapSquarifyAbstractStep,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #enumerating }
GtGraphTreemapSquarifyAbstractStep >> allAreas [
	self 
		deprecated: 'Please use #allSteps instead.'
		transformWith: '`@receiver allAreas' -> '`@receiver allSteps'.
	^ self allSteps
]

{ #category : #accessing }
GtGraphTreemapSquarifyAbstractStep >> allSteps [
	<return: #Array of: #GtGraphTreemapSquarifyAbstractStep>
	^ self subclassResponsibility
]

{ #category : #converting }
GtGraphTreemapSquarifyAbstractStep >> asElementWithOccupiedArea [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #converting }
GtGraphTreemapSquarifyAbstractStep >> asPreviewStep [
	^ GtGraphTreemapSquarifyStepPreview new step: self
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> gtAllStepsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Steps';
		priority: 3;
		items: [ self withPreviousAndNextSteps ];
		column: ''
			icon: [ :aStep | 
				(self isSameStep: aStep)
					ifTrue: [ BlElement new 
						size: 8@8; 
						background: BrGlamorousColors primaryBorderColor; 
						geometry: BlCircleGeometry new;
						aptitude: (BrGlamorousWithExplicitTooltipAptitude text: 'This step') ] 
					ifFalse: [ BlElement new size: 0 @ 0 ] ]
			width: 16;
		column: 'Success' text: [ :aStep | aStep  successName ] width: 80;
		column: 'Type' text: [ :aStep | aStep orientationName ] width: 100;
		column: 'Worst Aspect' text: [ :aStep | aStep  worstString ];
		column: 'Nodes' text: [ :aStep | aStep nodesCount ] width: 50; 
		column: 'Bounds' text: [ :aStep | aStep rectangleBounds ].
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Nodes';
		priority: 2;
		items: [ self nodes ];
		column: 'Weight' text: [ :aNode | aNode weight ] width: 100; 
		column: 'Position' text: [ :aNode | aNode position ifNil: [ '<uninitialized>' asRopedText foreground: Color lightGray ] ];
		column: 'Extent' text: [ :aNode | aNode extent ifNil: [ '<uninitialized>' asRopedText foreground: Color lightGray ] ].
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> gtPreviewFor: aView [
	<gtView>
	self rectangle ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self asElementWithOccupiedArea asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> gtWorstValueFor: aView [
	<gtView>
	^ (self worstValue gtPreviewFor: aView)
		title: 'Worst aspect ratio';
		priority: 5
]

{ #category : #testing }
GtGraphTreemapSquarifyAbstractStep >> isDefinedStep [
	^ true
]

{ #category : #comparing }
GtGraphTreemapSquarifyAbstractStep >> isSameStep: aStep [
	^ self == aStep
]

{ #category : #accessing }
GtGraphTreemapSquarifyAbstractStep >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyAbstractStep >> rectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGraphTreemapSquarifyAbstractStep >> withPreviousAndNextSteps [
	<return: #Array of: #GtGraphTreemapSquarifyAbstractStep>
	^ self allSteps
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> worstValue [
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> worstValueRounded [
	<return: #Number>
	^ self worstValue asFloat round: 2
]
