Class {
	#name : #GtPlotterTimeScale,
	#superclass : #GtPlotterContinuousScale,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'api - domain' }
GtPlotterTimeScale >> domainFrom: aStartDuration to: anEndDuration [
	domain := GtPlotterScaleTimeDomain from: aStartDuration to: anEndDuration
]

{ #category : #initialization }
GtPlotterTimeScale >> initialize [
	super initialize.
	
	domain := GtPlotterScaleTimeDomain from: (DateAndTime year: 2000 month: 1 day: 1) to: (DateAndTime year: 2000 month: 1 day: 2)
]

{ #category : #'api - ticks' }
GtPlotterTimeScale >> ticks: anAmount [
	<return: #Array of: #Object>

	^ (GtPlotterTimeTicks
		from: self domain min
		to: self domain max
		count: anAmount) asArray
]

{ #category : #'operators-mapping' }
GtPlotterTimeScale >> transform: aDomainValue [
	^ aDomainValue
]
