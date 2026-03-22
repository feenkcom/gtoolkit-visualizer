Class {
	#name : #GtPlotterTimeScaleExamples,
	#superclass : #GtPlotterScaleExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'instance creation' }
GtPlotterTimeScaleExamples >> defaultTimeScale [
	<gtExample>
	<return: #GtPlotterTimeScale>
	| aScale |
	aScale := GtPlotterTimeScale new.

	self
		assert: aScale domain
		equals: (GtPlotterScaleTimeDomain
				from: (DateAndTime
						year: 2000
						month: 1
						day: 1)
				to: (DateAndTime
						year: 2000
						month: 1
						day: 2)).
	self assert: aScale range equals: GtPlotterScaleUnitRange new.

	self
		assert: (aScale
				map: (DateAndTime
						year: 2000
						month: 1
						day: 1))
		equals: 0.
	self
		assert: (aScale
				map: (DateAndTime
						year: 2000
						month: 1
						day: 2))
		equals: 1.

	^ aScale
]

{ #category : #'instance creation' }
GtPlotterTimeScaleExamples >> everyWeek [
	<gtExample>
	<return: #GtPlotterTimeScale>
	| aScale |
	aScale := GtPlotterTimeScale new.
	aScale
		domainFrom: (DateAndTime
				year: 2000
				month: 1
				day: 1)
		to: (DateAndTime
				year: 2000
				month: 3
				day: 18).

	self
		assert: (aScale
				map: (DateAndTime
						year: 2000
						month: 1
						day: 1))
		equals: 0.
	self
		assert: (aScale
				map: (DateAndTime
						year: 2000
						month: 3
						day: 18))
		equals: 1.

	^ aScale
]
