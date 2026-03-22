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
	
	self previousStepsWithDifferentAreasFromDownDo: [ :eachStep | 
		eachStep nodesDo: [ :eachNode |  
			eachNode hasBounds ifTrue: [ 
				| anElement |
				anElement := eachNode asElement
					size: eachNode extent asFloatPoint;
					relocate: eachNode position asFloatPoint.
				(anElement childWithId: #'treemap--node-label')
					aptitude foreground: Color black.
				(anElement childWithId: #'rectangle')
					background: Color veryLightGray.
				aContainer addChild: anElement
			].
		].
	].
	
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

{ #category : #testing }
GtGraphTreemapSquarifyStepPreview >> isRejectedStep [
	^ self step isRejectedStep
]

{ #category : #comparing }
GtGraphTreemapSquarifyStepPreview >> isSameStep: aStep [
	^ self step == aStep or: [ self == aStep ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> nodesCount [
	<return: #Integer>
	^ self step nodesCount
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
GtGraphTreemapSquarifyStepPreview >> orientationName [
	<return: #String>
	^ self step orientationName
]

{ #category : #enumerating }
GtGraphTreemapSquarifyStepPreview >> previousStepsWithDifferentAreasFromDownDo: aBlock [
	self step previousStepsWithDifferentAreasFromDownDo: aBlock
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> rectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ self step rectangle
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> rectangleBounds [
	<return: #BlRope>
	^ self step rectangleBounds
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

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> successName [
	<return: #BlRope>
	^ self step successName
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> withPreviousAndNextSteps [
	<return: #Array of: #GtGraphTreemapSquarifyAbstractStep>
	^ self step withPreviousAndNextSteps
		collect: [ :eachStep | 
			eachStep == self step 
				ifTrue: [ self ] 
				ifFalse: [ eachStep ] ]
]

{ #category : #accessing }
GtGraphTreemapSquarifyStepPreview >> worstString [
	<return: #String>
	^ self step worstString
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyStepPreview >> worstValue [
	<return: #Number>
	^ self step worstValue
]
