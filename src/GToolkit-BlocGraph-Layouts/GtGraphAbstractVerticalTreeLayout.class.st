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

{ #category : #'initialize-release' }
GtGraphAbstractVerticalTreeLayout >> initialize [
	super initialize.
	verticalGap := 20.
	horizontalGap := 3
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
		childrenPosition := y + each height + self verticalGap.
		treeSize := each width
			max: (self layout: (self computeChildrenFor: each) atPoint: x @ childrenPosition atLayer: aNumber + 1).
		middleOfTree := x + (treeSize / 2.0) - (each width / 2.0).
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
			max max: eachNode height ].
		cursor := cursor + layerDepthSize + self verticalGap ]
]
