Class {
	#name : #GtGradTreeLayoutCalculator,
	#superclass : #GtGradTreeLayouter,
	#instVars : [
		'origin'
	],
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradTreeLayoutCalculator >> initialize [
	super initialize.

	origin := 50.0@50.0
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> layout: aRootNode currentNode: aTreeNode start: aStartPoint bounds: bounds [
	| nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY firstChild alignmentCorrection |
	self separateSubtrees ifTrue: [ aTreeNode nodes isEmpty ifTrue: [ ^ self ] ].
	nodePosition := aTreeNode element position.

	alignmentCorrection := self layout nodesAlignment
			calculateCorrectionFor: aTreeNode
			aRootNode: aRootNode
			layout: layout.
	newNodePositionX := nodePosition x + aStartPoint x
			+ (layout nodeOffsetBreadth: aTreeNode) + alignmentCorrection x.
	newNodePositionY := nodePosition y + aStartPoint y
			+ (layout nodeOffsetLength: aTreeNode) + alignmentCorrection y.
	aTreeNode element position: newNodePositionX @ newNodePositionY.
	self
		updateNodeBounds: aTreeNode
		bounds: bounds
		positionX: newNodePositionX
		positionY: newNodePositionY.
	aTreeNode nodes isEmpty ifTrue: [ ^ self ].
	firstChild := aTreeNode nodes first.
	self
		layout: aTreeNode
		currentNode: firstChild
		start: newNodePositionX @ newNodePositionY - alignmentCorrection
		bounds: bounds.
	childrenOffsetX := newNodePositionX + (layout nodeOffsetBreadth: firstChild)
			- alignmentCorrection x.
	childrenOffsetY := newNodePositionY + (layout nodeOffsetLength: firstChild)
			- alignmentCorrection y.
	aTreeNode nodes
		allButFirstDo: [ :child | 
			self
				layout: aRootNode
				currentNode: child
				start: childrenOffsetX @ childrenOffsetY
				bounds: bounds.
			childrenOffsetX := childrenOffsetX + (layout childOffsetBreadth: child).
			childrenOffsetY := childrenOffsetY + (layout childOffsetLength: child) ]
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> moveNode: aTreeNode delta: delta [
	| nodePosition newNodePositionX newNodePositionY |
	nodePosition := aTreeNode element position.
	newNodePositionX := nodePosition x.
	newNodePositionY := nodePosition y.

	delta x > 0 ifTrue: [ newNodePositionX := newNodePositionX + delta x ].
	delta y > 0 ifTrue: [ newNodePositionY := newNodePositionY + delta y ].

	aTreeNode element position: newNodePositionX @ newNodePositionY.
	aTreeNode nodes
		select: [ :child | self layout separateSubtrees not or: [ child nodes isNotEmpty ] ]
		thenDo: [ :child | self moveNode: child delta: delta ]
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> reverse: aTreeNode rootPosition: theRootPosition bounds: bounds [
	| newNodePosition |
	newNodePosition := self layout
			reversedPositionOfNode: aTreeNode
			rootPosition: theRootPosition
			bounds: bounds.

	aTreeNode element position: newNodePosition.

	aTreeNode nodes
		do: [ :child | 
			self
				reverse: child
				rootPosition: theRootPosition
				bounds: bounds ]
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> updateNodeBounds: aTreeNode bounds: bounds positionX: positionX positionY: positionY [
	| nodeWidth nodeHeight  |
	
	nodeWidth := (aTreeNode width) / 2.
	nodeHeight := (aTreeNode height) /2.
	
	(positionX + nodeWidth) > (bounds right)
		ifTrue: [ bounds right: positionX + nodeWidth ].
		
	(positionX - nodeWidth) < (bounds left)
		ifTrue: [ bounds left: positionX - nodeWidth ].

	(positionY + nodeHeight) > (bounds bottom)
		ifTrue: [ bounds bottom: positionY + nodeHeight ].

	(positionY - nodeHeight) <  (bounds top)
		ifTrue: [ bounds top: positionY - nodeHeight ].

]

{ #category : #visiting }
GtGradTreeLayoutCalculator >> visitRootNode: aTreeNode [
	| bounds dx dy treePositionCorrection aPoint |
	bounds := BlBounds new.
	bounds left: SmallInteger maxVal asFloat.
	bounds top: SmallInteger maxVal asFloat.
	self
		layout: aTreeNode
		currentNode: aTreeNode
		start: origin
		bounds: bounds.

	dx := origin x - bounds left.
	dy := origin y - bounds top.
	treePositionCorrection := self layout calculateTreePositionCorrection: dx @ dy.

	(treePositionCorrection x > 0 or: [ treePositionCorrection y > 0 ])
		ifTrue: [ self moveNode: aTreeNode delta: treePositionCorrection ].

	self reverse
		ifTrue: [ self
				reverse: aTreeNode
				rootPosition: aTreeNode element position
				bounds: bounds ].
	aPoint := self layout
			calculateTreeStart: bounds
			nodesXCorrection: dx
			nodesYCorrection: dy
			startX: origin x
			startY: origin y.
	origin := aPoint
]
