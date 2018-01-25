actions
deselect
	resizer detach.
	(self canvas hasChild: resizer)
		ifTrue: [ self canvas removeChild: resizer ].