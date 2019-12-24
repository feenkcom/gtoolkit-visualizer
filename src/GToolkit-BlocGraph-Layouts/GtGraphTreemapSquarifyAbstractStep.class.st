Class {
	#name : #GtGraphTreemapSquarifyAbstractStep,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

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
		items: [ self allSteps ];
		column: 'Success' item: [ :aStep | aStep  successName ] width: 80;
		column: 'Type' item: [ :aStep | aStep orientationName ] width: 100;
		column: 'Worst Aspect' item: [ :aStep | aStep  worstString ];
		column: 'Nodes' item: [ :aStep | aStep nodesCount ] width: 50; 
		column: 'Bounds' item: [ :aStep | aStep rectangleBounds ].
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyAbstractStep >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Nodes';
		priority: 2;
		items: [ self nodes ];
		column: 'Weight' item: [ :aNode | aNode weight ] width: 100; 
		column: 'Position' item: [ :aNode | aNode position ifNil: [ '<uninitialized>' asRopedText foreground: Color lightGray ] ];
		column: 'Extent' item: [ :aNode | aNode extent ifNil: [ '<uninitialized>' asRopedText foreground: Color lightGray ] ].
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

{ #category : #testing }
GtGraphTreemapSquarifyAbstractStep >> isDefinedStep [
	^ true
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
