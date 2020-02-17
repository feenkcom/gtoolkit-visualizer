Class {
	#name : #GtPlotterTimelineExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - scale' }
GtPlotterTimelineExamples >> scale [
	<gtExample>

	^ GtPlotterTimeScale new
		domainFrom: self versions first key year asYear to: (self versions last key year + 1) asYear
]

{ #category : #accessing }
GtPlotterTimelineExamples >> versions [
	<gtExample>

	^ { 
		(Date year: 2015 month: 10 day: 5) -> 'v1.0.0'.
		(Date year: 2015 month: 12 day: 1) -> 'v1.1.0'.
		(Date year: 2015 month: 12 day: 15) -> 'v1.1.1'.
		(Date year: 2016 month: 3 day: 10) -> 'v1.2.0'.
		(Date year: 2016 month: 3 day: 23) -> 'v1.2.1'.
		(Date year: 2016 month: 4 day: 7) -> 'v1.2.2'.
		(Date year: 2016 month: 4 day: 19) -> 'v1.2.3'.
		(Date year: 2016 month: 8 day: 3) -> 'v1.3.0'.
		(Date year: 2017 month: 9 day: 15) -> 'v1.4.0'.
		(Date year: 2017 month: 10 day: 6) -> 'v1.4.1'.
		(Date year: 2017 month: 11 day: 11) -> 'v1.4.2'.
		(Date year: 2018 month: 2 day: 28) -> 'v1.4.3'
	}
]
