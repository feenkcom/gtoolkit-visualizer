Class {
	#name : #GtGraphAbstractHorizontalTreeLayout,
	#superclass : #GtGraphAbstractRegularTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphAbstractHorizontalTreeLayout class >> isAbstract [
	^ self = GtGraphAbstractHorizontalTreeLayout
]

{ #category : #'hook-private' }
GtGraphAbstractHorizontalTreeLayout >> computeChildrenFor: aNode [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
GtGraphAbstractHorizontalTreeLayout >> initialize [
	super initialize.

	verticalGap := 3.
	horizontalGap := 20
]

{ #category : #'hook-private' }
GtGraphAbstractHorizontalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |

	aNodeCollection
		ifEmpty: [ ^ 0 ].

	x := aPoint x.
	y := aPoint y.

	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each | 
		childrenPosition := x + each width + self horizontalGap.
		treeSize := each height
			max: (self layout: (self computeChildrenFor: each) atPoint: childrenPosition @ y atLayer: aNumber + 1).
		middleOfTree := y + (treeSize / 2.0) - (each height / 2.0).
		translator translateTopLeftOf: each to: (x @ middleOfTree).
		y := y + treeSize + self verticalGap.
		self step ].
	^ y - aPoint y - self verticalGap
]

{ #category : #accessing }
GtGraphAbstractHorizontalTreeLayout >> levelDistance: aNumber [
	self horizontalGap: aNumber
]

{ #category : #accessing }
GtGraphAbstractHorizontalTreeLayout >> nodeDistance: aNumber [
	self verticalGap: aNumber
]

{ #category : #private }
GtGraphAbstractHorizontalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self leftGap.
	nodesByLayer do: [ :eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [ :max :eachNode | 
			translator translateTopLeftOf: eachNode to: (cursor @ eachNode position y).
			max max: eachNode width ].
		cursor := cursor + layerDepthSize + self horizontalGap ]
]
