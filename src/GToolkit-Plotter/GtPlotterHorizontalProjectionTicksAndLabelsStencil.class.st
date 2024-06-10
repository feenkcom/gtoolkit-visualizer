Class {
	#name : #GtPlotterHorizontalProjectionTicksAndLabelsStencil,
	#superclass : #GtPlotterHorizontalTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsStencil >> addAxisXLineElementOn: aContainer [
]

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsStencil >> newAxisXTickLabelsElement [
	^ super newAxisXTickLabelsElement
		labelStyle: [:label | 
			label constraintsDo: [ :c |
				c accountTransformation
			].
			label transformDo: [ :t |
				t rotateBy: -45
			]
		];
		tickValues: scatterChart valuesX asSortedCollection;
		yourself
]

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndLabelsStencil >> newAxisXTicksElement [
	^ super newAxisXTicksElement
		tickValues: scatterChart valuesX;
		yourself
]
