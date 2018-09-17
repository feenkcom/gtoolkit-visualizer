Extension { #name : #GtExample }

{ #category : #'*GToolkit-Connector' }
GtExample >> buildEditor: aMethod for: gtconnector [
	| vocalVisualTarget styler editorElement editor text |
	vocalVisualTarget:= VocalBlElement new.
	vocalVisualTarget
		constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
				
	vocalVisualTarget connector beVisualTarget.
	vocalVisualTarget connector model: aMethod.
				
	styler := GtConnectorExampleStyler new.
	styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
	styler classOrMetaClass: aMethod methodClass.
	styler addEventHandler: (GtConnectorStylerListener new connector: gtconnector).
				
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 10) ].
	editor := BrTextEditor new.
	editor styler: styler.
	editorElement editor: editor.	
	text := aMethod sourceCode asRopedText.

	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editor text: text.	
	vocalVisualTarget addChild: editorElement.

	^ vocalVisualTarget.
					
]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildRunButton: vocalEditorContainer [
	|aGoButton exampleContainer|
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
	^ aGoButton.
]

{ #category : #'*GToolkit-Connector' }
GtExample >> gtConnectionsFor: aView [
	^ (super gtConnectionsFor: aView) explicit
		title: 'Connections';
		stencil: [	
			| gtconnector aBottomResizer aRightResizer |
			gtconnector := GtGenericConnector new.
			gtconnector stencil: [ :method |
				| vocalEditorContainer vocalVisualTarget aGoButton |
				vocalEditorContainer := self vocalEditorContainer: method. 	
				vocalVisualTarget := self buildEditor: method for: gtconnector.
					
				aBottomResizer := BlElement new
					look: BrGlamorousResizerBottomBarLook new;
					addEventHandler: (BlResizerBottomListener new resizeTarget: vocalEditorContainer; minimumExtent: 0@75).
				aRightResizer := BlElement new
					look: BrGlamorousResizerRightBarLook new;
					addEventHandler: (BlResizerRightListener new resizeTarget: vocalEditorContainer; minimumExtent: 75@0).
					
				aGoButton := self buildRunButton: vocalEditorContainer.
				
				vocalEditorContainer addChild: vocalVisualTarget.
				vocalEditorContainer addChild: aRightResizer.
				vocalEditorContainer addChild: aBottomResizer.
				"vocalVisualTarget addChild: aGoButton."
				"vocalEditorContainer clipChildren: false."
				vocalEditorContainer
					background: Color white;
					effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).
				vocalEditorContainer 
			].
			gtconnector addEntity: self method.
			gtconnector asPannableElement ]
]

{ #category : #'*GToolkit-Connector' }
GtExample >> vocalEditorContainer: method [
	|vocalEditorContainer|
	vocalEditorContainer := VocalBlElement new.
	vocalEditorContainer connector beLayoutSource.
	vocalEditorContainer connector beLayoutTarget.
	vocalEditorContainer connector model: method.
	vocalEditorContainer size: 400@200.
	vocalEditorContainer layout: BlLinearLayout new.
	vocalEditorContainer
		background: Color white.
	^ vocalEditorContainer
]
