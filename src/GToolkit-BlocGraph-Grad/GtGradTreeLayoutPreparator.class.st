Class {
	#name : #GtGradTreeLayoutPreparator,
	#superclass : #GtGradTreeLayouter,
	#instVars : [
		'root'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #measure }
GtGradTreeLayoutPreparator class >> on: aLayout root: aTreeNode [
	^ (super on: aLayout)
		root: aTreeNode;
		yourself
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> attachParent: aTreeNode toContour: childrenContour [
	| height width newY alignmentCorrection |
	alignmentCorrection := self layout nodesAlignment
			calculateCorrectionFor: aTreeNode
			aRootNode: root
			layout: layout.
	height := (self layout nodeBreadth: aTreeNode) + (self nodeDistance * 2)
			+ alignmentCorrection y.
	width := (self layout nodeLength: aTreeNode) + alignmentCorrection x.
	newY := childrenContour middleOfFront - (height / 2).
	aTreeNode offset: 0 @ newY.
	childrenContour
		translateBy: (width + self nodeDistance + self levelDistance) @ 0.
	aTreeNode nodes first
		offset: aTreeNode nodes first offset
				+ ((width + self nodeDistance + self levelDistance) @ newY negated).

	childrenContour upperPoints addFirst: width @ newY.
	childrenContour upperPoints addFirst: 0 @ newY.
	childrenContour lowerPoints addFirst: width @ (newY + height).
	childrenContour lowerPoints addFirst: 0 @ (newY + height).
	newY < 0
		ifTrue: [ aTreeNode offset: 0 @ 0.
			childrenContour translateBy: 0 @ newY abs ].
	aTreeNode contour: childrenContour
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> computeRelativeOffsetsForChildrenOf: aTreeNode contourOffsets: offsets [
	"Computes the sibling delta offsets based on the contour offsets and initial children offsets"
	offsets size
		to: 2
		by: -1
		do: [ :i | 
			offsets
				at: i
				put: (offsets at: i) - (offsets at: i - 1) - (aTreeNode nodes at: i - 1) offset ]
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> mergeWithChildrenContours: aTreeNode [
	| aFirstChildNode aNodeContour offsets |
	aFirstChildNode := aTreeNode nodes first.
	aNodeContour := aFirstChildNode contour.
	offsets := OrderedCollection new.
	offsets add: 0 @ 0.
	aTreeNode nodes
		allButFirstDo: [ :aChildNode | 
			aNodeContour := aNodeContour
					mergeContour: aChildNode contour
					offsetCollection: offsets ].
	self computeRelativeOffsetsForChildrenOf: aTreeNode contourOffsets: offsets.

	aTreeNode nodes allButFirst
		with: offsets allButFirst
		do: [ :child :off | child offset: off + child offset ].

	^ aNodeContour
]

{ #category : #accessing }
GtGradTreeLayoutPreparator >> root: aTreeNode [
	root := aTreeNode
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitCompositeNode: aTreeNode [
	| childrenContour |
	childrenContour := self mergeWithChildrenContours: aTreeNode.
	self attachParent: aTreeNode toContour: childrenContour
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitLeafNode: aTreeNode [
	| alignmentCorrection |
	alignmentCorrection := layout nodesAlignment
			calculateCorrectionFor: aTreeNode
			aRootNode: root
			layout: layout.
	aTreeNode
		contour: (GtGradNodeContour
				height: (self layout nodeBreadth: aTreeNode) + (2 * self nodeDistance)
						+ (self layout correctionBreadth: alignmentCorrection)
				width: (self layout nodeLength: aTreeNode)
						+ (self layout correctionLength: alignmentCorrection))
]
