Class {
	#name : #GtPlotterLinearScale,
	#superclass : #GtPlotterContinuousScale,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'api - domain' }
GtPlotterLinearScale >> domainFrom: aStartMagnitude to: anEndMagnitude [
	domain := GtPlotterScaleMagnitudeDomain from: aStartMagnitude to: anEndMagnitude
]

{ #category : #'api - range' }
GtPlotterLinearScale >> rangeFrom: aStartMagnitude to: anEndMagnitude [
	range := GtPlotterScaleIntervalRange from: aStartMagnitude to: anEndMagnitude
]

{ #category : #'api - ticks' }
GtPlotterLinearScale >> ticks: anAmount [
	<return: #Array of: #Object>

	^ (GtPlotterNumberTicks
		from: self domain min
		to: self domain max
		count: anAmount) asArray
]

{ #category : #'operators-mapping' }
GtPlotterLinearScale >> transform: aDomainValue [
	^ aDomainValue
]
