Class {
	#name : #GtPlotterVerticalProjectionTicksAndLabelsStencil,
	#superclass : #GtPlotterVerticalTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsStencil >> addAxisYElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsStencil >> newAxisYTickLabelsElement [
	^ super newAxisYTickLabelsElement
		tickValues: scatterChart valuesY asSortedCollection;
		yourself
]

{ #category : #accessing }
GtPlotterVerticalProjectionTicksAndLabelsStencil >> newAxisYTicksElement [
	^ super newAxisYTicksElement
		tickValues: scatterChart valuesY;
		yourself
]
