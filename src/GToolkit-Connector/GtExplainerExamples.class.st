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
	marker := self marker
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
						toAnchor: (BlNearestPositionTightCircleAnchor
								referenceElement: explanationElement
								relatedTo: marker);
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
		'An inspector pane is made of several parts. The ' asRopedText, 
		('header' asRopedText replacingAdornment: [ :aText :anEditorElement | 
			| aContainer aTextPieceElement |
			aContainer := BlElement new
				clipChildren: false;
				layout: BlLinearLayout vertical;
				look: (BrInteractiveCommonLook new 
					default: [ :aWidget | aWidget background: Color veryLightGray ];
					hovered: [ :aWidget | aWidget background: BrGlamorousColors primaryBorderColor ] );
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ].
			aContainer explainer isExplanation: true; model: #inspectorView.
			aTextPieceElement := (BrTextWordPieceStencilBuilder new
				text: aText
				start: (aText start - 1 max: 0)
				end: (aText start - 1 max: 0) + aText size) asElement.
			aContainer addEventHandler: (BlEventDelegator delegate: BrTextEditorRequest to: aTextPieceElement).
			aContainer addChildren: { aTextPieceElement } ]),
		' of the inspector shows the string representation of the inspected object.' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> marker [
	<gtExample>
	| circle expand collapse pulsation |
	circle := BlElement new
    size: 30@30;
    geometry: BlCircle new;
    border: (BlBorder paint: (BrGlamorousColors primaryBorderColor alpha: 0.7) width: 4).
    
	expand := (BlTransformAnimation scale: 1.5) absolute.
	collapse := (BlTransformAnimation scale: 1) absolute.

	pulsation := BlSequentialAnimation with: { expand . collapse }.
	pulsation beInfinite.

	circle addAnimation: pulsation.
	^ circle
]
