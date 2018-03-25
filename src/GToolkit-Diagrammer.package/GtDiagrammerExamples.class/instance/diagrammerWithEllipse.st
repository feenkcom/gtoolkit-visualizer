examples
diagrammerWithEllipse
	<gtExample>
	| aDiagrammer anEllipse |
	
	aDiagrammer := self diagrammer.
	anEllipse := self ellipseStencil.
	
	aDiagrammer canvas addChild: (anEllipse relocate: 100@100).
	
	^ aDiagrammer