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
		container := BlElement new.
		container connector 
			beLayoutSource;
			beLayoutTarget;
			beVisualTarget;
			model: data.
		
		container geometry: BlEllipse new.
		container background: (Color gray alpha: 0.1).
		container border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
		container addEventHandler: (BlEventHandler
			on: BlDoubleClickEvent
			do: [ :evt | container removeFromParent ]).

		labelButton := BrButton new.
		labelButton look: BrTextLabelLook.
		labelButton label: data.
		labelButton layout: BlFrameLayout new.
		labelButton constraintsDo: [ :c | 
			c horizontal fitContent. 
			c vertical fitContent ].
		labelButton relocate: 15 @ 15.

		container addChild: labelButton.

		buttonContainer := BlElement new.
		buttonContainer connector 
			beVisualSource; 
			model: data + 1.
		buttonContainer size: 10 @ 10.

		buttonElement := (BlEllipse new extent: 10 asPoint) asElement 
			background: Color black.
		dotButton := BrButton new.
		dotButton icon: buttonElement.
		dotButton look: BrIconLook " BrGlamorousButtonWithIconLook".
		dotButton size: 10 @ 10.
		dotButton action: [ 
			gtconnector addEntity: data + 1. 
			gtconnector addEntity: data + 2 ].
		buttonContainer relocate: 7 @ 7.
		buttonContainer addChild: dotButton.

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
		| editorContainer editorElement styler text editor |

		editorContainer := BlElement new.
		editorContainer layout: BlFrameLayout new.
		editorContainer constraintsDo: [ :c |.
			c horizontal fitContent.
			c vertical fitContent.
			c margin: (BlInsets all: 10) ].
		editorContainer connector 
			beLayoutSource;
			beLayoutTarget.
		
		editorElement := BrEditorElement new.
		editorElement
			constraintsDo: [ :c |
				c horizontal exact: 400.
				c vertical exact: 200.
				c padding: (BlInsets all: 10).
				c margin: (BlInsets all: 10).
				c frame vertical alignCenter.
				c frame horizontal alignCenter   ];
			background: Color white;
			effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 5@5).
		
		editorElement connector beVisualTarget.
		editorElement connector model: method.
		
		styler := GtConnectorExampleStyler new.
		styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
		styler classOrMetaClass: method methodClass.

		editor := BrTextEditor new.
		editor styler: styler.

		editorElement editor: editor.

		text := method sourceCode asRopedText.

		"because we connect editors with lines based on styler we must change text
		only after editor is added to the scene, otherwise events will be ignored"
		editor text: text.

		editorContainer addChild: editorElement.
		editorContainer.
	].
	gtconnector addEntity: (BlFrameLayoutCompositionExamples>>#yellow).
	
	^ gtconnector
]

{ #category : #'examples-raw' }
GtConnectorExamples >> rawObjectExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtConnector new.
	gtconnector stencil: [ :entity |
		| uml tabGroup aCloseButton connectorTable aConnectorButton aDetailsButton header text textElement aBottomResizer aRightResizer|

		uml := BlElement new.
		uml size: 300@300.
		uml layout: BlLinearLayout new beVertical.
		uml constraintsDo: [:c | c padding: (BlInsets top: 1 bottom: 1).].
		uml 
			background: Color white;
			effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 5@5).
		uml connector 
			beLayoutSource;
			beLayoutTarget;
			beVisualTarget;
			model: entity.

		tabGroup := (entity gtViewsFor: GtPhlowEmptyView new) asElementDo: [:e | e ].

		header := BlElement new.
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
		textElement constraintsDo: [ :c | 
			c padding: (BlInsets top: 20 right: 0 bottom: 0 left: 20) ].

		connectorTable := entity gtObjectConnectorTableIn: gtconnector.

		aCloseButton := GtInspectorRoundButtonStencil new asElement
			icon: (GtInspectorPlusIconStencil close);
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
			icon: (BrGlamorousVectorIcons inspect);
			constraintsDo: [ :c |
				c ignoreByLayout.
				c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
				c ignored horizontal alignCenter.
				c ignored vertical alignTop ].

		aConnectorButton action: [ 
			uml removeChild: aCloseButton.
			uml removeChild: tabGroup.
			uml addChild: header.
			uml addChild: connectorTable.
			uml addChild: aCloseButton.
			uml removeChild: aConnectorButton.
			uml addChild: aDetailsButton.  ].
		aDetailsButton action: [ 
			uml removeChild: aCloseButton.
			uml removeChild: header.
			uml removeChild: connectorTable.
			uml addChild: tabGroup.
			uml addChild: aCloseButton.
			uml removeChild: aDetailsButton.
			uml addChild: aConnectorButton.  ].
		aBottomResizer := BlElement new
			look: BrGlamorousResizerBottomBarLook new;
			constraintsDo: [ :c |
				c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0) ];
				addEventHandler: (BlResizerBottomListener new resizeTarget: uml; minimumExtent: 0@75).
		aRightResizer := BlElement new
			look: BrGlamorousResizerRightBarLook new;
			constraintsDo: [ :c |
				c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0) ];
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
