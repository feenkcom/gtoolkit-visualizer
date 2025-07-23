Class {
	#name : #GtConnectorExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'GToolkit-Connector-Examples'
}

{ #category : #'examples - container' }
GtConnectorExamples >> basicContainer [
	<gtExample>
	<return: #GtConnectorContainer>
	| aContainer |
	aContainer := GtConnectorContainer new.
	self assert: aContainer hasChildren not.
	self assert: aContainer entity isNil.
	^ aContainer
]

{ #category : #utils }
GtConnectorExamples >> buildCloseButton [
	^ (GtInspectorRoundButtonStencil new 
	size: 15@15)
	asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		"beTiny;"
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -7.5 left: 0 bottom: 0 right: -7.5).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :aButton | aButton parent removeFromParent ]
]

{ #category : #utils }
GtConnectorExamples >> createContainerElement [
	^ BlElement new
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		background: (Color gray alpha: 0.1);
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2);
		clipChildren: false; 
		 addChild: self buildCloseButton
]

{ #category : #utils }
GtConnectorExamples >> createLabelWithText: aLabel [ 	
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: aLabel
]

{ #category : #utils }
GtConnectorExamples >> createVisualSourceButtonForModel: anEntity withLabel: aLabel withAction: anAction [
	| button |
	button := BrButton new
		label: '+0';
		aptitude: BrGlamorousButtonWithLabelAptitude " BrGlamorousButtonWithIconLook";
		beSmallSize;
		background: Color white;
	 	border: (BlBorder paint: Color gray);
	 	action: anAction.
	^ button
]

{ #category : #utils }
GtConnectorExamples >> createVisualSourceButtonWithLabel: aLabel withAction: anAction [
	| button |
	button := BrButton new
		label: aLabel;
		aptitude: BrGlamorousButtonWithLabelAptitude " BrGlamorousButtonWithIconLook";
		beSmallSize;
		background: Color white;
	 	border: (BlBorder paint: Color gray);
	 	action: anAction.
	^ button
]

{ #category : #'examples - container' }
GtConnectorExamples >> entityOne [
	<gtExample>
	<return: #CompiledMethod>
	^ self class >> #entityOne
]

{ #category : #'examples - container' }
GtConnectorExamples >> entityOneContainer [
	<gtExample>
	<return: #GtConnectorContainer>
	| aContainer anEntity |
	aContainer := self basicContainer.
	anEntity := self entityOne.
	aContainer entity: anEntity.
	self assert: aContainer entity equals: anEntity.
	self assert: aContainer hasChildren.
	^ aContainer
]

{ #category : #'examples - container' }
GtConnectorExamples >> entityTwo [
	<gtExample>
	<return: #CompiledMethod>
	^ self class >> #entityTwo
]

{ #category : #examples }
GtConnectorExamples >> exampleMethodsExample [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.
	gtconnector
		stencil: [ :method | 
			| editorContainer editorElement styler text editor |
			editorContainer := BlElement new.
			editorContainer layout: BlFrameLayout new.
			editorContainer
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c margin: (BlInsets all: 10) ].
			editorContainer connector
				beLayoutSource;
				beLayoutTarget;
				model: method.

			editorElement := BrEditorElement new.
			editorElement
				constraintsDo: [ :c | 
					c horizontal exact: 400.
					c vertical exact: 200.
					c padding: (BlInsets all: 10).
					c margin: (BlInsets all: 10).
					c frame vertical alignCenter.
					c frame horizontal alignCenter ];
				background: Color white;
				effect: (BlGaussianShadowEffect
						color: (Color gray alpha: 0.5)
						width: 5
						offset: 5 @ 5).

			editorElement connector
				model: method;
				beVisualTarget.

			styler := GtConnectorExampleStyler new.
			styler
				exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
			styler classOrMetaClass: method methodClass.

			editor := BrTextEditorModel new.
			editor styler: styler.

			editorElement editor: editor.

			text := method sourceCode asRopedText.	"because we connect editors with lines based on styler we must change text
		only after editor is added to the scene, otherwise events will be ignored"
			editor text: text.

			editorContainer addChild: editorElement.
			editorContainer ].
	gtconnector addEntity: BlFrameLayoutCompositionExamples >> #example.

	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> linearDependenciesExample [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector
		stencil: [ :data | 
			| labelButton container dotButton |
			container := BlElement new.
			container connector
				model: data;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.

			container
				geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
				background: (Color gray alpha: 0.1);
				border: (BlBorder paint: (Color blue alpha: 0.2) width: 2);
				clipChildren: false;
				addChild: self buildCloseButton.

			labelButton := BrButton new.
			labelButton aptitude: BrTextLabelAptitude.
			labelButton label: data.
			labelButton layout: BlFrameLayout new.
			labelButton
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ].
			labelButton relocate: 10 @ 15.

			container addChild: labelButton.

			dotButton := BrButton new.
			dotButton
				icon: ((BlEllipseGeometry new extent: 10 asPoint) asElement background: Color black).
			dotButton aptitude: BrIconAptitude.	" BrGlamorousButtonWithIconLook"
			dotButton size: 10 @ 10.
			dotButton
				action: [ gtconnector addEntity: data + 1.
					gtconnector addEntity: data + 2 ].
			dotButton connector
				model: data + 1;
				beVisualSource.

			dotButton relocate: 30 @ 14.

			container addChild: dotButton.
			container ].

	gtconnector addEntity: 1.
	gtconnector addEntity: 2.
	gtconnector addEntity: 3.
	gtconnector addEntity: 7.

	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> linearDependenciesWithButtonContainerExample [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector
		stencil: [ :data | 
			| labelButton container dotButton buttonElement buttonContainer |
			container := BlElement new.
			container connector
				model: data;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.

			container
				geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
				background: (Color gray alpha: 0.1);
				border: (BlBorder paint: (Color blue alpha: 0.2) width: 2);
				clipChildren: false;
				addChild: self buildCloseButton.

			labelButton := BrButton new.
			labelButton aptitude: BrTextLabelAptitude.
			labelButton label: data.
			labelButton layout: BlFrameLayout new.
			labelButton
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ].
			labelButton relocate: 10 @ 15.

			container addChild: labelButton.

			buttonContainer := BlElement new.
			buttonContainer connector
				model: data + 1;
				beVisualSource.
			buttonContainer size: 10 @ 10.

			buttonElement := (BlEllipseGeometry new extent: 10 asPoint) asElement
					background: Color black.
			dotButton := BrButton new.
			dotButton icon: buttonElement.
			dotButton aptitude: BrIconAptitude.	" BrGlamorousButtonWithIconLook"
			dotButton size: 10 @ 10.
			dotButton
				action: [ gtconnector addEntity: data + 1.
					gtconnector addEntity: data + 2 ].
			buttonContainer relocate: 30 @ 14.
			buttonContainer addChild: dotButton.

			container addChild: buttonContainer.
			container ].

	gtconnector addEntity: 1.
	gtconnector addEntity: 2.
	gtconnector addEntity: 3.
	gtconnector addEntity: 7.

	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> linearDoubleDependenciesExample [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector
		stencil: [ :data | 
			| labelButton container dotButtonOne dotButtonTwo buttonOneData buttonTwoData |
			container := BlElement new.
			container size: 90 @ 70.
			container connector
				model: data;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.

			container geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
			container background: (Color gray alpha: 0.1).
			container border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
			container
				clipChildren: false;
				addChild: self buildCloseButton.

			labelButton := BrButton new.
			labelButton aptitude: BrTextLabelAptitude.
			labelButton label: data.
			labelButton layout: BlFrameLayout new.
			labelButton
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ].
			labelButton relocate: 10 @ 27.

			container addChild: labelButton.

			buttonOneData := data + 2.
			dotButtonOne := BrButton new.
			dotButtonOne label: buttonOneData.
			dotButtonOne aptitude: BrGlamorousButtonWithLabelAptitude.	" BrGlamorousButtonWithIconLook"
			dotButtonOne beSmallSize.
			dotButtonOne background: Color white.
			dotButtonOne border: (BlBorder paint: Color gray).
			dotButtonOne action: [ gtconnector addEntity: buttonOneData ].
			dotButtonOne relocate: 50 @ 5.
			dotButtonOne connector
				model: buttonOneData;
				beVisualSource.

			buttonTwoData := data + 3.
			dotButtonTwo := BrButton new.
			dotButtonTwo label: buttonTwoData.
			dotButtonTwo aptitude: BrGlamorousButtonWithLabelAptitude.
			dotButtonTwo beSmallSize.
			dotButtonTwo background: Color white.
			dotButtonTwo border: (BlBorder paint: Color gray).
			dotButtonTwo action: [ gtconnector addEntity: buttonTwoData ].
			dotButtonTwo relocate: 50 @ 45.
			dotButtonTwo connector
				model: buttonTwoData;
				beVisualSource.

			container addChild: dotButtonOne.
			container addChild: dotButtonTwo.
			container ].

	gtconnector addEntity: 0.
	gtconnector addEntity: 1.
	gtconnector addEntity: 2.
	gtconnector addEntity: 3.
	^ gtconnector
]

{ #category : #'examples-raw' }
GtConnectorExamples >> rawObjectExample [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.
	gtconnector
		stencil: [ :entity | 
			| uml tabGroup aCloseButton connectorTable aConnectorButton aDetailsButton header text textElement aBottomResizer aRightResizer |
			uml := BlElement new.
			uml size: 300 @ 300.
			uml layout: BlLinearLayout new beVertical.
			uml constraintsDo: [ :c | c padding: (BlInsets top: 1 bottom: 1) ].
			uml
				background: Color white;
				effect: (BlGaussianShadowEffect
						color: (Color gray alpha: 0.5)
						width: 5
						offset: 5 @ 5).
			uml connector
				model: entity;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.
			tabGroup := (entity gtViewsFor: GtPhlowEmptyView new) asElementDo: [ :e | e ].
			header := BlElement new.
			header layout: BlLinearLayout vertical alignCenter.
			header
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ].
			text := entity printString asRopedText.
			text
				attributes: {BlFontSizeAttribute size: 12.
						BlTextForegroundAttribute paint: Color gray}.
			textElement := BlTextElement new text: text asRopedText.
			header addChild: textElement.
			textElement
				constraintsDo: [ :c | 
					c
						padding: (BlInsets
								top: 20
								right: 0
								bottom: 0
								left: 20) ].
			connectorTable := entity gtObjectConnectorTableIn: gtconnector.
			aCloseButton := GtInspectorRoundButtonStencil new asElement
					icon: GtInspectorPlusIconStencil close;
					constraintsDo: [ :c | 
						c ignoreByLayout.
						c
							margin: (BlInsets
									top: -10
									left: 0
									bottom: 0
									right: -10).
						c ignored horizontal alignRight.
						c ignored vertical alignTop ];
					action: [ :e | gtconnector removeChild: e parent ].
			aConnectorButton := GtInspectorConnectorSwitchStencil new asElement
					label: 'Connector';
					constraintsDo: [ :c | 
						c ignoreByLayout.
						c
							margin: (BlInsets
									top: -10
									left: 0
									bottom: 0
									right: -10).
						c ignored horizontal alignCenter.
						c ignored vertical alignTop ].
			aDetailsButton := GtInspectorRoundButtonStencil new asElement
					icon: BrGlamorousVectorIcons inspect;
					constraintsDo: [ :c | 
						c ignoreByLayout.
						c
							margin: (BlInsets
									top: -10
									left: 0
									bottom: 0
									right: -10).
						c ignored horizontal alignCenter.
						c ignored vertical alignTop ].
			aConnectorButton
				action: [ uml removeChild: aCloseButton.
					uml removeChild: tabGroup.
					uml addChild: header.
					uml addChild: connectorTable.
					uml addChild: aCloseButton.
					uml removeChild: aConnectorButton.
					uml addChild: aDetailsButton ].
			aDetailsButton
				action: [ uml removeChild: aCloseButton.
					uml removeChild: header.
					uml removeChild: connectorTable.
					uml addChild: tabGroup.
					uml addChild: aCloseButton.
					uml removeChild: aDetailsButton.
					uml addChild: aConnectorButton ].
			aBottomResizer := BlElement new
					aptitude: BrGlamorousResizerBottomBarAptitude new;
					constraintsDo: [ :c | 
						c
							margin: (BlInsets
									top: 0
									left: 0
									bottom: 0
									right: 0) ];
					addEventHandler: (BlResizerBottomListener new
							resizeTarget: uml;
							minimumExtent: 0 @ 75).
			aRightResizer := BlElement new
					aptitude: BrGlamorousResizerRightBarAptitude new;
					constraintsDo: [ :c | 
						c
							margin: (BlInsets
									top: 0
									left: 0
									bottom: 0
									right: 0) ];
					addEventHandler: (BlResizerRightListener new
							resizeTarget: uml;
							minimumExtent: 75 @ 0).
			uml addChild: header.
			uml addChild: connectorTable.
			uml addChild: aCloseButton.
			uml addChild: aDetailsButton.
			uml addChild: aBottomResizer.
			uml addChild: aRightResizer.
			uml clipChildren: false.
			uml ].
	gtconnector addEntity: GtConnector new.
	^ gtconnector
]

{ #category : #'examples - container' }
GtConnectorExamples >> replaceEntityOneByEntityTwoContainer [
	<gtExample>
	<return: #GtConnectorContainer>
	| aContainer anEntity anOldContent |
	aContainer := self entityOneContainer.
	anOldContent := aContainer childAt: 1.
	anEntity := self entityTwo.
	aContainer entity: anEntity.
	self assert: aContainer entity equals: anEntity.
	self assert: (aContainer childAt: 1) ~= anOldContent.
	^ aContainer
]

{ #category : #examples }
GtConnectorExamples >> treeDependeciesExampleWithNoVisualSourceAndExplicitReferences [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := self
			treeDependeciesExampleWithNoVisualSourceAndNoExplicitReferences.
	gtconnector
		referencedEntities: [ :data | 
			{data , '0'.
				data , '1'} ].

	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> treeDependeciesExampleWithNoVisualSourceAndNoExplicitReferences [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector
		stencil: [ :data | 
			| label container dotButtonOne dotButtonTwo buttonOneData buttonTwoData toggleButtonOne toggleButtonTwo |
			container := self createContainerElement.
			container size: 90 @ 70.
			container connector
				model: data;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.

			label := self createLabelWithText: data.
			label relocate: 10 @ 25.
			container addChild: label.

			buttonOneData := data , '0'.
			dotButtonOne := self
					createVisualSourceButtonWithLabel: '+0'
					withAction: [ gtconnector addEntity: buttonOneData ].
			dotButtonOne relocate: 50 @ 5.

			dotButtonOne connector
				model: buttonOneData;
				beVisualSource.

			buttonTwoData := data , '1'.
			dotButtonTwo := self
					createVisualSourceButtonWithLabel: '+1'
					withAction: [ gtconnector addEntity: buttonTwoData ].
			dotButtonTwo relocate: 50 @ 45.

			dotButtonTwo connector
				model: buttonTwoData;
				beVisualSource.

			toggleButtonOne := BrToggle new
					aptitude: BrHydraSwitchWithoutTrackAptitude new;
					when: BrToggleActivatedEvent
						do: [ :anEvent | container addChild: dotButtonOne ];
					when: BrToggleDeactivatedEvent
						do: [ :anEvent | container removeChild: dotButtonOne ].
			toggleButtonOne relocate: 5 @ 5.

			toggleButtonTwo := BrToggle new
					aptitude: BrHydraSwitchWithoutTrackAptitude new;
					when: BrToggleActivatedEvent
						do: [ :anEvent | container addChild: dotButtonTwo ];
					when: BrToggleDeactivatedEvent
						do: [ :anEvent | container removeChild: dotButtonTwo ].
			toggleButtonTwo relocate: 5 @ 45.

			container addChild: toggleButtonOne.
			container addChild: toggleButtonTwo.

			container ].

	gtconnector addEntity: '0'.
	gtconnector addEntity: '00'.
	gtconnector addEntity: '01'.

	gtconnector addEntity: '000'.
	gtconnector addEntity: '001'.
	^ gtconnector
]

{ #category : #examples }
GtConnectorExamples >> treeDependeciesExampleWithVisibleVisualSourceAndNoExplicitReferences [
	<gtExample>
	<return: #GtConnector>
	| gtconnector |
	gtconnector := GtConnector new.

	gtconnector
		stencil: [ :data | 
			| label container dotButtonOne dotButtonTwo buttonOneData buttonTwoData toggleButtonOne toggleButtonTwo |
			container := self createContainerElement.
			container size: 90 @ 70.
			container connector
				model: data;
				beLayoutSource;
				beLayoutTarget;
				beVisualTarget.

			label := self createLabelWithText: data.
			label relocate: 10 @ 27.
			container addChild: label.

			buttonOneData := data , '0'.
			dotButtonOne := self
					createVisualSourceButtonWithLabel: '+0'
					withAction: [ gtconnector addEntity: buttonOneData ].
			dotButtonOne relocate: 50 @ 5.

			dotButtonOne connector
				model: buttonOneData;
				beVisualSource.

			buttonTwoData := data , '1'.
			dotButtonTwo := self
					createVisualSourceButtonWithLabel: '+1'
					withAction: [ gtconnector addEntity: buttonTwoData ].
			dotButtonTwo relocate: 50 @ 45.

			dotButtonTwo connector
				model: buttonTwoData;
				beVisualSource.

			toggleButtonOne := BrToggle new
					aptitude: BrHydraSwitchWithoutTrackAptitude new;
					when: BrToggleActivatedEvent
						do: [ :anEvent | container addChild: dotButtonOne ];
					when: BrToggleDeactivatedEvent
						do: [ :anEvent | container removeChild: dotButtonOne ];
					activate.
			toggleButtonOne relocate: 5 @ 5.

			toggleButtonTwo := BrToggle new
					aptitude: BrHydraSwitchWithoutTrackAptitude new;
					when: BrToggleActivatedEvent
						do: [ :anEvent | container addChild: dotButtonTwo ];
					when: BrToggleDeactivatedEvent
						do: [ :anEvent | container removeChild: dotButtonTwo ];
					activate.
			toggleButtonTwo relocate: 5 @ 45.

			container addChild: toggleButtonOne.
			container addChild: toggleButtonTwo.

			container ].

	gtconnector addEntity: '0'.
	gtconnector addEntity: '00'.
	gtconnector addEntity: '01'.

	gtconnector addEntity: '000'.
	gtconnector addEntity: '001'.
	^ gtconnector
]
