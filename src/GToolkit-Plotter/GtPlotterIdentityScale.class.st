Class {
	#name : #GtPlotterIdentityScale,
	#superclass : #GtPlotterContinuousScale,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'operators-mapping' }
GtPlotterIdentityScale >> transform: aDomainValue [
	^ aDomainValue
]
