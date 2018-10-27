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
		constraintsDo: [ :c | c horizontal matchParent ];
		yourself.

	contents := BlElement new.
	contents
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c vertical exact: 100.
			c horizontal matchParent ];
	    background: Color white.

	contentLabel := BlTextElement new
		text: 'Label with multiple words' asRopedText;
		background: Color white;
		constraintsDo: [ :c | c horizontal matchParent ];
		yourself.
	contents addChild: contentLabel.

	grid := BlElement new.
	grid
		layout: (BlLinearLayout vertical cellSpacing: 2);
		padding: (BlInsets left: 2 right: 2);
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
