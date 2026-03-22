Class {
	#name : #GtGraphRectanglePackLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #private }
GtGraphRectanglePackLayoutExamples >> circlesData [
	^ Collection withAllSubclasses collect: [ :aClass | 
		aClass name  -> (30*( (aClass numberOfMethods max: 1) ln asInteger)) ]
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> circlesRaw [
	<gtExample>
	<return: #BlElement>
	| view data |
	data := self circlesData.

	view := BlElement new.
	data
		do: [ :model | 
			| node label |
			node := BlElement new
					geometry: BlEllipseGeometry new;
					size: model value asPoint;
					background: Color random.
			label := BlTextElement new.
			label
				text: (model key asRopedText
						attributes: {BlTextForegroundAttribute paint: Color black.
								BlFontSizeAttribute size: 10}).
			label
				constraintsDo: [ :constraints | 
					constraints frame horizontal alignCenter.
					constraints frame vertical alignCenter ].
			node addChild: label.
			node layout: BlFrameLayout new.

			view addChild: node ].

	view layout: GtGraphRectanglePackLayout new.
	view
		constraintsDo: [ :constraints | 
			constraints horizontal fitContent.
			constraints vertical fitContent.
			constraints padding: (BlInsets all: 10) ].

	self applyLayoutIn: view.

	^ view
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> powersOfTwo [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: GtGraphRectanglePackLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: ({2 -> 256.
				4 -> 128.
				8 -> 64.
				16 -> 32.
				32 -> 16.
				64 -> 8.
				128 -> 4.
				256 -> 2}
				flatCollect: [ :eachSize | 
					eachSize key
						timesCollect: [ BlElement new
								background: (Color gray alpha: 0.3);
								border: (BlBorder paint: Color white width: 1);
								size: eachSize value asPoint ] ])
]
