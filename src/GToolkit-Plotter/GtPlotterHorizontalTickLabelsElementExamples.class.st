Class {
	#name : #GtPlotterHorizontalTickLabelsElementExamples,
	#superclass : #GtPlotterScaleBasedElementExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'examples - time' }
GtPlotterHorizontalTickLabelsElementExamples >> timeEveryFewMonths [
	<gtExample>
	<return: #GtPlotterHorizontalTickLabelsElement>
	| aScale theLabels |
	aScale := GtPlotterTimeScale new.
	aScale
		domainFrom: (DateAndTime
				year: 2017
				month: 06
				day: 27)
		to: (DateAndTime
				year: 2021
				month: 11
				day: 16).
	aScale
		tickFormat: [ :eachDateAndTime | eachDateAndTime monthAbbreviation , ' ' , eachDateAndTime year asString ].

	theLabels := GtPlotterHorizontalTickLabelsElement new.
	theLabels scale: aScale.
	theLabels labels: 10.

	^ theLabels
]
