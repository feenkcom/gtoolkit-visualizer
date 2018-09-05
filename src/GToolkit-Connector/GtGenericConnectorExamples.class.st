Class {
	#name : #GtGenericConnectorExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'GToolkit-Connector'
}

{ #category : #examples }
GtGenericConnectorExamples class >> oneExampleMethod [
	<script: 'self oneExampleMethod'>
	self
		openInWindow: self new oneExampleMethod
		named: 'GT-Connector'
		extent: 960@790
]

{ #category : #examples }
GtGenericConnectorExamples >> anotherSimpleExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtGenericConnector new.
	
	gtconnector stencil: [ :data |
		| labelButton container dotButton buttonElement buttonContainer | 
		container := VocalBlElement new.
		container geometry: (BlEllipse diameter: 30).
		container
		background: (Color gray alpha: 0.1);
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
		 
		labelButton := BrButton new.
		labelButton look: BrLabelLook.
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
		
		buttonContainer := VocalBlElement new.	
		buttonContainer size: 5 @ 5.
		
		buttonElement := (BlEllipse diameter: 5) asElement background: (Color black).
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
GtGenericConnectorExamples >> exampleMethodsExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtGenericConnector new.
	gtconnector stencil: [ :method |
		| editorElement styler text editor vocalEditorContainer vocalVisualTarget|
		vocalEditorContainer := VocalBlElement new.
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
			effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).
		vocalVisualTarget := VocalBlElement new.
		vocalVisualTarget size: 400@200.
		
		vocalVisualTarget connector beVisualTarget.
		vocalVisualTarget connector model: method.
		vocalVisualTarget addChild: editorElement.
		styler := GtConnectorExampleStyler new.
		styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
		styler classOrMetaClass: method methodClass.
		styler addEventHandler: (GtConnectorStylerListener new connector: gtconnector).

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
	gtconnector addEntity: (BlFrameLayoutExamples>>#example).
	^ gtconnector
]

{ #category : #'examples-raw' }
GtGenericConnectorExamples >> rawObjectConnectorTableFor: anObject in: connector [
	| variableNodes list |
	variableNodes := OrderedCollection new: anObject class allSlots size.
	variableNodes add: (GTInspectorSelfNode hostObject: anObject).
	anObject gtInspectorVariableNodesIn: variableNodes.
	
	list := BrColumnedList new display: variableNodes.
	"list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :aNode | aNode rawValue ])."
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
			textElement :=  (BrListLabelStencil matchParent: text) asElement.
			textElement constraintsDo: [ :c | c horizontal matchParent.  c padding: (BlInsets left: 10). c padding: (BlInsets top: 5 bottom:  5) ].
			vocal := VocalBlElement new.
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
				textElement :=  (BrListLabelStencil matchParent: text) asElement.
				textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
				
				vocal := VocalBlElement new.
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
GtGenericConnectorExamples >> rawObjectExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtGenericConnector new.
	gtconnector stencil: [ :entity |
		| uml tabGroup aCloseButton connectorTable aConnectorButton aDetailsButton header text textElement|
		
		uml := VocalBlElement new.
		uml size: 300@300.
		uml layout: BlLinearLayout new beVertical.
		uml connector beLayoutSource.
		uml connector beLayoutTarget.
		uml connector model: entity.
		uml constraintsDo: [:c | c padding: (BlInsets top: 1 bottom: 1).].
		uml background: Color white;
			effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).
		uml connector beVisualTarget.
		uml connector model: entity.
		
		tabGroup := (entity gtViewsFor: GtPhlowEmptyView new) asElementDo: [:e | e ].

		header := VocalBlElement new.
		header look: (BrLayoutLook linearVertical hMatchParent).
		text := BlRopedText string: entity printString.
		textElement := BlTextElement new text: text asRopedText.
		
		textElement look: (BrLayoutLook fitContent alignCenter).
	
		header addChild: textElement.
		textElement constraintsDo: [ :c | c padding: (BlInsets top:25) ].	
	
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
		
		aConnectorButton action: [ uml removeChild: aCloseButton. uml removeChild: tabGroup. uml addChild: header. uml addChild: connectorTable. uml addChild: aCloseButton.  uml removeChild: aConnectorButton. uml addChild: aDetailsButton.  ].
		aDetailsButton action: [ uml removeChild: aCloseButton. uml removeChild: header. uml removeChild: connectorTable. uml addChild: tabGroup. uml addChild: aCloseButton. uml removeChild: aDetailsButton. uml addChild: aConnectorButton.  ].
		
		uml addChild: header.
		uml addChild: connectorTable.
		uml addChild: aCloseButton.
		uml addChild: aDetailsButton.
		uml clipChildren: false.
		uml
	].
	gtconnector addEntity: GtGenericConnector new.
	^ gtconnector 
]
