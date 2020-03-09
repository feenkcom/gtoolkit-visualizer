Class {
	#name : #GtConnectorExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'GToolkit-Connector'
}

{ #category : #examples }
GtConnectorExamples >> anotherSimpleExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector stencil: [ :data |
		| labelButton container dotButton buttonElement buttonContainer |
		container := GtConnectorElement new.
		container geometry: BlEllipse new.
		container background: (Color gray alpha: 0.1).
		container border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).

		labelButton := BrButton new.
		labelButton look: BrTextLabelLook.
		labelButton label: data.
		labelButton layout: BlFrameLayout new.
		labelButton constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ].
		labelButton connector beVisualTarget.
		labelButton relocate: 15 @ 15.

		container addChild: labelButton.
		container connector beLayoutSource.
		container connector beLayoutTarget.
		container connector beVisualTarget.
		container connector model: data.

		buttonContainer := GtConnectorElement new.
		buttonContainer size: 5 @ 5.

		buttonElement := (BlEllipse new extent: 10 asPoint) asElement background: (Color black).
		dotButton := BrButton new.
		dotButton icon: buttonElement.
		dotButton look: BrIconLook.
		dotButton size: 5 @ 5.
		dotButton action: [ gtconnector addEntity: data + 1. gtconnector addEntity: data + 2. ].
		buttonContainer relocate: 10 @ 10.
		buttonContainer addChild: dotButton.

		buttonContainer connector beVisualSource; model: data + 1.

		container addChild: buttonContainer.
		container
	].

	gtconnector addEntity: 1.
	gtconnector addEntity: 2.
	gtconnector addEntity: 3.
	gtconnector addEntity: 5.
	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> exampleMethodsExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtConnector new.
	gtconnector stencil: [ :method |
		| editorElement styler text editor vocalEditorContainer vocalVisualTarget|
		vocalEditorContainer := GtConnectorElement new.
		vocalEditorContainer connector beLayoutSource.
		vocalEditorContainer connector beLayoutTarget.
		vocalEditorContainer connector model: method.
		vocalEditorContainer size: 400@200.

		editorElement := BrEditorElement new.
		editorElement
			constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 200.
			c padding: (BlInsets all: 10) ].
		editorElement
			background: Color white;
			effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 5@5).
		vocalVisualTarget := GtConnectorElement new.
		vocalVisualTarget size: 400@200.

		vocalVisualTarget connector beVisualTarget.
		vocalVisualTarget connector model: method.
		vocalVisualTarget addChild: editorElement.
		styler := GtConnectorExampleStyler new.
		styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
		styler classOrMetaClass: method methodClass.

		editor := BrTextEditor new.

		editor styler: styler.

		"editorElement userData at: #editedMethod put: method."
		editorElement editor: editor.

		text := method sourceCode asRopedText.

		"because we connect editors with lines based on styler we must change text
		only after editor is added to the scene, otherwise events will be ignored"
		editor text: text.

		vocalEditorContainer addChild: vocalVisualTarget.
		vocalEditorContainer
	].
	gtconnector addEntity: (BlFrameLayoutCompositionExamples>>#example).
	^ gtconnector
]

