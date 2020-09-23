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

{ #category : #'default attach points' }
GtGraphAbstractHorizontalTreeLayout >> defaultAttachPoint [
	self flag: 'attach point'.
	^ nil "RTHorizontalAttachPoint new"
]

{ #category : #reversing }
GtGraphAbstractHorizontalTreeLayout >> horizontallyReverse: elements [
	"Horizontally reverse the elements, as well as the attachpoints"

	super horizontallyReverse: elements.
	self inverseAttachPointIfNecessary
]

{ #category : #'initialize-release' }
GtGraphAbstractHorizontalTreeLayout >> initialize [
	super initialize.
	verticalGap := 3.
	horizontalGap := 20
]

{ #category : #reversing }
GtGraphAbstractHorizontalTreeLayout >> inverseAttachPoint [
	"Invert the attach point of all the considered edges. It is likely that all the attachpoint are the same, but we do not have a garanty"
	
	self flag: 'Attach point'.
	
	"| a |
	a := RTShorterHorizontalDistanceAttachPoint new.
	edges
		do: [ :edge | 
			edge shape attachPoint: a.
			edge updateFromTo ]
"
]

{ #category : #reversing }
GtGraphAbstractHorizontalTreeLayout >> inverseAttachPointIfNecessary [
	"Inverse the attach point if the user has not used #doNotAttachPoint"
]

{ #category : #'hook-private' }
GtGraphAbstractHorizontalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each | 
		childrenPosition := x + each measuredWidth + self horizontalGap.
		treeSize := each measuredHeight
			max: (self layout: (self computeChildrenFor: each) atPoint: childrenPosition @ y atLayer: aNumber + 1).
		middleOfTree := y + (treeSize / 2.0) - (each measuredHeight / 2.0).
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
			translator translateTopLeftOf: eachNode to: (cursor @ eachNode measuredBounds asRectangle top).
			max max: eachNode measuredWidth ].
		cursor := cursor + layerDepthSize + self horizontalGap ]
]
