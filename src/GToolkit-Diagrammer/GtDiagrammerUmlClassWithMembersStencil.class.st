"
I create a UML class element with a one container for class members (either attributes or methods)
"
Class {
	#name : #GtDiagrammerUmlClassWithMembersStencil,
	#superclass : #GtDiagrammerElementStencil,
	#category : 'GToolkit-Diagrammer-Stencils - Figures'
}

{ #category : #'instance creation' }
GtDiagrammerUmlClassWithMembersStencil >> create [
	| uml |
	uml := BrUmlClassElement withContainers: #(label attributes).

	uml text: 'ClassName' asRopedText bold in: #label.
	uml text: 'Attribute' asRopedText in: #attributes.

	uml relocate: 100@100.
	uml constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent ].
	^ uml
]
