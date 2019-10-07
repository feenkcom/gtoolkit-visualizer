Class {
	#name : #GtExplainerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Connector'
}

{ #category : #example }
GtExplainerExamples >> inspectorExplanationText [
	<gtExample>
	| text |
	text := 
		'An inspector is made of several parts.

The ' asRopedText, 
		('header' asRopedText glamorousExplanationFor: #header),
		' shows the string representation of the inspected object, and it offers ' asRopedText,
		('actions' asRopedText glamorousExplanationFor: #action),
		' that are specific to the object, such as inspecting the object again.

The inspector also shows multiple ' asRopedText,
		('views' asRopedText glamorousExplanationFor: #view),
		' that are specific to the object. Every object is allowed to specify such custom views.' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> inspectorOnOneObjectExample [
	<gtExample>
	| container inspectorContainer subject inspectorHeader editor inspectorView inspectorActionButton inspectorActionMarker |
	inspectorContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		background: Color white;
		margin: (BlInsets all: 10);
		look: BrShadowLook.
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
	subject := (42 gtViewsFor: GtPhlowView empty) asElementDo: [ :e | e ].
	subject forceLayout.
	inspectorHeader := subject phlow firstChildWithView.
	inspectorView := inspectorHeader viewContentElement phlow
		firstChildWithView.
	inspectorActionButton := subject phlow firstChildWithAction.
	inspectorContainer addChild: subject.
	inspectorContainer
		addChild:
			(BrButton new
				constraintsDo: [ :c | c ignoreByLayout ];
				geometry: BlCircle new;
				size: 30 @ 30;
				elevation: (BlRelativeElevation elevation: 10);
				look: (GtExplainerTargetLook new explanationModel: #header);
				relocate:
					(inspectorContainer
						globalPointToLocal: (inspectorHeader localPointToGlobal: 10 @ 5))).
	inspectorContainer
		addChild:
			(BrButton new
				constraintsDo: [ :c | c ignoreByLayout ];
				size: 30 @ 30;
				elevation: (BlRelativeElevation elevation: 10);
				geometry: BlCircle new;
				look: (GtExplainerTargetLook new explanationModel: #view);
				relocate:
					(inspectorContainer
						globalPointToLocal: (inspectorView localPointToGlobal: 20 @ 5))).
	inspectorActionMarker := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30 @ 30;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #action);
		relocate: (inspectorContainer globalPointToLocal: (inspectorActionButton localPointToGlobal: 0 @ 0)).
	inspectorContainer addChild: inspectorActionMarker.
	inspectorActionButton
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
			do: [ inspectorActionMarker relocate: (inspectorContainer globalPointToLocal: ((inspectorActionButton localPointToGlobal: (inspectorActionButton bounds center))) - ((inspectorActionMarker extent + inspectorActionMarker border width)  / 2)) ].
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self inspectorExplanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	container addChild: inspectorContainer.
	^ container
]

{ #category : #example }
GtExplainerExamples >> oneTarget [
	<gtExample>
	| container subject target marker editor |
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
	subject := BlElement new 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlFrameLayout new;
		background: Color veryLightGray.
	target := BlElement new 
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
			c horizontal exact: 140.
			c vertical exact: 140 ];
		background: Color orange.
	marker := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 20 @ 20;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #someKey);
		relocate: (subject globalPointToLocal: (target localPointToGlobal: 0 @ 0)).
	target
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
			do: [ marker relocate: (subject globalPointToLocal: (target localPointToGlobal: ((target extent / 2) - ((marker extent + marker border width) / 2)))) ].
	subject addChild: marker.
	subject addChild: target.
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: 'Some ' asRopedText, ('explanation' asRopedText glamorousExplanationFor: #someKey);
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	container addChild: subject.
	^ container
]

{ #category : #example }
GtExplainerExamples >> playgroundExplanationText [
	<gtExample>
	| text |
	text := 
		'The playground is where you script.
		
It comes with snippets, and each snippet can be independently evaluated or ' asRopedText,
		('inspected' asRopedText glamorousExplanationFor: #inspect),
		' and the result is shown on an inspector to the right.' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> playgroundWithPreview [
	<gtExample>
	| container inspectorContainer subject editor playbook inspectAction inspectActionButton inspectActionMarker |
	inspectorContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		background: Color white;
		margin: (BlInsets all: 10);
		look: BrShadowLook.
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
	playbook := GtPlayBook newDefault.
	playbook pages first snippets first sourceCode: '41 + 1'.
	subject := (GtInspector createOnPlayBook: playbook).
	subject forceLayout.
	inspectorContainer addChild: subject.
	inspectAction := subject 
		allChildrenBreadthFirstDetect: [:each | each isKindOf: GtCoderElement] 
		ifFound: [ :coderElement | coderElement coder addOns mainActions detect: [:each | each title = 'Inspect'] ].
	inspectActionButton := subject 
		allChildrenBreadthFirstDetect: [:each | (each isKindOf: BrButton) and: [ each action = inspectAction ]] 
		ifFound: [ :b | b ].
	inspectActionMarker := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 20 @ 20;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #inspect);
		relocate: (inspectorContainer globalPointToLocal: (inspectActionButton localPointToGlobal: 0 @ 0)).
	inspectorContainer addChild: inspectActionMarker.
	inspectActionButton
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
			do: [ inspectActionMarker relocate: (inspectorContainer globalPointToLocal: (inspectActionButton localPointToGlobal: ((inspectActionButton extent / 2) - ((inspectActionMarker extent + inspectActionMarker border width) / 2)))) ].
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self playgroundExplanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	container addChild: inspectorContainer.

	^ container
]
