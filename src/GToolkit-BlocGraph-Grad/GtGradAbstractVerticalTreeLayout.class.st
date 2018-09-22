Class {
	#name : #GtGradAbstractVerticalTreeLayout,
	#superclass : #GtGradAbstractTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY [
	| x y |
	x := bounds right + self treesDistance.
	dx > 0
		ifTrue: [ x := x + dx ].
	y := startY.
	
	^ x @ y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> childOffsetBreadth: aNodesChild [
	"Return the breadth of the offset of the given child element"
	<return: #Number>

	^ aNodesChild offset y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> childOffsetLength: aNodesChild [
	"Return the length of the offset of the given child element"
	<return: #Number>
	
	^ 0
]

{ #category : #initialization }
GtGradAbstractVerticalTreeLayout >> formForestFrom: theNodes [
	self subclassResponsibility
]

{ #category : #initialization }
GtGradAbstractVerticalTreeLayout >> initialize [
	super initialize.

]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode [

	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height)
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeBreadth: aTreeNode [
	^ aTreeNode width
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	| parentCorrection |
	parentCorrection := aTreeNode hasParent
		ifFalse: [ 0 ]
		ifTrue: [ (aRootNode maxHeightAt: aTreeNode parent) - aTreeNode parent height ].
	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height
				+ parentCorrection) / 2.0
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeLength: aTreeNode [
	^ aTreeNode height
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeOffsetBreadth: aTreeNode [
	"Return the breadth of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeOffsetLength: aTreeNode [
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset x
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ aTreeNode hasParent
		ifTrue: [ 0@((aRootNode maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height) ]
		ifFalse: [ 0@0 ]
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds [
"calculate position of the node so that it the node is flipped
over a horizontal line containing the root node"
	| nodePosition |
	
	nodePosition := aTreeNode element constraints gradTree computedPosition.

	^ (nodePosition x) @ ( 2 * (theRootPosition y) - (nodePosition  y) + (theBounds bottom)).
	
	


]
