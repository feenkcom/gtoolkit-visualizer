"
nextStep
	^ self step nextStep
"
Class {
	#name : #GtGraphTreemapSquarifyRejectedStep,
	#superclass : #GtGraphTreemapSquarifyAbstractStep,
	#instVars : [
		'step'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> allSteps [
	<return: #Array of: #GtGraphTreemapSquarifyAbstractStep>
	^ #()
]

{ #category : #converting }
GtGraphTreemapSquarifyRejectedStep >> asElementWithOccupiedArea [
	<return: #BlElement>
	| anElement |
	anElement := self step asElementWithOccupiedArea.
	anElement padding: (BlInsets all: 5).
	anElement border: (BlBorder paint: BrGlamorousColors errorBorderColor width: 3).
	^ anElement
]

{ #category : #converting }
GtGraphTreemapSquarifyRejectedStep >> asRejectedStep [
	^ self
]

{ #category : #testing }
GtGraphTreemapSquarifyRejectedStep >> hasNextStep [
	^ self step hasNextStep
]

{ #category : #testing }
GtGraphTreemapSquarifyRejectedStep >> isRejectedStep [
	^ true
]

{ #category : #'accessing - step' }
GtGraphTreemapSquarifyRejectedStep >> nextStep [
	^ self step nextStep
]

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ self step nodes
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyRejectedStep >> nodesCount [
	<return: #Integer>
	^ self step nodesCount
]

{ #category : #'accessing - rectangle' }
GtGraphTreemapSquarifyRejectedStep >> orientationName [
	<return: #String>
	^ self step orientationName
]

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> rectangle [
	<return: #GtGraphTreemapSquarifyAreaRectangle>
	^ self step rectangle
]

{ #category : #'accessing - rectangle' }
GtGraphTreemapSquarifyRejectedStep >> rectangleBounds [
	<return: #Rectangle>
	^ self step rectangleBounds
]

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> rejectedStep [
	^ GtGraphTreemapSquarifyStep null
]

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> step [
	^ step
]

{ #category : #accessing }
GtGraphTreemapSquarifyRejectedStep >> step: anObject [
	step := anObject
]

{ #category : #enumerating }
GtGraphTreemapSquarifyRejectedStep >> stepsDo: anOneArgBlock [
	anOneArgBlock cull: self.
]

{ #category : #'accessing - step' }
GtGraphTreemapSquarifyRejectedStep >> successName [
	<return: #BlRope>
	^ 'Rejected' asRopedText foreground: BrGlamorousColors errorBackgroundColor
]

{ #category : #'accessing - worst' }
GtGraphTreemapSquarifyRejectedStep >> worstString [
	^ self step worstString
]

{ #category : #'accessing - worst' }
GtGraphTreemapSquarifyRejectedStep >> worstValue [
	^ self step worstValue
]
