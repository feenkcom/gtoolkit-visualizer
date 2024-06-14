Class {
	#name : #GtPlotterScatterFocusHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'scatterChart',
		'lines',
		'lineStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusHandler >> dataValueFrom: each [
	^ self subclassResponsibility
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> defaultLineStencil [
	^ [ BlLineElement new
		border: (BlBorder builder 
			dashed;
			width: 1;
			paint: (Color gray alpha: 0.7);
			build);
		yourself ] asStencil
]

{ #category : #initalization }
GtPlotterScatterFocusHandler >> initialize [
	super initialize.
	self lineStencil: self defaultLineStencil
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> lineStencil [
	<return: #BrStencil>
	^ lineStencil
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> lineStencil: aBrStencil [
	lineStencil := aBrStencil asStencil
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> mouseEnterEvent: aBlMouseEnterEvent [
	| value tickElement |
	self removeLineMarkers.
	tickElement := aBlMouseEnterEvent currentTarget.
	value := tickElement userData at: #originalValue.
	
	lines := scatterChart dots 
		select: [:each | (self dataValueFrom: each) = value ]
		thenCollect: [:each | 
			self newLineFrom: tickElement to: each
		].
	tickElement parent parent parent addChildren: lines.
	
	
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> mouseLeaveEvent: aBlMouseLeaveEvent [
	self removeLineMarkers
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> newLineFrom: fromElement to: toElement [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> removeLineMarkers [
	lines ifNil: [ ^ self ].
	lines do: [:each | each removeFromParent ].
	lines := nil.
	
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> scatterChart [
	^ scatterChart
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> scatterChart: aGtPlotterScatterChart [
	scatterChart := aGtPlotterScatterChart
]
