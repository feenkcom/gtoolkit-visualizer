Extension { #name : #Object }

{ #category : #'*GToolkit-Connector' }
Object >> gtConnectionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Connections';
		priority: 110;
		stencil: [
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
			
				connectorTable := GtGenericConnectorExamples new rawObjectConnectorTableFor: entity in: gtconnector.
				
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
			gtconnector addEntity: self.
			gtconnector asPannableElement ]
]
