Class {
	#name : #GtGradTreeLayoutPreparator,
	#superclass : #GtGradTreeLayouter,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> attachParent: aTreeNode toContour: childrenContour [
	| height width newY |
	height := aTreeNode height + (self nodeDistance * 2).
	width := aTreeNode width.
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
	newY < 0 ifTrue: [ childrenContour translateBy: 0 @ newY abs ].
	aTreeNode contour: childrenContour
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> mergeWithChildrenContours: aTreeNode [
	| aFirstChildNode aNodeContour offsets |
	aFirstChildNode := aTreeNode nodes first.
	aNodeContour := aFirstChildNode contour.
	offsets := OrderedCollection new.
	offsets add: aFirstChildNode offset.
	aTreeNode nodes
		allButFirstDo: [ :aChildNode | 
			aNodeContour := aNodeContour
					mergeContour: aChildNode contour
					offsetCollection: offsets ].
	offsets size
		to: 2
		by: -1
		do: [ :i | offsets at: i put: (offsets at: i) - (offsets at: i - 1)].

	aTreeNode nodes allButFirst
		with: offsets allButFirst
		do: [ :child :off | child offset: child offset + off  ].

	^ aNodeContour
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitCompositeNode: aTreeNode [
	| childrenContour |
"
aTreeNode element incomingEdges size = 0 ifTrue: [self halt].
"
"	self halt."
	childrenContour := self mergeWithChildrenContours: aTreeNode.
	self attachParent: aTreeNode toContour: childrenContour
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitLeafNode: aTreeNode [
	aTreeNode
		contour: (GtGradNodeContour height: aTreeNode height+(2 * self nodeDistance) width: aTreeNode width)
]
