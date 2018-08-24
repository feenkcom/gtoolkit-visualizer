Class {
	#name : #GtGradTreeLayoutCalculator,
	#superclass : #GtGradTreeLayouter,
	#instVars : [
		'origin'
	],
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #initialization }
GtGradTreeLayoutCalculator >> initialize [
	super initialize.

	origin := 50@50
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> layout: aRootNode currentNode: aTreeNode start: aStartPoint bounds: bounds [
	|  nodePosition newNodePositionX newNodePositionY childrenOffsetX childrenOffsetY firstChild alignmentCorrection |
	nodePosition := aTreeNode element constraints gradTree
		computedPosition.
	alignmentCorrection := self layout nodesAlignment
		calculateCorrectionFor: aTreeNode
		aRootNode: aRootNode
		layout: layout.
	GtGradTreeLayoutCorrectionSignal new
		node: aTreeNode;
		alignmentCorrection: alignmentCorrection;
		emit.
	newNodePositionX := nodePosition x + aStartPoint x
		+ (self layout nodeOffsetBreadth: aTreeNode element)
		+ alignmentCorrection x.
	newNodePositionY := nodePosition y + aStartPoint y
		+ (self layout nodeOffsetLength: aTreeNode element)
		+ alignmentCorrection y.
	aTreeNode element constraints gradTree
		computedPosition: newNodePositionX @ newNodePositionY.
	self
		updateNodeBounds: aTreeNode
		bounds: bounds
		positionX: newNodePositionX
		positionY: newNodePositionY.
	aTreeNode nodes isNotEmpty
		ifFalse: [ ^ self ].
	firstChild := aTreeNode nodes first.
	self
		layout: aTreeNode
		currentNode: firstChild
		start: newNodePositionX @ newNodePositionY
		bounds: bounds.
	childrenOffsetX := newNodePositionX
		+ (self layout nodeOffsetBreadth: firstChild element).
	childrenOffsetY := newNodePositionY
		+ (self layout nodeOffsetLength: firstChild element).
	aTreeNode nodes
		do: [ :child | 
			child = firstChild
				ifFalse: [ self
							layout: aRootNode
							currentNode: child
							start: childrenOffsetX @ childrenOffsetY
							bounds: bounds.
					childrenOffsetX := childrenOffsetX
						+ (self layout childOffsetBreadth: child element).
					childrenOffsetY := childrenOffsetY
						+ (self layout childOffsetLength: child element) ] ]
]

{ #category : #visiting }
GtGradTreeLayoutCalculator >> moveNode: aTreeNode dx: dx dy: dy [
	| nodePosition  newNodePositionX newNodePositionY|

	nodePosition := aTreeNode element constraints gradTree computedPosition.
	newNodePositionX := nodePosition x.
	newNodePositionY := nodePosition y.
	dx > 0
		ifTrue: [ 
			newNodePositionX := (newNodePositionX + dx).
	 ].

	dy > 0
		ifTrue: [ 
			newNodePositionY := (newNodePositionY + dy).
	 ].
	
	aTreeNode element constraints gradTree computedPosition: newNodePositionX @ newNodePositionY .

	aTreeNode nodes do: [ :child |
		self moveNode: child dx: dx dy: dy.
	].
]

{ #category : #accessing }
GtGradTreeLayoutCalculator >> origin [
	<return: #Point>

	^ origin
]

{ #category : #accessing }
GtGradTreeLayoutCalculator >> origin: aPoint [
	origin := aPoint
]

{ #category : #'private - layout' }
GtGradTreeLayoutCalculator >> reverse: aTreeNode rootPosition: theRootPosition bounds: bounds [
	| newNodePosition |

	newNodePosition := self layout reversedPositionOfNode:
									aTreeNode rootPosition: theRootPosition
									bounds: bounds.

	aTreeNode element constraints gradTree computedPosition: newNodePosition.

	aTreeNode nodes do: [ :child |
		self reverse: child rootPosition: theRootPosition bounds: bounds
	].
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
	| bounds dx dy |

	GtGradProcessingTreeSignal new
		root: aTreeNode;
		emit.

	bounds := BlBounds new.
	bounds left: SmallInteger maxVal.
	bounds top: SmallInteger maxVal.
	self
		layout: aTreeNode
		currentNode: aTreeNode
		start: self origin
		bounds: bounds.

	dx := (self origin x) - (bounds left).
	dy := (self origin y) - (bounds top).
	
	self reverse
		ifTrue: [ 
			self reverse: aTreeNode
			     rootPosition: (aTreeNode element constraints gradTree computedPosition)
			     bounds: bounds
		].
	
	(dx > 0 or: [ dy > 0 ])
		ifTrue: [
			self moveNode: aTreeNode dx: dx dy: dy.
	 ].

	self origin: (self layout calculateTreeStart: bounds
									  nodesXCorrection: dx
									  nodesYCorrection: dy
									  startX: self origin x
									  startY: self origin y).


]
