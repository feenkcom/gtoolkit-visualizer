enumeration
allEditorsThatMeetCondition
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ Array streamContents: [ :aStream |
		self editors do: [ :anEditor |
			anEditor meetsCondition
				ifTrue: [
					aStream nextPut: anEditor.
					aStream nextPutAll: anEditor allEditorsThatMeetCondition ] ] ]