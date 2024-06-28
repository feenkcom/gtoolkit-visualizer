Class {
	#name : #GtPlotterVerticalProjectionTicksAndLabelsAxisStencil,
	#superclass : #GtPlotterVerticalTicksAndLabelsAxisStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsAxisStencil >> addAxisYElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsAxisStencil >> newAxisYTickLabelsElement [
	^ super newAxisYTickLabelsElement
		tickValues: scatterChart valuesY asSortedCollection;
		yourself
]

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsAxisStencil >> newAxisYTicksElement [
	^ super newAxisYTicksElement
		tickValues: scatterChart valuesY;
		yourself
]
