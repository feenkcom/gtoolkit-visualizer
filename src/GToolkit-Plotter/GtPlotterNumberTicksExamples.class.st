"
I exemplify {{gtClass:GtPlotterNumberTicks}}.
#Example
{{gtExample:GtPlotterNumberTicksExamples>>#from_0_to_10_count_10|codeExpanded=false|previewExpanded=true|previewHeight=150}}
"
Class {
	#name : #GtPlotterNumberTicksExamples,
	#superclass : #GtPlotterTicksExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'instance creation' }
GtPlotterNumberTicksExamples >> from_0_to_10_count_10 [
	<gtExample>
	<return: #GtPlotterNumberTicks>
	| theTicks |
	theTicks := GtPlotterNumberTicks
			from: 0
			to: 10
			count: 10.
	self assert: theTicks asArray equals: #(0 1 2 3 4 5 6 7 8 9 10).

	^ theTicks
]

{ #category : #'instance creation' }
GtPlotterNumberTicksExamples >> from_20_to_40_count_5 [
	<gtExample>
	<return: #GtPlotterNumberTicks>
	| theTicks |
	theTicks := GtPlotterNumberTicks
			from: 20
			to: 40
			count: 5.
	self assert: theTicks asArray equals: #(20 25 30 35 40).

	^ theTicks
]
