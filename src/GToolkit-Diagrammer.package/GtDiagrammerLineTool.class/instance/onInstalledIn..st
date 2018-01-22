api - hooks
onInstalledIn: aDiagrammerElement
	connector := BlEventHandler on: BlClickEvent do: [ :anEvent |
		(anEvent target hasParent: aDiagrammerElement canvas)
			ifTrue: [ 
				| theParents |
				theParents := Array streamContents: [ :aStream |
					aStream nextPut: anEvent target.
					anEvent target parentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].
				theParents
					detect: [ :anElement | anElement parent = aDiagrammerElement canvas ]
					ifFound: [ :aFigure |
						anEvent consumed: true.
						fromFigure
							ifNil: [ fromFigure := aFigure ]
							ifNotNil: [
								self connect: fromFigure and: aFigure in: aDiagrammerElement canvas.
								fromFigure := nil ] ]
					ifNone: [ fromFigure := nil ] ]
			ifFalse: [ fromFigure := nil ] ].

	aDiagrammerElement canvas addEventFilter: connector