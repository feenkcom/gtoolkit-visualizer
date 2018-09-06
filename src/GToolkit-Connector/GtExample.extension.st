Extension { #name : #GtExample }

{ #category : #'*GToolkit-Connector' }
GtExample >> gtConnectionsFor: aView [
	^ (super gtConnectionsFor: aView) explicit
		title: 'Connections';
		stencil: [	
			| gtconnector aBottomResizer aRightResizer |
			gtconnector := GtGenericConnector new.
			gtconnector stencil: [ :method |
				| editorElement styler text editor vocalEditorContainer vocalVisualTarget aGoButton exampleContainer |
				vocalEditorContainer := VocalBlElement new.
				vocalEditorContainer connector beLayoutSource.
				vocalEditorContainer connector beLayoutTarget.
				vocalEditorContainer connector model: method.
				vocalEditorContainer size: 400@200.
				vocalEditorContainer layout: BlLinearLayout horizontal.
				vocalEditorContainer
					background: Color white;
					effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).
				editorElement := BrEditorElement new.
				editorElement
					constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent.
					c padding: (BlInsets all: 10) ].
				vocalVisualTarget := VocalBlElement new.
				vocalVisualTarget
					constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].
				
				vocalVisualTarget connector beVisualTarget.
				vocalVisualTarget connector model: method.
				vocalVisualTarget addChild: editorElement.

				styler := GtConnectorExampleStyler new.
				styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
				styler classOrMetaClass: method methodClass.
				styler addEventHandler: (GtConnectorStylerListener new connector: gtconnector).

				editor := BrTextEditor new.
				editor styler: styler.
				editorElement editor: editor.

				text := method sourceCode asRopedText.

				"because we connect editors with lines based on styler we must change text
				only after editor is added to the scene, otherwise events will be ignored"
				editor text: text.	
				aBottomResizer := BlElement new
					look: BrGlamorousResizerBottomBarLook new;
					addEventHandler: (BlResizerBottomListener new resizeTarget: vocalEditorContainer; minimumExtent: 0@75).
				aRightResizer := BlElement new
					look: BrGlamorousResizerRightBarLook new;
					addEventHandler: (BlResizerRightListener new resizeTarget: vocalEditorContainer; minimumExtent: 75@0).
					
				aGoButton := GtInspectorRoundButtonStencil new asElement
					icon: (BrGlamorousIcons go asElement);
					constraintsDo: [ :c |
						c ignoreByLayout.
						c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0).
						c ignored horizontal alignRight.
						c ignored vertical alignTop ];
					action: [ :e | 
						|  examplePreview  |
						"examplePreview background: Color black."
						exampleContainer isNil ifTrue: [ 
							exampleContainer := BlElement new.
							exampleContainer clipChildren: false.
							examplePreview := (self runThenDo: [ :r | r returnValue ] onErrorDo: [ :r | r ]).
							exampleContainer size: 80@80.
							exampleContainer constraintsDo: [ :c |
								"c ignoreByLayout."
								c margin: (BlInsets top: 0 left: 0 bottom: 0 right: -80).
								c ignored horizontal alignRight.
								c ignored vertical alignTop ].
							exampleContainer addChild: examplePreview.
							examplePreview constraintsDo: [ :c |
								c ignoreByLayout.
								c margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0).
								c ignored horizontal alignLeft.
								c ignored vertical alignTop.
							].
							vocalEditorContainer addChild: exampleContainer.
						] ifFalse: [ vocalEditorContainer removeChild: exampleContainer. exampleContainer := nil. ].
						
					].

				vocalEditorContainer addChild: vocalVisualTarget.
				vocalEditorContainer addChild: aBottomResizer.
				vocalEditorContainer addChild: aRightResizer.
				vocalEditorContainer addChild: aGoButton.
				vocalEditorContainer clipChildren: false.
				vocalEditorContainer 
			].
			gtconnector addEntity: self method.
			gtconnector asPannableElement ] 
]

{ #category : #'*GToolkit-Connector' }
GtExample >> gtInspectorBlocConnectedExamplesIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite bloc
		title: 'Connected (Bloc)';
		element: [ 
			| connector |
			connector := GtConnector new.
			connector addMethod: self method.
			connector asScalableElement ]
]
