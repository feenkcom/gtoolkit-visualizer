instance creation
create
	| uml |
	uml := GtDiagrammerUmlClassElement withContainers: #(label attributes methods).

	uml text: 'ClassName' asRopedText bold in: #label.
	uml text: 'Attribute', String cr, 'Attribute' asRopedText in: #attributes.
	uml text: 'Operation', String cr, 'Operation' asRopedText in: #methods.

	uml relocate: 100@100.
	uml constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent ].
	^ uml