Class {
	#name : #GtPlotterProjectionVerticalTickLabelsElement,
	#superclass : #GtPlotterVerticalTickLabelsElement,
	#instVars : [
		'values'
	],
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #accessing }
GtPlotterProjectionVerticalTickLabelsElement >> ticks [
	^ values ifNil: [ #() ]
]

{ #category : #accessing }
GtPlotterProjectionVerticalTickLabelsElement >> values [
	^ values
]

{ #category : #accessing }
GtPlotterProjectionVerticalTickLabelsElement >> values: aCollectionOfValues [
	values := aCollectionOfValues asSortedCollection
]