{ #category : #'examples-raw' }
GtConnectorExamples >> rawObjectConnectorTableFor: anObject in: connector [
	| variableNodes list |
	variableNodes := OrderedCollection new: anObject class allSlots size.
	anObject gtInspectorVariableNodesIn: variableNodes.

	list := BrColumnedList new display: variableNodes.
	list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
	list column
		title: 'Icon';
		stencil: [ :aNode :index |
			| icon |
			icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
				on: Error
				do: [ :error | anObject iconNamed: #smallWarningIcon ]).
			icon asElement].
	list column
		title: 'Variable';
		stencil: [ :aNode :index |
			| textElement text vocal |
			text := aNode label asRopedText.
			textElement :=  (BrColumnCellLabelStencil matchParent: text) asElement.
			textElement constraintsDo: [ :c | c padding: (BlInsets left: 10). c padding: (BlInsets top: 5 bottom:  5) ].
			vocal := GtConnectorElement new.
			vocal layout: BlLinearLayout vertical alignCenter.
			vocal addChild: textElement.
			vocal constraintsDo: [:c | c vertical fitContent. c horizontal matchParent].
			vocal ].
		list column
			title: 'Value';
			stencil: [ :aNode :index |
				| text textElement vocal |
				text := [ aNode rawValue gtDisplayString asRopedText ]
					on: Error
					do: [ aNode errorMessage asRopedText foreground: Color red ].
				textElement := (BrColumnCellLabelStencil fitContent: text) asElement.
				textElement constraintsDo: [ :c | c padding: (BlInsets right: 10) ].

				vocal := GtConnectorElement new.
				vocal layout: BlLinearLayout vertical.
				vocal addChild: textElement.
				vocal connector beVisualSource.
				aNode rawValue = aNode hostObject ifFalse: [
					vocal connector model: aNode rawValue.
				].
				vocal when: BlDoubleClickEvent do: [ :event | connector addEntity: aNode rawValue ].
				vocal constraintsDo: [:c | c vertical fitContent. c horizontal matchParent. c padding: (BlInsets top: 1 bottom: 1).].
				vocal
		  ].
	^ list
]

{ #category : #'examples-raw' }
GtConnectorExamples >> rawObjectExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtConnector new.
	gtconnector stencil: [ :entity |
		| uml tabGroup aCloseButton connectorTable aConnectorButton aDetailsButton header text textElement aBottomResizer aRightResizer|

		uml := GtConnectorElement new.
		uml size: 300@300.
		uml layout: BlLinearLayout new beVertical.
		uml connector beLayoutSource.
		uml connector beLayoutTarget.
		uml connector model: entity.
		uml constraintsDo: [:c | c padding: (BlInsets top: 1 bottom: 1).].
		uml background: Color white;
			effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 5@5).
		uml connector beVisualTarget.
		uml connector model: entity.

		tabGroup := (entity gtViewsFor: GtPhlowEmptyView new) asElementDo: [:e | e ].

		header := GtConnectorElement new.
		header layout: BlLinearLayout vertical alignCenter.
				header constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
		text := BlRopedText string: entity printString.
		text attributes: {
		BlFontSizeAttribute size: 12.
		BlTextForegroundAttribute paint: Color gray.}.
		textElement := BlTextElement new text: text asRopedText.
		header addChild: textElement.
		textElement constraintsDo: [ :c | c padding: (BlInsets new top: 20 right: 0 bottom: 0 left: 20) ].

		connectorTable := self rawObjectConnectorTableFor: entity in: gtconnector.

		aCloseButton := GtInspectorRoundButtonStencil new asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e | gtconnector removeChild: e parent ].

		aConnectorButton := GtInspectorConnectorSwitchStencil new asElement
		label: 'Connector';

		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ].

		aDetailsButton := GtInspectorRoundButtonStencil new asElement
		icon: (BrGlamorousIcons inspect asElement);

		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ].

		aConnectorButton action: [ uml removeChild: aCloseButton.
			uml removeChild: tabGroup.
			uml addChild: header.
			uml addChild: connectorTable.
			uml addChild: aCloseButton.
			uml removeChild: aConnectorButton.
			uml addChild: aDetailsButton.  ].
		aDetailsButton action: [ uml removeChild: aCloseButton.
			uml removeChild: header.
			uml removeChild: connectorTable.
			uml addChild: tabGroup.
			uml addChild: aCloseButton.
			uml removeChild: aDetailsButton.
			uml addChild: aConnectorButton.  ].
		aBottomResizer := BlElement new
			look: BrGlamorousResizerBottomBarLook new;
			constraintsDo: [ :c |
				c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0).];
				addEventHandler: (BlResizerBottomListener new resizeTarget: uml; minimumExtent: 0@75).
		aRightResizer := BlElement new
			look: BrGlamorousResizerRightBarLook new;
			constraintsDo: [ :c |
				c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0).];
				addEventHandler: (BlResizerRightListener new resizeTarget: uml; minimumExtent: 75@0).

		uml addChild: header.
		uml addChild: connectorTable.
		uml addChild: aCloseButton.
		uml addChild: aDetailsButton.
		uml addChild: aBottomResizer. 
		uml addChild: aRightResizer.
		uml clipChildren: false.
		uml
	].
	gtconnector addEntity: GtConnector new.
	^ gtconnector
]
