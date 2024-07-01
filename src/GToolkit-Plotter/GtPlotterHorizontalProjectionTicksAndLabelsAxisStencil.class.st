Class {
	#name : #GtPlotterHorizontalProjectionTicksAndLabelsAxisStencil,
	#superclass : #GtPlotterHorizontalTicksAndLabelsAxisStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsAxisStencil >> addAxisXLineElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsAxisStencil >> newAxisXTickLabelsElement [
	^ super newAxisXTickLabelsElement
		tickValues: scatterChart valuesX asSortedCollection;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsAxisStencil >> newAxisXTicksElement [
	^ super newAxisXTicksElement
		tickValues: scatterChart valuesX;
		yourself
]
