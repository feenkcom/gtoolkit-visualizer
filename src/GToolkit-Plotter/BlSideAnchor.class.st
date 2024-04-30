Class {
	#name : #BlSideAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#instVars : [
		'xpercent',
		'y',
		'barHeightScale',
		'chartPadding'
	],
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
BlSideAnchor >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
	
]

{ #category : #accessing }
BlSideAnchor >> chartPadding [
	^ chartPadding
]

{ #category : #accessing }
BlSideAnchor >> chartPadding: anObject [
	chartPadding := anObject
]

{ #category : #accessing }
BlSideAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a position of this anchor within a common parent"
	<return: #Point>
	| element bounds |
	element := self referenceElement.
	bounds := element bounds inParent: aCommonParent.
	
	^ self positionWithinBounds: (chartPadding inset: bounds)
]

{ #category : #accessing }
BlSideAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>
	| xpoint ypoint bounds |
	bounds := aParentBounds.
	xpoint := bounds origin x 
		interpolateTo: bounds corner x 
		at: xpercent.
		
	ypoint := bounds corner y
		interpolateTo: bounds origin y
		at: (barHeightScale map: y).
	^ xpoint @ ypoint
]

{ #category : #accessing }
BlSideAnchor >> xpercent [
	^ xpercent
]

{ #category : #accessing }
BlSideAnchor >> xpercent: anObject [
	xpercent := anObject
]

{ #category : #accessing }
BlSideAnchor >> y [
	^ y
]

{ #category : #accessing }
BlSideAnchor >> y: anObject [
	y := anObject
]
