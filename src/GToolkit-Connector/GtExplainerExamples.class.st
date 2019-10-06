Class {
	#name : #GtExplainerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Connector'
}

{ #category : #example }
GtExplainerExamples >> example [
	<gtExample>
	| container inspectorContainer subject inspectorHeader editor inspectorView inspectorAction inspectorActionMarker |
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
	inspectorAction := subject phlow firstChildWithAction.
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
		relocate: (inspectorContainer globalPointToLocal: (inspectorAction localPointToGlobal: 0 @ 0)).
	inspectorContainer addChild: inspectorActionMarker.
	inspectorAction
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
			do: [ inspectorActionMarker relocate: (inspectorContainer globalPointToLocal: ((inspectorAction localPointToGlobal: (inspectorAction bounds center))) - ((inspectorActionMarker extent + inspectorActionMarker border width)  / 2)) ].
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self explanationText;
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
GtExplainerExamples >> explanationText [
	<gtExample>
	| text |
	text := 
		'An inspector pane is made of several parts.

The ' asRopedText, 
		('header' asRopedText glamorousExplanationFor: #header),
		' shows the string representation of the inspected object.

The header also presents ' asRopedText, ('actions' asRopedText glamorousExplanationFor: #action), ' that are global to an object, such as inspect. 

The inspector shows multiple ' asRopedText,
		('views' asRopedText glamorousExplanationFor: #view),
		' that are specific to the object' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> inspectorExplanationText [
	<gtExample>
	| text |
	text := 
		'An inspector pane is made of several parts.

The ' asRopedText, 
		('header' asRopedText glamorousExplanationFor: #header),
		' shows the string representation of the inspected object.

The inspector shows multiple ' asRopedText,
		('views' asRopedText glamorousExplanationFor: #view),
		' that are specific to the object' asRopedText.
	^ text 
		glamorousRegularFont;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> inspectorOnOneObjectExample [
	<gtExample>
	| container inspectorContainer subject inspectorHeader editor inspectorView |
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
	inspectorView := inspectorHeader viewContentElement phlow firstChildWithView.
	inspectorContainer addChild: subject.
	container addChild: inspectorContainer.
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #header);
		relocate: (container globalPointToLocal: (inspectorHeader localPointToGlobal: 15 @ 15))).
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #view);
		relocate: (container globalPointToLocal: (inspectorView localPointToGlobal: 30 @ 15))).
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self inspectorExplanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	^ container
]

{ #category : #example }
GtExplainerExamples >> playgroundWithPreview [
	<gtExample>
	| container inspectorContainer subject inspectorHeader editor inspectorView playbook |
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
	subject := (GtInspector createOnPlayBook: playbook) asElementDo: [ :e | e ].
	subject forceLayout.
	inspectorHeader := subject phlow firstChildWithView.
	inspectorView := inspectorHeader viewContentElement phlow firstChildWithView.
	inspectorContainer addChild: subject.
	container addChild: inspectorContainer.
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #header);
		relocate: (container globalPointToLocal: (inspectorHeader localPointToGlobal: 15 @ 15))).
	container addChild: (BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 30@30;
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #view);
		relocate: (container globalPointToLocal: (inspectorView localPointToGlobal: 30 @ 15))).
	editor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		text: self inspectorExplanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	^ container
]
