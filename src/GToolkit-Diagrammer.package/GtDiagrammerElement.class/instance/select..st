actions
select: anElement

	resizer attachTo: anElement.
	(self canvas hasChild: resizer)
		ifFalse: [ self canvas addChild: resizer ].