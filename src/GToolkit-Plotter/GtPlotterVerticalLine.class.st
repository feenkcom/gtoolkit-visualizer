Class {
	#name : #GtPlotterVerticalLine,
	#superclass : #GtPlotterBarChartLine,
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
GtPlotterVerticalLine >> setAxisPercent: aNumber in: aBlPercentSideAnchor [
	aBlPercentSideAnchor ypercent: aNumber
]

{ #category : #accessing }
GtPlotterVerticalLine >> setPercent: aNumber in: aBlPercentSideAnchor [
	aBlPercentSideAnchor xpercent: aNumber
]

{ #category : #accessing }
GtPlotterVerticalLine >> transformScalableRectangle: aRectangle [
	| e |
	e := 0 @ (parent layout cellSpacing * 1.5 + 1).
	^ Rectangle
		origin: aRectangle origin + e
		corner: aRectangle corner - e
]

{ #category : #accessing }
GtPlotterVerticalLine >> transformScrollableRectangle: aRectangle [
	| e gap |
	e := parent list children first computeVerticalScrollRange.
	gap := barChart barGap/ 2+1.
	^ Rectangle 
		origin: aRectangle origin + (0@ gap)
		extent: aRectangle width @ ((aRectangle height min: e) - gap * 2)
]

{ #category : #accessing }
GtPlotterVerticalLine >> valuePercent [
	^ barChart barWidthScale map: self dataValue
]
