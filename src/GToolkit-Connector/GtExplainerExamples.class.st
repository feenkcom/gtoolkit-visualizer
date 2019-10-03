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
		look: (BrInteractiveCommonLook new 
			default: [ :aWidget | 
				line ifNotNil: [ line removeFromParent ].
				aWidget background: Color transparent ];
			hovered: [ :aWidget | 
				self inform: 'enter'.
				aWidget background: (BrGlamorousColors primaryBorderColor alpha: 0.3).
				aWidget explainer firstExplanationHolderParent explainer
					firstExplanationChildWithModel: aWidget explainer model
					do: [ :explanationElement | 
						line := BlLineElement new
							fromAnchor: (BlNearestPositionTightCircleAnchor
									referenceElement: aWidget
									relatedTo: explanationElement);
							toAnchor: (BlNearestPositionTightCircleAnchor
									referenceElement: explanationElement
									relatedTo: aWidget);
							zIndex: 10;
							border: (BlBorder paint: (BrGlamorousColors primaryBorderColor alpha: 0.7) width: 2);
							constraintsDo: [ :c | c ignoreByLayout ];
							yourself.
						aWidget 
							firstCommonParent: explanationElement
							ifFound: [ :aCommonParent | 
								aCommonParent addChild: line ]
							ifNone: [  ] ] ] ).
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
	| text line |
	text := 
		'An inspector pane is made of several parts. The ' asRopedText, 
		('header' asRopedText replacingAdornment: [ :aText :anEditorElement | 
			| aContainer aTextPieceElement |
			aContainer := BrButton new
				clipChildren: false;
				layout: BlLinearLayout vertical;
				geometry: (BlRectangle cornerRadius: 4);
				padding: (BlInsets left: 4 right: 4);
				margin: (BlInsets all: 0);
				look: (BrInteractiveCommonLook new 
					default: [ :aWidget | 
						line ifNotNil: [ line removeFromParent ].
						aWidget 
							border: (BlBorder paint: BrGlamorousColors primaryBorderColor);
							background: Color transparent ];
					hovered: [ :aWidget | 
						aWidget background: (BrGlamorousColors primaryBorderColor alpha: 0.3).
						aWidget explainer firstExplanationHolderParent explainer
							firstTargetChildWithModel: aWidget explainer model
							do: [ :explanationTargetElement | 
								self inform: 'target found'.
								line := BlLineElement new
									fromAnchor:
										(BlNearestPositionTightCircleAnchor
											referenceElement: aWidget
											relatedTo: explanationTargetElement);
									toAnchor: (BlNearestPositionTightCircleAnchor
											referenceElement: explanationTargetElement
											relatedTo: aWidget);
									zIndex: 10;
									border: (BlBorder paint: (BrGlamorousColors primaryBorderColor alpha: 0.7) width: 2);
									constraintsDo: [ :c | c ignoreByLayout ];
									yourself.
								aWidget 
									firstCommonParent: explanationTargetElement
									ifFound: [ :aCommonParent | 

										aCommonParent addChild: line ]
									ifNone: [  ] ]  ] );
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
	circle := BrButton new
		size: 30@30;
		geometry: BlCircle new;
		border: (BlBorder paint: (BrGlamorousColors primaryBorderColor alpha: 0.7) width: 4);
		background: (BrGlamorousColors primaryBorderColor alpha: 0.3).
    
"	expand := (BlTransformAnimation scale: 1.5) absolute.
	collapse := (BlTransformAnimation scale: 1) absolute.

	pulsation := BlSequentialAnimation with: { expand . collapse }.
	pulsation beInfinite.

	circle addAnimation: pulsation.
"	^ circle
]
