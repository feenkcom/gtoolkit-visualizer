Class {
	#name : #GtPlotterLinearScaleExamples,
	#superclass : #GtPlotterScaleExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'instance creation' }
GtPlotterLinearScaleExamples >> defaultLinearScale [
	<gtExample>
	<return: #GtPlotterLinearScale>
	| aScale |
	aScale := GtPlotterLinearScale new.

	self assert: aScale domain equals: GtPlotterScaleUnitDomain new.
	self assert: aScale range equals: GtPlotterScaleUnitRange new.

	self assert: (aScale map: -100) equals: -100.
	self assert: (aScale map: 0) equals: 0.
	self assert: (aScale map: 100) equals: 100.

	^ aScale
]

{ #category : #'instance creation' }
GtPlotterLinearScaleExamples >> linearScaleWithIntervalDomain [
	<gtExample>
	<return: #GtPlotterLinearScale>
	| aScale |
	aScale := self defaultLinearScale.
	aScale domain: (GtPlotterScaleMagnitudeDomain from: 0 to: 10).

	self assert: (aScale map: -20) equals: -2.
	self assert: (aScale map: -10) equals: -1.
	self assert: (aScale map: -5) equals: -0.5.
	self assert: (aScale map: 0) equals: 0.
	self assert: (aScale map: 5) equals: 0.5.
	self assert: (aScale map: 10) equals: 1.
	self assert: (aScale map: 20) equals: 2.

	^ aScale
]

{ #category : #'instance creation' }
GtPlotterLinearScaleExamples >> linearScaleWithIntervalDomainAndRange [
	<gtExample>
	<return: #GtPlotterLinearScale>
	| aScale |
	aScale := self defaultLinearScale.
	aScale domain: (GtPlotterScaleMagnitudeDomain from: 0 to: 10).
	aScale range: (GtPlotterScaleIntervalRange from: 0 to: 100).

	self assert: (aScale map: -20) equals: -200.
	self assert: (aScale map: -10) equals: -100.
	self assert: (aScale map: -5) equals: -50.
	self assert: (aScale map: -1) equals: -10.
	self assert: (aScale map: 0) equals: 0.
	self assert: (aScale map: 1) equals: 10.
	self assert: (aScale map: 5) equals: 50.
	self assert: (aScale map: 10) equals: 100.
	self assert: (aScale map: 20) equals: 200.

	^ aScale
]

{ #category : #'instance creation' }
GtPlotterLinearScaleExamples >> linearScaleWithIntervalRange [
	<gtExample>
	<return: #GtPlotterLinearScale>
	| aScale |
	aScale := self defaultLinearScale.
	aScale range: (GtPlotterScaleIntervalRange from: 0 to: 10).

	self assert: (aScale map: -20) equals: -200.
	self assert: (aScale map: -10) equals: -100.
	self assert: (aScale map: -5) equals: -50.
	self assert: (aScale map: -1) equals: -10.
	self assert: (aScale map: 0) equals: 0.
	self assert: (aScale map: 1) equals: 10.
	self assert: (aScale map: 5) equals: 50.
	self assert: (aScale map: 10) equals: 100.
	self assert: (aScale map: 20) equals: 200.

	^ aScale
]
