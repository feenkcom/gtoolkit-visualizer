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
GtPlotterHorizontalLine >> transformScalableRectangle: aRectangle [
	| e |
	e := parent layout cellSpacing * 1.5 + 1@ 0.
	^ Rectangle
		origin: aRectangle origin + e
		corner: aRectangle corner - e
]

{ #category : #accessing }
GtPlotterHorizontalLine >> transformScrollableRectangle: aRectangle [
	| e gap |
	e := parent list children first computeHorizontalScrollRange.
	gap := barChart barGap/ 2+1.
	^ Rectangle
		origin: aRectangle origin + (gap @ 0)
		extent: (aRectangle width min: e) - (gap * 2) @ aRectangle height
]

{ #category : #accessing }
GtPlotterHorizontalLine >> valuePercent [
	^ barChart barHeightScale map: self dataValue
]
