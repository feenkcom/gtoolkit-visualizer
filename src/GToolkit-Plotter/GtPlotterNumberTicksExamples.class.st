Class {
	#name : #GtPlotterNumberTicksExamples,
	#superclass : #GtPlotterTicksExamples,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'instance creation' }
GtPlotterNumberTicksExamples >> from_0_to_10_count_10 [
	<gtExample>
	| theTicks |

	theTicks := GtPlotterNumberTicks from: 0 to: 10 count: 10.
	self assert: (theTicks asArray) equals: #(0 1 2 3 4 5 6 7 8 9 10).

	^ theTicks
]
