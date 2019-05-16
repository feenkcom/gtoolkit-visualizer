"
!How does Mondrian relate to Bloc

Let us consider a simple example with a visualization showing a few nodes:

${example:GtMondrianVsBlocExplanation>>#multipleNodes|previewExpanded=}$


Mondrian does not have its own internal model for representing the graph. Instead it builds directly an ${class:BlElement}$:

${example:GtMondrianVsBlocExplanation>>#rootWithMultipleNodes|previewExpanded=}$

The root element holds the elements that represent our nodes. Mondrian is only a shallow builder of elements and this offers quite some flexibility in customizing the rendering. For example, if we want to specify a custom element for each onde, we can do that like this:

${example:GtMondrianVsBlocExplanation>>#multipleNodesWithStencil|previewExpanded=}$


!!Working with Bloc

Mondrian being a builder for Bloc, also means that the same result can be obtained by working directly with Bloc:

${example:GtMondrianVsBlocExplanation>>#blocWithMultipleNodes|previewExpanded=}$


!!Dealing with edges

@@todo


"
Class {
	#name : #GtMondrianVsBlocExplanation,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #accessing }
GtMondrianVsBlocExplanation >> blocWithMultipleNodes [
	<gtExample>
	| root |
	root := BlElement new constraintsDo: [ :c |
	    c horizontal fitContent.
	    c vertical fitContent ].
	(1 to: 9) do: [ :x |
		root addChild: ( BlTextElement new text: x asString asRopedText )].
	root layout: (BlGridLayout new 
		columnCount: root children size sqrt asInteger;
		cellSpacing: 2).
	^ root asPannableElement
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> multipleNodes [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: (1 to: 9).
	m layout grid.
	^ m
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> multipleNodesWithStencil [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes 
		stencil: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (1 to: 9).
	m layout grid.
	^ m
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> rootWithMultipleNodes [
	<gtExample>
	| m |
	m := self multipleNodes.
	self assert: (m root isKindOf: BlElement).
	self assert: m root children size = 9.
	^ m root
]
