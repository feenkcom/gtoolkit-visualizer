Class {
	#name : #GtGraphTreemapSquarifyStepPreview,
	#superclass : #GtGraphTreemapSquarifyAbstractStep,
	#instVars : [
		'step',
		'nodes'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> allSteps [
	<return: #Array of: #GtGraphTreemapSquarifyAbstractStep>
	^ self step allSteps
]

{ #category : #converting }
GtGraphTreemapSquarifyStepPreview >> asElementWithOccupiedArea [
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self rectangle asElementWithOccupiedArea as: #occupiedArea.
	self nodesDo: [ :eachNode | 
		eachNode hasBounds ifTrue: [ 
			| anElement |
			anElement := eachNode asElement
				size: eachNode extent asFloatPoint;
				relocate: eachNode position asFloatPoint.
			anElement allChildrenBreadthFirstDo: [ :eachChild | 
				eachChild background: BlBackground transparent ]. 
			aContainer addChild: anElement ] ].
	^ aContainer
]

{ #category : #converting }
GtGraphTreemapSquarifyStepPreview >> asPreviewStep [
	^ self
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ nodes
]

{ #category : #enumerating }
GtGraphTreemapSquarifyStepPreview >> nodesDo: aBlock [
	self nodes do: aBlock
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyStepPreview >> occupiedWeight [
	^ self step occupiedWeight
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> rectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ self step rectangle
]

{ #category : #squarifying }
GtGraphTreemapSquarifyStepPreview >> squarifyNodes [
	nodes := Array streamContents: [ :aStream | 
		self step nodesDo: [ :eachNode | 
			aStream nextPut: eachNode copy ] ].
	self step rectangle squarifyStep: self.
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> step [
	^ step
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> step: anObject [
	step := anObject.
	self squarifyNodes.
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyStepPreview >> worstValue [
	<return: #Number>
	^ self step worstValue
]
