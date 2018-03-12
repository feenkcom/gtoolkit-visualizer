accessing
root
	<return: #GtDiagrammerFigureEditor>
	
	^ self hasParent
		ifTrue: [ self parent root ]
		ifFalse: [ self ]