Class {
	#name : #BlPercentSideAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#instVars : [
		'xpercent',
		'chartPadding',
		'ypercent'
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
BlPercentSideAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a position of this anchor within a common parent"
	<return: #Point>
	| element bounds |
	element := self referenceElement.
	bounds := element bounds inParent: aCommonParent.
	
	^ self positionWithinBounds: (chartPadding inset: bounds)
]

{ #category : #accessing }
BlPercentSideAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>
	| xpoint ypoint bounds |
	bounds := aParentBounds.
	xpoint := bounds origin x 
		interpolateTo: bounds corner x 
		at: xpercent.
		
	ypoint := bounds corner y
		interpolateTo: bounds origin y
		at: ypercent.
	^ xpoint @ ypoint
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
