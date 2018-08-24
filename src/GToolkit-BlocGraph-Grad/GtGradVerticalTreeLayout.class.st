Class {
	#name : #GtGradVerticalTreeLayout,
	#superclass : #GtGradTreeLayout,
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY [
	| x y |
	x := bounds right + self treesDistance.
	dx > 0
		ifTrue: [ x := x + dx ].
	y := startY.
	
	^ x @ y
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> childOffsetBreadth: aChildElement [
	"Return the breadth of the offset of the given child element"
	<return: #Number>

	^ aChildElement constraints gradTree computedOffset y
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> childOffsetLength: aChildElement [
	"Return the length of the offset of the given child element"
	<return: #Number>
	
	^ 0
]

{ #category : #initialization }
GtGradVerticalTreeLayout >> initialize [
	super initialize.

]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode [

	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height)
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeBreadth: aTreeNode [
	^ aTreeNode width
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	| parentCorrection |
	parentCorrection := aTreeNode hasParent
		ifFalse: [ 0 ]
		ifTrue: [ (aRootNode maxHeightAt: aTreeNode parent) - aTreeNode parent height ].
	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height
				+ parentCorrection) / 2.0
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeLength: aTreeNode [
	^ aTreeNode height
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeOffsetBreadth: aNodeElement [
	"Return the breadth of the offset of the given node element"
	<return: #Number>

	^ aNodeElement constraints gradTree computedOffset y
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeOffsetLength: aNodeElement [
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ aNodeElement constraints gradTree computedOffset x
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ aTreeNode hasParent
		ifTrue: [ 0@((aRootNode maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height) ]
		ifFalse: [ 0@0 ]
]

{ #category : #'api - geometry' }
GtGradVerticalTreeLayout >> reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds [
"calculate position of the node so that it the node is flipped
over a horizontal line containing the root node"
	| nodePosition |
	
	nodePosition := aTreeNode element constraints gradTree computedPosition.

	^ (nodePosition x) @ ( 2 * (theRootPosition y) - (nodePosition  y) + (theBounds bottom)).
	
	


]
