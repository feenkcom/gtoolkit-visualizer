Class {
	#name : #GtPlotterLinearScale,
	#superclass : #GtPlotterContinuousScale,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'gt-extension' }
GtPlotterLinearScale >> gtTicksFor: aView [
	<gtView>
	
	^ aView list
		title: 'Ticks';
		priority: 5;
		items: [ self ticks asArray ]
]

{ #category : #'api - ticks' }
GtPlotterLinearScale >> ticks: anAmount [
	<return: #Array of: #Object>

	^ (GtPlotterNumberTicks
		from: self domain min
		to: self domain max
		count: anAmount) asArray
]

{ #category : #'operators-mapping' }
GtPlotterLinearScale >> transform: aDomainValue [
	^ aDomainValue
]
