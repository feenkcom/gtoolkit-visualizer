Class {
	#name : #GtPlotterScatterFocusHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'scatterChart',
		'lines',
		'lineStencil',
		'unhighlightBlock',
		'hightlightBlock'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterScatterFocusHandler >> asElement [
	^ BlElement new
		constraintsDo: [:c | 
			c vertical matchParent.
			c horizontal matchParent];
		background: Color white;
		yourself
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> dataValueFrom: each [
	^ self subclassResponsibility
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> defaultHighlightBlock [
	^ [:anElement | | color |
		color := self hightlightColor.
		anElement class = BlTextElement 
			ifTrue: [  anElement textDo: [ :t | t foreground: color ] ] 
			ifFalse: [ anElement background: color ]
	]
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> defaultLineStencil [
	^ [ BlLineElement new
		border: (BlBorder builder 
			dashed;
			width: 1;
			paint: (Color blue alpha: 0.7);
			build);
		yourself ] asStencil
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> defaultUnhighlightBlock [
	^ [:anElement | | color |
		color := self unhightlightColor.
		anElement class = BlTextElement 
			ifTrue: [  anElement textDo: [ :t | t foreground: color ] ] 
			ifFalse: [ anElement background: color ]
	]
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> gtDemo: aView [
	<gtView>
	^ aView explicit
		title: 'Demo';
		priority: 1;
		stencil: [ self asElement]
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> hightlightBlock [
	^ hightlightBlock
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> hightlightBlock: anObject [
	hightlightBlock := anObject
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> hightlightColor [
	^ Color blue alpha: 0.8
]

{ #category : #initalization }
GtPlotterScatterFocusHandler >> initialize [
	super initialize.
	self 
		lineStencil: self defaultLineStencil;
		hightlightBlock: self defaultHighlightBlock;
		unhighlightBlock: self defaultUnhighlightBlock
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
	hightlightBlock value: tickElement.
	lines := scatterChart dots 
		select: [:each | (self dataValueFrom: each) = value ]
		thenCollect: [:each | 
			self newLineFrom: tickElement to: each
		].
	tickElement parent parent parent addChildren: lines
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> mouseLeaveEvent: aBlMouseLeaveEvent [
	unhighlightBlock value: aBlMouseLeaveEvent currentTarget.
	self removeLineMarkers
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> newHorizontalLineFrom: fromElement to: toElement [ 
	| line |
	line := lineStencil create.
	line 
		fromAnchor: (BlElementCenterRightAnchor  element: fromElement);
		toAnchor: (BlElementCenterLeftAnchor  element: toElement).
	^ line
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> newLineFrom: fromElement to: toElement [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> newVerticalLineFrom: fromElement to: toElement [
	| line |
	line := lineStencil create.
	
	line
		fromAnchor: (BlElementTopCenterAnchor  element: fromElement);
		toAnchor: (BlElementBottomCenterAnchor  element: toElement).
	^ line
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

{ #category : #accessing }
GtPlotterScatterFocusHandler >> unhighlightBlock [
	^ unhighlightBlock
]

{ #category : #accessing }
GtPlotterScatterFocusHandler >> unhighlightBlock: anObject [
	unhighlightBlock := anObject
]

{ #category : #defaults }
GtPlotterScatterFocusHandler >> unhightlightColor [
	^ Color gray
]
