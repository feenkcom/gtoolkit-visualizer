"
Used to compute line positions for instances of `GtPlotterBarCharLine`
"
Class {
	#name : #BlPercentSideAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#instVars : [
		'xpercent',
		'chartPadding',
		'ypercent',
		'inversedX',
		'inversedY',
		'transformer'
	],
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
BlPercentSideAnchor >> chartPadding [
	^ chartPadding
]

{ #category : #accessing }
BlPercentSideAnchor >> chartPadding: aBlInsets [
	chartPadding := aBlInsets
]

{ #category : #accessing }
BlPercentSideAnchor >> initialize [
	super initialize.
	transformer := [:bounds | bounds ].
	chartPadding := BlInsets empty.
	xpercent := ypercent := 0.
	inversedX := inversedY := false.
]

{ #category : #accessing }
BlPercentSideAnchor >> inverseX [
	inversedX := true
]

{ #category : #accessing }
BlPercentSideAnchor >> inverseY [
	inversedY:=true
]

{ #category : #accessing }
BlPercentSideAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a position of this anchor within a common parent"
	<return: #Point>
	| element bounds |
	element := self referenceElement.
	bounds := element bounds inParent: aCommonParent.
	bounds := chartPadding inset: bounds.
	^ self positionWithinBounds: (transformer value: bounds)
]

{ #category : #accessing }
BlPercentSideAnchor >> positionWithinBounds: aRectangle [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>
	| xpoint ypoint bounds x0 x1 y0 y1|
	bounds := aRectangle.
	inversedX ifTrue: [
		x0 := bounds corner.
		x1 := bounds origin.
	] ifFalse: [
		x0 := bounds origin.
		x1 := bounds corner.
	].
	inversedY ifTrue: [
		y0 := bounds corner.
		y1 := bounds origin.
	] ifFalse: [
		y0 := bounds origin.
		y1 := bounds corner.
	].
	xpoint := x0 x interpolateTo: x1 x at: xpercent.
	ypoint := y0 y interpolateTo: y1 y at: ypercent.
	
	^ xpoint @ ypoint
]

{ #category : #accessing }
BlPercentSideAnchor >> transformer: aBlock [
	transformer := aBlock
]

{ #category : #accessing }
BlPercentSideAnchor >> xpercent [
	^ xpercent
]

{ #category : #accessing }
BlPercentSideAnchor >> xpercent: anObject [
	xpercent := anObject
]

{ #category : #accessing }
BlPercentSideAnchor >> ypercent [
	^ ypercent
]

{ #category : #accessing }
BlPercentSideAnchor >> ypercent: anObject [
	ypercent := anObject
]
