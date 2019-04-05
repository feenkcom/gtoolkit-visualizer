Extension { #name : #GtExample }

{ #category : #'*GToolkit-Connector' }
GtExample >> buildBlankContainer: method [
	|container|
	container := VocalBlElement new.
	container 
		connector 
			beLayoutSource; 
			beLayoutTarget;
			beVisualTarget;
			model: method.

	container 
		size: 400@200; 
		"border: (BlBorder paint: (BrGlamorousColors editorBorderColor) width: 1);"
		background: Color white;
		look: BrShadowLook new;
		layout: BlLinearLayout new.
	^ container
]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildBottomResizerFor: blankContainer [
	^  BlElement new
			look: BrGlamorousResizerBottomBarLook new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c vertical exact: 5. c grid horizontal span: 2];
			addEventHandler: (BlResizerBottomListener new resizeTarget: blankContainer; minimumExtent: 0@75).

]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildCloseButton: gtconnector. [ 
	^ GtInspectorRoundButtonStencil new asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e | gtconnector removeChild: e parent ].
				
			
]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildEditor: aMethod for: gtconnector [
	| vocalVisualTarget styler editorElement editor text |
	vocalVisualTarget:= VocalBlElement new.
	vocalVisualTarget
		constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
				
	styler := GtConnectorExampleStyler new.
	styler exampleAction: [ :anExampleMethod | gtconnector addEntity: anExampleMethod ].
	styler classOrMetaClass: aMethod methodClass.
				
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 10) ].
	editor := BrTextEditor new.
	editor styler: styler.
	editorElement editor: editor.	
	text := aMethod sourceCode asRopedText glamorousCodeFontDo: #beNotOverwritableByStyler.

	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editor text: text.	
	vocalVisualTarget addChild: editorElement.

	^ vocalVisualTarget.
					
]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildInspectButton: vocalEditorContainer [
	| aGoButton |
	aGoButton := GtInspectorRoundButtonStencil new asElement
		icon: (BrGlamorousIcons inspect asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: 0).
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ].
	^ aGoButton.
]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildRightResizerFor: blankContainer [
	^  BlElement new
			look: BrGlamorousResizerRightBarLook new;
			background: BrGlamorousColors editorBorderColor;
			constraintsDo: [ :c | c margin: (BlInsets right: 0). c horizontal exact: 5.];
			addEventHandler: (BlResizerRightListener new resizeTarget: blankContainer; minimumExtent: 75@0).

]

{ #category : #'*GToolkit-Connector' }
GtExample >> buildSourceButton: vocalEditorContainer [
	| aGoButton |
	aGoButton := GtInspectorRoundButtonStencil new asElement
		icon: (BrGlamorousIcons file asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: 0).
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ].
	^ aGoButton.
]

{ #category : #'*GToolkit-Connector' }
GtExample >> gtConnectionsFor: aView [
	^ aView explicit
		title: 'Connections';
		stencil: [	
			| gtconnector  |
			gtconnector := GtConnector new.
			gtconnector stencil: [ :method |
				| blankContainer vocalEditorContainer vocalVisualTarget playButton examplePreview sourceButton aBottomResizer aRightResizer aCloseButton|
				"The blankContainer is there as a placeholder for toggling between the source and the output of the example."
				
				blankContainer := self buildBlankContainer: method.
				blankContainer clipChildren: false.
				vocalEditorContainer := self vocalEditorContainer.
				vocalVisualTarget := self buildEditor: method for: gtconnector.
				vocalEditorContainer addChild: vocalVisualTarget.
				aRightResizer := self buildRightResizerFor: blankContainer.
				aBottomResizer := self buildBottomResizerFor: blankContainer.
				playButton := self buildInspectButton: vocalEditorContainer.
				sourceButton := self buildSourceButton: vocalEditorContainer.
				aCloseButton := self buildCloseButton: gtconnector. 
				
				blankContainer addChild: vocalEditorContainer.
				blankContainer addChild: aRightResizer.
				blankContainer addChild: aBottomResizer.
				blankContainer addChild: playButton.
				blankContainer addChild: aCloseButton.
				examplePreview := (method gtExample returnValue gtViewsFor: GtPhlowView empty) asElementDo: [:e | e ].
				
				sourceButton action: [
					blankContainer removeChild: examplePreview.
					blankContainer removeChild: aRightResizer.
					blankContainer removeChild: aBottomResizer.
					blankContainer removeChild: sourceButton.
					blankContainer removeChild: aCloseButton.
					blankContainer addChild: vocalEditorContainer.
					blankContainer addChild: aRightResizer.
					blankContainer addChild: aBottomResizer.
					blankContainer addChild: playButton.
					blankContainer addChild: aCloseButton.].
				
				playButton action: [
					blankContainer removeChild: vocalEditorContainer.
					blankContainer removeChild: aRightResizer.
					blankContainer removeChild: aBottomResizer.
					blankContainer removeChild: playButton.
					blankContainer removeChild: aCloseButton.
					blankContainer addChild: examplePreview.
					blankContainer addChild: aRightResizer.
					blankContainer addChild: aBottomResizer.
					blankContainer addChild: aCloseButton.
					blankContainer addChild: sourceButton.
				].
				blankContainer
			].
			gtconnector addEntity: self method.
			gtconnector asPannableElement ]
]

{ #category : #'*GToolkit-Connector' }
GtExample >> vocalEditorContainer [
	|vocalEditorContainer|
	vocalEditorContainer := VocalBlElement new.
	vocalEditorContainer constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent. ].
	vocalEditorContainer layout: BlLinearLayout new.
	^ vocalEditorContainer
]
