hooks
onInstantiated: aFigureElement in: aDiagrammerElement
	"Is sent after an element was instantiated and added to the diagrammer"

	aDiagrammerElement select: aFigureElement.
	aDiagrammerElement edit: aFigureElement