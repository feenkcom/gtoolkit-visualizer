Class {
	#name : #GtGraphAbstractVerticalTreeLayout,
	#superclass : #GtGraphAbstractRegularTreeLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphAbstractVerticalTreeLayout class >> isAbstract [
	^ self = GtGraphAbstractVerticalTreeLayout
]

{ #category : #'hook-private' }
GtGraphAbstractVerticalTreeLayout >> computeChildrenFor: aNode [
	self subclassResponsibility
]

{ #category : #'default attach points' }
GtGraphAbstractVerticalTreeLayout >> defaultAttachPoint [
	self flag: 'attach point'.
	
	^ nil "RTVerticalAttachPoint new"
]

{ #category : #'initialize-release' }
GtGraphAbstractVerticalTreeLayout >> initialize [
	super initialize.
	verticalGap := 20.
	horizontalGap := 3
]

{ #category : #reversing }
GtGraphAbstractVerticalTreeLayout >> inverseAttachPoint [
	"Invert the attach point of all the considered edges. It is likely that all the attachpoint are the same, but we do not have a garanty"

	self flag: 'Attach point'.

	"| a |
	a := RTShorterVerticalDistanceAttachPoint new.
	edges
		do: [ :edge | 
			edge shape attachPoint: a.
			edge updateFromTo ]
"
]

{ #category : #reversing }
GtGraphAbstractVerticalTreeLayout >> inverseAttachPointIfNecessary [
	"Inverse the attach point if the user has not used #doNotAttachPoint"
]

{ #category : #'hook-private' }
GtGraphAbstractVerticalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each | 
		childrenPosition := y + each measuredHeight + self verticalGap.
		treeSize := each measuredWidth
			max: (self layout: (self computeChildrenFor: each) atPoint: x @ childrenPosition atLayer: aNumber + 1).
		middleOfTree := x + (treeSize / 2.0) - (each measuredWidth / 2.0).
		translator translateTopLeftOf: each to: middleOfTree @ y.
		x := x + treeSize + self horizontalGap.
		self step ].
	^ x - aPoint x - self horizontalGap
]

{ #category : #accessing }
GtGraphAbstractVerticalTreeLayout >> levelDistance: aNumber [
	self verticalGap: aNumber
]

{ #category : #accessing }
GtGraphAbstractVerticalTreeLayout >> nodeDistance: aNumber [
	self horizontalGap: aNumber
]

{ #category : #private }
GtGraphAbstractVerticalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self topGap.
	nodesByLayer do: [:eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [:max :eachNode | 
			self translator translate: eachNode to: (eachNode position x @ cursor ).
			max max: eachNode measuredHeight ].
		cursor := cursor + layerDepthSize + self verticalGap ]
]

{ #category : #reversing }
GtGraphAbstractVerticalTreeLayout >> verticallyReverse: elements [
	"Vertically reverse the elements, as well as the attachpoints"

	super verticallyReverse: elements.
	self inverseAttachPointIfNecessary
]
