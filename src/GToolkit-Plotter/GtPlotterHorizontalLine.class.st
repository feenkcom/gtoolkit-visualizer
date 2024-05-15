Class {
	#name : #GtPlotterHorizontalLine,
	#superclass : #GtPlotterBarChartLine,
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
GtPlotterHorizontalLine >> newAnchor [
	^ super newAnchor
		inverseY;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalLine >> setAxisPercent: aNumber in: aBlPercentSideAnchor [
	aBlPercentSideAnchor xpercent: aNumber
]

{ #category : #accessing }
GtPlotterHorizontalLine >> setPercent: aNumber in: aBlPercentSideAnchor [
	aBlPercentSideAnchor ypercent: aNumber
]

{ #category : #accessing }
GtPlotterHorizontalLine >> transformRectangle: aRectangle [
	| e |
	e := parent list children first computeHorizontalScrollRange.
	^ Rectangle 
		origin: aRectangle origin 
		extent: (aRectangle width min: e) @ aRectangle height
]

{ #category : #accessing }
GtPlotterHorizontalLine >> valuePercent [
	^ barChart barHeightScale map: self dataValue
]
