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
GtGenericConnectorExamples >> oneSimpleExample [
	<gtExample>
	| connector |
	connector := GtGenericConnector new.
	
	connector stencil: [ :data |
		| ellipse labelButton| 
		ellipse := (BlEllipse diameter: 30) asElement
		background: (Color gray alpha: 0.1);
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
		 
		labelButton := BrButton new.
		labelButton look: BrLabelLook.
		labelButton label: data.
		labelButton layout: BlFrameLayout new.

		labelButton relocate: 10 @ 10.
		ellipse addChild: labelButton.
		ellipse 
	].

	connector connectionsStencil: [ :element :entity |
		| dotButton buttonElement |				
		buttonElement := (BlEllipse diameter: 5) asElement background: (Color black).
		dotButton := BrButton new.
		dotButton icon: buttonElement.
		dotButton look: BrIconLook.
		dotButton size: 5 @ 5.
		dotButton action: [ connector addEntity: entity + 1 ].
		dotButton relocate: 5 @ 5.
		element addChild: dotButton.
		
		dotButton connector source: entity.
		dotButton connector target: entity + 1.
	].

	connector addEntity: 1.
	^ connector
]
