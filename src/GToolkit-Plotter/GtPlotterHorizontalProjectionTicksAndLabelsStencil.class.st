Class {
	#name : #GtPlotterHorizontalProjectionTicksAndLabelsStencil,
	#superclass : #GtPlotterHorizontalTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsStencil >> newAxisXTickLabelsElement [
	^ super newAxisXTickLabelsElement
		tickValues: scatterChart valuesX;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsStencil >> newAxisXTicksElement [
	^ super newAxisXTicksElement
		tickValues: scatterChart valuesX;
		yourself
]
