instance creation
editorsOf: anObject
	| aComposite |

	aComposite := GtDiagrammerCompositeEditor new.
	self editorsOf: anObject in: aComposite.
	^ aComposite editors