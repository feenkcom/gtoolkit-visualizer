"
My subclasses exemplify timeline charts of the following data: {{gtExample:GtPlotterRawTimelineExamples>>#versions|codeExpanded=false|previewExpanded=true}}
Charts use the following scale: {{gtExample:GtPlotterRawTimelineExamples>>#scale|codeExpanded=false|previewExpanded=true}}
See my subclasses for more example: {{gtClass:GtPlotterRawTimelineExamples|expanded=true|show=#gtSubclassesFor:|height=200}}
"
Class {
	#name : #GtPlotterRawTimelineExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Example - Charts'
}

{ #category : #'examples - scale' }
GtPlotterRawTimelineExamples >> scale [
	<gtExample>
	<return: #GtPlotterTimeScale>
	^ GtPlotterTimeScale new
		domainFrom: self versions first key year asYear
		to: (self versions last key year + 1) asYear
]

{ #category : #accessing }
GtPlotterRawTimelineExamples >> versions [
	<gtExample>
	<return: #Array>
	^ {(Date
			year: 2015
			month: 10
			day: 5) -> 'v1.0.0'.
		(Date
			year: 2015
			month: 12
			day: 1) -> 'v1.1.0'.
		(Date
			year: 2015
			month: 12
			day: 15) -> 'v1.1.1'.
		(Date
			year: 2016
			month: 3
			day: 10) -> 'v1.2.0'.
		(Date
			year: 2016
			month: 3
			day: 23) -> 'v1.2.1'.
		(Date
			year: 2016
			month: 4
			day: 7) -> 'v1.2.2'.
		(Date
			year: 2016
			month: 4
			day: 19) -> 'v1.2.3'.
		(Date
			year: 2016
			month: 8
			day: 3) -> 'v1.3.0'.
		(Date
			year: 2017
			month: 9
			day: 15) -> 'v1.4.0'.
		(Date
			year: 2017
			month: 10
			day: 6) -> 'v1.4.1'.
		(Date
			year: 2017
			month: 11
			day: 11) -> 'v1.4.2'.
		(Date
			year: 2018
			month: 2
			day: 28) -> 'v1.4.3'}
]
