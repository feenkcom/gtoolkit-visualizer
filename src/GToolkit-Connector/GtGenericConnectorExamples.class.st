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
