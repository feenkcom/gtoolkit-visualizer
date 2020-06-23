Class {
	#name : #GtPlotterHorizontalSparklinesWithAxis,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'sparkleLines',
		'xAxis',
		'xTickFormat',
		'tickLabelFormat',
		'tickLabelColor',
		'amountOfTicks',
		'tickLabelLookStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Sparkline'
}

{ #category : #initialization }
GtPlotterHorizontalSparklinesWithAxis >> addSparkleline: aGtHorizontalSparkline [

	sparkleLines add: aGtHorizontalSparkline
]

{ #category : #initialization }
GtPlotterHorizontalSparklinesWithAxis >> create [ 
	| container lines |

	container := BlElement new
		layout: BlLinearLayout vertical;
		clipChildren: false;
		padding: (BlInsets right: 20);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	lines := BlElement new.
	sparkleLines do: [ :line |
		lines addChild: line create ].
	container addChild: lines.

	container addChild: (GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: xAxis;
		"padding: (BlInsets left: self barLabelWidth + self gridlineOffset);"
		constraintsDo: [ :c | c vertical fitContent ];
		labelFormat: xTickFormat;
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				look: (self tickLabelLook create foreground: self tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: self amountOfTicks).

]

{ #category : #initialization }
GtPlotterHorizontalSparklinesWithAxis >> initialize [ 

	super initialize.
	sparkleLines := OrderedCollection new.
	xTickFormat := [ :aTickObject | aTickObject printString ].

]

{ #category : #initialization }
GtPlotterHorizontalSparklinesWithAxis >> xAxisScale: aScale [ 

	xAxis := aScale
]
