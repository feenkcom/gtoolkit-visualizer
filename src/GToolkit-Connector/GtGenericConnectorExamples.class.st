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
	connector stencil: [ :data | (BlEllipse diameter: 30) asElement
		background: (Color gray alpha: 0.1);
		border: (BlBorder paint: (Color blue alpha: 0.2) width: 2).
	].
	connector connectionsStencil: [ :element :entity |
		| dotButton |
		dotButton := (BlEllipse diameter: 10) asElement background: (Color black).
		dotButton constraintsDo: [ :c |
				c frame vertical alignTop.
				c frame horizontal alignLeft.
		].
	dotButton relocate: 5 @ 5.
		element addChild: dotButton.
	].
	connector addEntity: 1.
	^ connector
]
