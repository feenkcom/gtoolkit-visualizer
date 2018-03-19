api - diagrammer
instantiate: aStencil at: aPoint in: aCanvasElement
	<return: #BlElement>
	| anElement |

	anElement := aStencil create.

	"we need to force layout process of the element in order to relocate it in such a way that its center is at aPoint"
	anElement forceLayout.
	anElement relocate: aPoint - (anElement extent / 2.0) asIntegerPoint.

	anElement addEventHandler: BlPullHandler new.
	anElement
		addEventHandlerOn: BlElementSelectionAcquiredEvent
		do: [ :anEvent | aCanvasElement select: anEvent currentTarget ].
	anElement
		addEventHandlerOn: BlElementSelectionLostEvent
		do: [ :anEvent | aCanvasElement deselect ].

	aCanvasElement addChild: anElement.

	^ anElement