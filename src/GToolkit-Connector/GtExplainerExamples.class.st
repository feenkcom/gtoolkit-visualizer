Class {
	#name : #GtExplainerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Connector'
}

{ #category : #example }
GtExplainerExamples >> example [
	<gtExample>
	| container subject target marker editor line |
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
	subject := (42 gtViewsFor: GtPhlowView empty) asElementDo: [ :e | e ].
	subject forceLayout.
	target := subject phlow firstChildWithView.
	marker := BlElement new
		size: 30 @ 30;
		geometry: BlEllipse new;
		background: (BrGlamorousColors primaryBorderColor alpha: 0.7);
		constraintsDo: [ :c | c ignoreByLayout ];
		relocate: (container globalPointToLocal: (target localPointToGlobal: 10 @ 10)).
	marker explainer
		isTarget: true;
		model: #inspectorView.
	marker
		when: BlMouseEnterEvent
			do: [ :e | 
			self inform: 'enter'.
			marker explainer firstExplanationHolderParent explainer
				firstExplanationChildWithModel: marker explainer model
				do: [ :explanationElement | 
					line := BlLineElement new
						fromAnchor:
							(BlNearestPositionTightCircleAnchor
								referenceElement: marker
								relatedTo: explanationElement);
						toAnchor: (BlElementCenterAnchor element: explanationElement);
						zIndex: 10;
						border: (BlBorder paint: (BrGlamorousColors primaryBorderColor alpha: 0.7) width: 2);
						constraintsDo: [ :c | c ignoreByLayout ];
						yourself.
					container addChild: line ] ];
		when: BlMouseLeaveEvent
			do: [ :e | 
			self inform: 'leave'.
			line ifNotNil: [ line removeFromParent ] ].
	container addChild: subject.
	container addChild: marker.
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self explanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	^ container
]

{ #category : #example }
GtExplainerExamples >> explanationText [
	<gtExample>
	| text |
	text := 
		'This is the ' asRopedText, 
		('header' asRopedText attributes: {
			BlTextUnderlineAttribute new paint: (BrGlamorousColors primaryBorderColor alpha: 0.7).
			GtButtonAttribute new
				beAppend;
				stencil: [ 
					| button |
					button := BrButton new
						background: (BrGlamorousColors primaryBorderColor alpha: 0.7);
						geometry: BlEllipse new;
						size: 10 @ 10.
					button explainer isExplanation: true; model: #inspectorView.
					button
						when: BlMouseEnterEvent do:
								[ :anEvent |  ];
						when: BlMouseLeaveEvent
							do: [ :anEvent |  ] ]}),
		' of the inspector.' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color gray
]
