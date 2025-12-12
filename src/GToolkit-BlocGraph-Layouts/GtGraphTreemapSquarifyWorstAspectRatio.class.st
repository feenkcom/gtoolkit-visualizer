"
I compute worst aspect ratio based on node height and weight.
See {{gtClass:GtGraphTreemapSquarifyWorst}} for more details and examples.


"
Class {
	#name : #GtGraphTreemapSquarifyWorstAspectRatio,
	#superclass : #GtGraphTreemapSquarifyWorst,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyWorstAspectRatio >> aspectRatioForNode: aNode [
	<return: #Number>
	| aNodeArea aNodeLength anOccupiedBreadth |
	self area isZero ifTrue: [ ^ Float nan ].
	aNode weight isZero ifTrue: [ ^ 1 ].
	anOccupiedBreadth := self nodesBreadth.
	aNodeArea := aNode weight * self totalArea.
	aNodeLength := aNodeArea / anOccupiedBreadth.
	^ aNodeLength / anOccupiedBreadth max: anOccupiedBreadth / aNodeLength
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstAspectRatio >> maxWeightNodeAspectRatio [
	<return: #Number>
	^ self aspectRatioForNode: self maxWeightNode
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstAspectRatio >> minWeightNodeAspectRatio [
	<return: #Number>
	^ self aspectRatioForNode: self minWeightNode
]

{ #category : #evaluating }
GtGraphTreemapSquarifyWorstAspectRatio >> value [
	"Return worst aspect ratio value"
	<return: #Number>
	^ self maxWeightNodeAspectRatio max: self minWeightNodeAspectRatio
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstAspectRatio >> worstValueForNode: aNode [
	<return: #Number>
	^ self aspectRatioForNode: aNode
]
