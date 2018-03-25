examples
diagrammerWithSelectedEllipse
	<gtExample>
	| aDiagrammer anEllipse |
	
	aDiagrammer := self diagrammerWithEllipse.
	anEllipse := aDiagrammer canvas children first.
	aDiagrammer select: anEllipse.

	^ aDiagrammer