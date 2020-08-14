Extension { #name : #Object }

{ #category : #'*GToolkit-Connector' }
Object >> gtConnectionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Connections';
		priority: 110;
		stencil: [
			| gtconnector |
			gtconnector := GtConnector new.
			gtconnector stencil: [ :entity |
				| uml tabGroup aCloseButton connectorTable aConnectorButton aDetailsButton header text textElement aBottomResizer aRightResizer|
				
				uml := BlElement new.
				uml size: 300@300.
				uml layout: BlLinearLayout new beVertical.
				
				uml constraintsDo: [:c | c padding: (BlInsets top: 1 bottom: 1).].
				uml background: Color white;
					effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 5@5).
				
				uml connector 
					model: entity;
					beLayoutSource;
					beLayoutTarget;
					beVisualTarget.
				
				tabGroup := (entity gtViewsFor: GtPhlowView empty) asElementDo: [:e | e ].

				header := GtConnectorElement new.
				header layout: BlLinearLayout vertical alignCenter.
				header constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
				text := BlRopedText string: entity printString.

				textElement := BlTextElement new text: text asRopedText.
			
				header addChild: textElement.
				textElement constraintsDo: [ :c | c padding: (BlInsets top:25) ].	
			
				connectorTable := self gtObjectConnectorTableIn: gtconnector.
				
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
					uml addChild: aDetailsButton
				].
				aDetailsButton action: [ 
					uml removeChild: aCloseButton. 
					uml removeChild: header. 
					uml removeChild: connectorTable. 
					uml addChild: tabGroup. 
					uml addChild: aCloseButton. 
					uml removeChild: aDetailsButton. 
					uml addChild: aConnectorButton 
				].
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
			gtconnector addEntity: self.
			gtconnector asPannableElement ]
]

{ #category : #'*GToolkit-Connector' }
Object >> gtObjectConnectorTableIn: connector [
	| variableNodes list |
	variableNodes := OrderedCollection new: self class allSlots size.
	self gtInspectorVariableNodesIn: variableNodes.

	list := BrColumnedList new items: variableNodes.
	list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
	list column
		title: 'Icon';
		stencil: [ :aNode :index |
			| icon |
			icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
				on: Error
				do: [ :error | self iconNamed: #smallWarningIcon ]).
			icon asElement].
	list column
		title: 'Variable';
		stencil: [ :aNode :index |
			| textElement text  |
			text := aNode label asRopedText.
			textElement :=  (BrColumnCellLabelStencil matchParent: text) asElement.
			textElement constraintsDo: [ :c | c padding: (BlInsets left: 10). c padding: (BlInsets top: 5 bottom:  5) ].
			textElement ].
	list column
		title: 'Value';
		stencil: [ :aNode :index |
			| text textElement container |
			text := [ aNode rawValue gtDisplayString asRopedText ]
				on: Error
				do: [ aNode errorMessage asRopedText foreground: Color red ].
			textElement := (BrColumnCellLabelStencil fitContent: text) asElement.
			textElement constraintsDo: [ :c | c padding: (BlInsets right: 10) ].

			container := BlElement new.
			aNode rawValue = aNode hostObject ifFalse: [
				container connector model: aNode rawValue ].
			
			container layout: BlLinearLayout vertical.
			container addChild: textElement.
			container connector beVisualSource.	
			container 
				when: BlDoubleClickEvent 
				do: [ :event | connector addEntity: aNode rawValue ].
			container constraintsDo: [:c | 
				c vertical fitContent. 
				c horizontal matchParent. 
				c padding: (BlInsets top: 1 bottom: 1).].
			container ].
	^ list
]
