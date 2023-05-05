"
This an implementation of a Moen's tree layout algorithm.
Moen's algorithm attempts to create a tree with a triangular shape and place nodes somewhat simetrically. It is an extension of the well-known Reingold-Tilfold algorithm. It improved the older algorithm's ability to handle non-uniform sized nodes. Moen's trees are oriented horizontally. However, this implementation offers the posibility of choosing the orientation - vertical or horizontal. 

The Reingold-Tilfold  algorithm, and thus Moen's also,  starts with a bottom-up traversal of the tree. It calculates left and right subtrees of a tree and merges them. When doing that, it makes sure that the parents are centered above their children. Reignold-Tilfold's algorithm  was originally designed only for binary trees, but later extended to work for non-binary ones as well.  While Reignold-Tilfold's algorithm produces a compact tree layout, Moen's strives to make a tighter one. To accomplish that, it uses shapes represented by polyline structures. These shapes are initially formed for each leaf, so that the polyline goes around the node, but leaves the left side open. During the first phase of the algorithm's execution (bottom-up traversal), these shapes  are merged - shapes of parents are merged with shapes of children. In this implementation, we call the polylines contours. When merging contours, minimum horizontal/vertical offsets at which siblings can be placed with resepct to  their upper (left) sibling (depending of the layout's orientation) are calculated

Once the bottom-up traversal is finished,  calculation of offsets is finished as well. At that point, the tree is traversed again, but this time from top (root) to the bottom. During this second traversal, positions of the tree's nodes are set. Calculation of positions factors in the mentioned offsets, as well as the positions of the node's parent and the layout's  node and level distance properties.

Additionally, this implementation supports alignment of  nodes (top, center, bottom in case of the vertical layout and left, center, right in case of the horizontal layout). This is done through calculation of differences in sizes of nodes compared to the largest nodes on the same level, as well as the differences in sizes of their parents compared to the largest nodes on the parent level.

GtGradTreeLayout is  a superclass of GtGradHorizontalTreeLayout and GtGradVerticalTreeLayout classes and  contains generic tree layout methods and definitions of methods the two subclasses need to redefine.  Generally, the differences between the implementations of  the hozitonal and vertical variants  are really small, revolving around one using  or setting the x and the other y coordinates.

The tree algorithms can be  used to lay out inner elements of a Bloc element or a Mondrian view.


"
Class {
	#name : #GtGradAbstractTreeLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'levelDistance',
		'nodeDistance',
		'treesDistance',
		'nodesAlignment',
		'reverse',
		'separateSubtrees'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> calculateTreePositionCorrection: delta [
	self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY [
	self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> childOffsetBreadth: aChildElement [
	"Return the breadth of the offset of the given child element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> childOffsetLength: aChildElement [
	"Return the length of the offset of the given child element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #initialization }
GtGradAbstractTreeLayout >> forestClass [
	self subclassResponsibility
]

{ #category : #initialization }
GtGradAbstractTreeLayout >> formForestFrom: theNodes [
	^ self forestClass from: theNodes separateSubtrees: self separateSubtrees
]

{ #category : #initialization }
GtGradAbstractTreeLayout >> initialize [
	super initialize.
	
	levelDistance := 10.
	nodeDistance := 1.
	treesDistance := 30.
	reverse := false.
	separateSubtrees := false.
	nodesAlignment := GtGradTreeNodesRootAlignment new.
]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> levelDistance [
	<return: #Number>

	^ levelDistance 

]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> levelDistance: aNumber [
	levelDistance := aNumber
]

{ #category : #measure }
GtGradAbstractTreeLayout >> measureChildrenPositions: aParentLayoutNode [
	| aTreeForest aParentGraphNode |

	aParentGraphNode := aParentLayoutNode withGraphNodes withGraphEdges.

	aTreeForest := self formForestFrom: aParentGraphNode children.
	aTreeForest accept: (GtGradTreeLayoutPreparator on: self). 
	aTreeForest accept: (GtGradTreeLayoutCalculator on: self).
	
	aParentGraphNode children normalizePositions.
	^aTreeForest
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeBreadth: aTreeNode [
	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	self subclassResponsibility
]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> nodeDistance [
	<return: #Number>

	^ nodeDistance 

]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> nodeDistance: aNumber [
	nodeDistance := aNumber
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeLength: aTreeNode [
	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeOffsetBreadth: aNodeElement [
	"Return the breadth of the offset of the given node element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeOffsetLength: aNodeElement [
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> nodesAlignment [
	^ nodesAlignment
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> nodesAlignment: anObject [
	nodesAlignment := anObject
]

{ #category : #actions }
GtGradAbstractTreeLayout >> resetCache [
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> reverse [
	^ reverse
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> reverse: anObject [
	reverse := anObject
]

{ #category : #'api - geometry' }
GtGradAbstractTreeLayout >> reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds [
	self subclassResponsibility
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> separateSubtrees [
	^ separateSubtrees
]

{ #category : #accessing }
GtGradAbstractTreeLayout >> separateSubtrees: anObject [
	separateSubtrees := anObject
]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> treesDistance [
	<return: #Number>

	^ treesDistance
]

{ #category : #'api - accessing' }
GtGradAbstractTreeLayout >> treesDistance: aNumber [
	treesDistance := aNumber
]
