computing
editors
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ (self meetsCondition
		ifTrue: [ editors value ]
		ifFalse: [ #() ]) asOrderedCollection asArray