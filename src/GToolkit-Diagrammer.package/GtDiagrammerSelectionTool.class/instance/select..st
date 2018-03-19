api - selection
select: anElement
	"Additionally select a given element.
	Note: I don't deselect already selected figures"

	self selectedFigures add: anElement.

	chooser currentSelection: anElement.

	resizer attachTo: anElement.
	resizer hasParent
		ifFalse: [ self canvas addChild: resizer ].

	self diagrammer edit: anElement.	
	
	anElement requestFocus