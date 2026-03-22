Class {
	#name : #GtHeightExpandingElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Mondrian'
}

{ #category : #layout }
GtHeightExpandingElement >> onMeasure: anExtentMeasurementSpec [
	| maxHeight |    
    super onMeasure: anExtentMeasurementSpec.
    maxHeight := self children inject: 0 into: [ :max :aChild | aChild measuredHeight max: max ].
    self childrenDo: [ :aChild | aChild measure: (BlExtentMeasurementSpec exact: aChild measuredWidth @ maxHeight) ]
]
