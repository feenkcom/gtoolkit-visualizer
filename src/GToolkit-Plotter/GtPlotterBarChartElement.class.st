Class {
	#name : #GtPlotterBarChartElement,
	#superclass : #BlElement,
	#instVars : [
		'tickLabels',
		'bars',
		'lines'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterBarChartElement >> barsElement [
	<return: #BlElement>
	^ bars
]

{ #category : #accessing }
GtPlotterBarChartElement >> barsElement: anBlElement [
	bars := anBlElement.
	self addChild: bars
]

{ #category : #initialization }
GtPlotterBarChartElement >> initialize [
	super initialize.
	self 
		clipChildren: false;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
]

{ #category : #accessing }
GtPlotterBarChartElement >> lines [
	<return: #OrderedCollection>
	^ lines
]

{ #category : #accessing }
GtPlotterBarChartElement >> lines: aCollectionOfLineElements [
	lines := aCollectionOfLineElements.
	self addChildren: lines.
]

{ #category : #accessing }
GtPlotterBarChartElement >> tickLabelsElement [
	<return: #GtPlotterTickLabelsElement>
	^ tickLabels
]

{ #category : #accessing }
GtPlotterBarChartElement >> tickLabelsElement: aGtPlotterTickLabelsElement [
	tickLabels := aGtPlotterTickLabelsElement.
	self addChild: tickLabels.
]
