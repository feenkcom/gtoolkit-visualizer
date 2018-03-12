enumeration
allEditors
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ Array streamContents: [ :aStream |
		self editors do: [ :anEditor |
			aStream nextPut: anEditor.
			aStream nextPutAll: anEditor allEditors ] ]