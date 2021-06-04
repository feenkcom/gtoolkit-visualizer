"
I create a UML class element with two containers for class attributes and methods


"
Class {
	#name : #GtDiagrammerUmlClassWithAttributesAndMethodsStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : #'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerUmlClassWithAttributesAndMethodsStencil >> create [
	| uml |
	uml := BrUmlClassElement withContainers: #(label attributes methods).

	uml text: 'ClassName' asRopedText bold in: #label.
	uml text: 'Attribute', String cr, 'Attribute' asRopedText in: #attributes.
	uml text: 'Operation', String cr, 'Operation' asRopedText in: #methods.

	uml relocate: 100@100.
	uml constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent ].
	^ uml
]
