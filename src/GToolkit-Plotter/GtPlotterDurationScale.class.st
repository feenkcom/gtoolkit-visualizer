Class {
	#name : #GtPlotterDurationScale,
	#superclass : #GtPlotterContinuousScale,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'api - domain' }
GtPlotterDurationScale >> domainFrom: aStartDuration to: anEndDuration [
	domain := GtPlotterScaleMagnitudeDomain from: aStartDuration to: anEndDuration
]

{ #category : #initialization }
GtPlotterDurationScale >> initialize [
	super initialize.
	
	domain := GtPlotterScaleMagnitudeDomain from: 0 days to: 1 day
]

{ #category : #'api - ticks' }
GtPlotterDurationScale >> ticks: anAmount [
	<return: #Array of: #Object>

	^ (GtPlotterDurationTicks
		from: self domain min
		to: self domain max
		count: anAmount) asArray
]

{ #category : #'operators-mapping' }
GtPlotterDurationScale >> transform: aDomainValue [
	^ aDomainValue
]

{ #category : #'api - ticks' }
GtPlotterDurationScale >> valuedTick: aTickObject [
	^ aTickObject asDuration
]
