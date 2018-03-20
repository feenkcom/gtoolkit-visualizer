api - diagrammer
instantiate: aStencil at: aPoint in: aTarget
	<return: #BlElement>
	| anElement |

	anElement := aStencil create.

	"we need to force layout process of the element in order to relocate it in such a way that its center is at aPoint"
	anElement forceLayout.
	
	(anElement extent) > (aTarget extent / 2.0)
		ifTrue: [
			anElement size: aTarget extent / 2.0.
			anElement forceLayout ].
	
	anElement relocate: aPoint - (anElement extent / 2.0) asIntegerPoint.
	anElement addEventHandler: BlPullHandler new.

	aTarget addChild: anElement.

	^ anElement