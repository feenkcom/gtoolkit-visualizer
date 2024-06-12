Class {
	#name : #GtPlotterHorizontalProjectionTicksAndVerticalLabelsStencil,
	#superclass : #GtPlotterHorizontalProjectionTicksAndLabelsStencil,
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterHorizontalProjectionTicksAndVerticalLabelsStencil >> newAxisXTickLabelsElement [
	| axis |
	axis := super newAxisXTickLabelsElement.
	axis tickValues: scatterChart valuesX asSortedCollection.
	axis
		labelStyle: [:label | 
			label constraintsDo: [ :c |
				c accountTransformation.
			].
			label transformDo: [ :t |
				t rotateBy: -90
			]
		].
	^ axis
]
