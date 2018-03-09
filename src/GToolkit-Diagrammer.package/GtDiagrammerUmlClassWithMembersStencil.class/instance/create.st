instance creation
create
	| uml |
	uml := GtDiagrammerUmlClassElement withContainers: #(label attributes).

	uml text: 'ClassName' asRopedText bold in: #label.
	uml text: 'Attribute', String cr, 'Attribute' asRopedText in: #attributes.

	uml relocate: 100@100.
	uml constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent ].
	^ uml