"
I exemplify {{gtClass:GtPlotterVerticalTimeline}}.
#Example
{{gtExample:GtPlotterVerticalTimelineExamples>>exampleVersions|previewExpanded=true|codeExpanded=false}}
"
Class {
	#name : #GtPlotterVerticalTimelineExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'examples - timeline' }
GtPlotterVerticalTimelineExamples >> exampleVersions [
	<gtExample>
	<return: #GtPlotter>
	| aPlotter |
	aPlotter := GtPlotter new.
	aPlotter verticalTimeline
		withProjectionAxis;
		timelineData: #key;
		projectionData: #value;
		timelineFrom: 2015 asYear to: 2019 asYear;
		with: {(Date
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
					day: 28) -> 'v1.4.3'}.
	^ aPlotter
]
