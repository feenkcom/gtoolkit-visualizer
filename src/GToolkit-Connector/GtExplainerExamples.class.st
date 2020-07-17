Class {
	#name : #GtExplainerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Connector'
}

{ #category : #'as yet unclassified' }
GtExplainerExamples >> inspectorContainerElement [
	<gtExample>
	| inspectorContainer subject inspectorHeader inspectorView inspectorActionButton |
	inspectorContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		background: Color white;
		margin: (BlInsets all: 10);
		look: BrShadowLook.

	subject := BlUseAsyncFeatures
		disableDuring: [ (GtABCartoonAddressBookExample new cartoonAddressBook gtViewsFor: GtPhlowView empty) asElementDo: [ :e | e ] ].
	subject forceLayout.
	inspectorHeader := subject phlow firstChildWithView.
	inspectorView := inspectorHeader viewContentElement phlow
		firstChildWithView.
	inspectorActionButton := subject phlow firstChildWithAction.
	inspectorContainer addChild: subject.
		
	inspectorHeader
		addChild:
			(BrButton new
				constraintsDo: [ :c | c ignoreByLayout ];
				size: 5 @ 5;
				elevation: (BlRelativeElevation elevation: 10);
				geometry: BlCircle new;
				look: (GtExplainerTargetLook new explanationModel: #header);
				relocate:
					(5 @ inspectorHeader extent y / 2)). 
	inspectorView
		addChild:
			(BrButton new
				constraintsDo: [ :c | c ignoreByLayout ];
				size: 5 @ 5;
				elevation: (BlRelativeElevation elevation: 10);
				geometry: BlCircle new;
				look: (GtExplainerTargetLook new explanationModel: #view);
				relocate:
					(5 @ inspectorView extent y / 2)).
	inspectorActionButton
		addChild:
			(BrButton new
				constraintsDo: [ :c | c ignoreByLayout ];
				size: 5 @ 5;
				elevation: (BlRelativeElevation elevation: 10);
				geometry: BlCircle new;
				look: (GtExplainerTargetLook new explanationModel: #action);
				relocate:
					(5 @ inspectorActionButton extent y / 2)).
					
	^ inspectorContainer.
]

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
		' that are specific to the object. Every object is allowed to specify multiple such custom views.' asRopedText.
	^ text 
		glamorousRegularFont;
		fontSize: 20;
		foreground: Color black
]

{ #category : #example }
GtExplainerExamples >> inspectorOnOneObjectExample [
	<gtExample>
	| container editor |
	
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal.
	container explainer isExplanationHolder: true.
					
	editor := BrEditor new
		look: (BrGlamorousRegularEditorLook new fontSize: 16);
		text: self inspectorExplanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: editor.
	container addChild: self inspectorContainerElement.
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
		background: (Color white);
		look: BrShadowLook;
		margin: (BlInsets all: 10).
	target := BlElement new 
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
			c horizontal exact: 140.
			c vertical exact: 140 ];
		background: Color gray.
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
	| container inspectorContainer subject editor playbook codeElement inspectButton inspectActionMarker |
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
	playbook := GtPlayBook newWithCodeSnippetContent: '41 + 1'.
	subject := GtPlayground createOn: playbook.
	subject forceLayout.
	inspectorContainer addChild: subject.
	codeElement := subject 
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: GtExpandableCoderElement] 
		ifFound: [ :coderElement | coderElement ]
		ifNone: [ NotFound signal: 'inspect action not found' ].
	inspectButton := codeElement 
		allChildrenBreadthFirstDetect: [:each | (each isKindOf: BrButton) and: [ each label asString = 'Inspect' ]] 
		ifFound: [ :b | b ]
		ifNone: [ NotFound signal: 'inspect button not found' ].
	inspectActionMarker := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 20 @ 20;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new;
		look: (GtExplainerTargetLook new explanationModel: #inspect);
		relocate: (inspectorContainer globalPointToLocal: (inspectButton localPointToGlobal: 0 @ 0)).
	inspectorContainer addChild: inspectActionMarker.
	inspectButton
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
			do: [ inspectActionMarker relocate: (inspectorContainer globalPointToLocal: (inspectButton localPointToGlobal: ((inspectButton extent / 2) - ((inspectActionMarker extent + inspectActionMarker border width) / 2)))) ].
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
