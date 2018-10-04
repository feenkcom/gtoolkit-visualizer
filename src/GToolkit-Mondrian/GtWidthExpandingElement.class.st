"
I am a special element that can grow horizontally with the children regardless of the layout.
"
Class {
	#name : #GtWidthExpandingElement,
	#superclass : #BlElement,
	#category : 'GToolkit-Mondrian'
}

{ #category : #example }
GtWidthExpandingElement class >> example [
	<gtExample>
	| label contents contentLabel grid |
	label := BlTextElement new
            text: 'Name' asRopedText;
            background: Color white;
            yourself.
	contents := BlElement new.
	contents 
	    layout: BlLinearLayout horizontal;
	   constraintsDo: [ :c |
	        c vertical exact: 100.
	        c horizontal fitContent ];
	    background: Color white.
	contentLabel := BlTextElement new
	            text: 'Label with multiple words' asRopedText;
	            background: Color white;
	            yourself.
	contents addChild: contentLabel.
	grid := GtWidthExpandingElement new.
	grid 
	    layout: (BlGridLayout vertical cellSpacing: 2);
	    constraintsDo: [ :c |
	        c vertical fitContent.
	        c horizontal fitContent ];
	    background: Color black.
	grid addChildren: { label . contents }.
	^ grid
]

{ #category : #layout }
GtWidthExpandingElement >> onMeasure: anExtentMeasurementSpec [
	| maxWidth |
	
	super onMeasure: anExtentMeasurementSpec.
	
	maxWidth := self children inject: 0 into: [ :max :aChild | aChild measuredWidth max: max ].
	
	self childrenDo: [ :aChild |		
			aChild measure: (BlExtentMeasurementSpec exact: maxWidth @ aChild measuredHeight) ]
]
