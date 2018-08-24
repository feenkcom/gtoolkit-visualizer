"
I store layout properties of the nodes within tree layout that are used during layout computation.

Those properties can be later accessed after layout computation for testing and debug purposes
"
Class {
	#name : #GtGradTreeConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'computedOffset',
		'computedContour',
		'computedPosition'
	],
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #accessing }
GtGradTreeConstraints >> computedContour [
	<return: #GtGradNodeContour>

	^ computedContour
]

{ #category : #accessing }
GtGradTreeConstraints >> computedContour: aNodeContour [
	computedContour := aNodeContour
]

{ #category : #accessing }
GtGradTreeConstraints >> computedOffset [
	<return: #Point>

	^ computedOffset
]

{ #category : #accessing }
GtGradTreeConstraints >> computedOffset: aPoint [
	computedOffset := aPoint
]

{ #category : #accessing }
GtGradTreeConstraints >> computedPosition [
	<return: #Point>

	^ computedPosition
]

{ #category : #accessing }
GtGradTreeConstraints >> computedPosition: anObject [
	computedPosition := anObject
]

{ #category : #initialization }
GtGradTreeConstraints >> initialize [
	super initialize.

	computedOffset := 0@0.
	computedPosition := 0@0.
	computedContour := GtGradNodeContour new
]
