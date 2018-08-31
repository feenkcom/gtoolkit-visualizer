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
		| labelButton container| 
		container := VocalBlElement new.
		container geometry: (BlEllipse diameter: 30).
		"container gtConnector: gtconnector."
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
		container 
	].

	gtconnector connectionsStencil: [ :element :entity |
		| dotButton buttonElement buttonContainer |			
		buttonContainer := VocalBlElement new.	
		buttonContainer size: 5 @ 5.
		
		buttonElement := (BlEllipse diameter: 5) asElement background: (Color black).
		dotButton := BrButton new.
		dotButton icon: buttonElement.
		dotButton look: BrIconLook.
		dotButton size: 5 @ 5.
		dotButton action: [ gtconnector addEntity: entity + 1. gtconnector addEntity: entity + 2.  ].
		buttonContainer relocate: 10 @ 10.
		buttonContainer addChild: dotButton.
		
		element addChild: buttonContainer.
		"buttonContainer gtConnector: gtconnector."
		buttonContainer connector beVisualSource; model: entity + 1.
	].

	gtconnector addEntity: 1.
	gtconnector addEntity: 2.
	gtconnector addEntity: 3.
	gtconnector addEntity: 5.
	^ gtconnector
]

{ #category : #examples }
GtGenericConnectorExamples >> oneSimpleExample [
	<gtExample>
	| gtconnector |
	gtconnector := GtGenericConnector new.
	
	gtconnector stencil: [ :data |
		| ellipse labelButton| 
		ellipse := (BlEllipse diameter: 30) asElement
		background: (Color gray alpha: 0.1);
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
		 
		labelButton := BrButton new.
		labelButton look: BrLabelLook.
		labelButton label: data.
		labelButton layout: BlFrameLayout new.
		labelButton constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ].
		labelButton connector target: data.
		labelButton relocate: 10 @ 10.
		ellipse addChild: labelButton.
		ellipse 
	].

	gtconnector connectionsStencil: [ :element :entity |
		| dotButton buttonElement |				
		buttonElement := (BlEllipse diameter: 5) asElement background: (Color black).
		dotButton := BrButton new.
		dotButton icon: buttonElement.
		dotButton look: BrIconLook.
		dotButton size: 5 @ 5.
		dotButton action: [ gtconnector addEntity: entity + 1 ].
		dotButton relocate: 5 @ 5.
		element addChild: dotButton.
		
		dotButton connector source: entity.
		dotButton connector target: entity + 1.
	].

	gtconnector addEntity: 1.
	^ gtconnector
]
