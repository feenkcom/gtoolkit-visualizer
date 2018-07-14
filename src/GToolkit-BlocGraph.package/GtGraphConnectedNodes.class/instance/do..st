api - enumeration
do: aBlock
	edges do: [ :aGtGraphEdge |
		"we don't want to include a node from which we asked for edges"
		(aGtGraphEdge fromElement ~= self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge fromElement ].
		(aGtGraphEdge toElement ~= self graphElement element)
			ifTrue: [ aBlock value: aGtGraphEdge toElement ] ]