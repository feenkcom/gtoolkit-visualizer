Class {
	#name : #GtPlotterHorizontalLine,
	#superclass : #GtPlotterBarChartLine,
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
GtPlotterHorizontalLine >> fromAnchor [
	^ (BlSideAnchor element: self parent)
		barHeightScale: barChart barHeightScale;
		chartPadding: barChart chartPadding;
		xpercent: self min;
		y: self dataValue;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalLine >> toAnchor [
	^ (BlSideAnchor element: self parent)
		barHeightScale: barChart barHeightScale;
		chartPadding: barChart chartPadding;
		xpercent: self max;
		y: self dataValue;
		yourself
]
