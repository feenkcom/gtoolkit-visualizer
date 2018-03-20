api - hooks
onInstalledIn: aDiagrammerElement
	super onInstalledIn: aDiagrammerElement.

	connector := BlEventHandler on: BlClickEvent do: [ :anEvent |
		(anEvent target hasParent: aDiagrammerElement canvas)
			ifTrue: [ 
				anEvent consumed: true.
				fromFigure
					ifNil: [ fromFigure := anEvent target ]
					ifNotNil: [
						| aLine |
						aLine := self connect: fromFigure and: anEvent target in: aDiagrammerElement canvas.
						aDiagrammerElement tool: GtDiagrammerSelectionTool new.
						aDiagrammerElement select: aLine.
						aDiagrammerElement edit: aLine.
							
						fromFigure := nil ]
				
				
				"| theParents |
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
								| aLine |
								aLine := self connect: fromFigure and: aFigure in: aDiagrammerElement canvas.
								aDiagrammerElement tool: GtDiagrammerSelectionTool new.
								aDiagrammerElement select: aLine.
								aDiagrammerElement edit: aLine.
								
								fromFigure := nil ] ]
					ifNone: [ fromFigure := nil ]" ]
			ifFalse: [ fromFigure := nil ] ].

	hoverOver := BlEventHandler on: BlMouseOverEvent do: [ :anEvent |
		(anEvent target ~= self canvas)
			ifTrue: [
				overlay attachTo: anEvent target.
				overlay hasParent ifFalse: [ self canvas addChild: overlay ] ] ].

	hoverOut := BlEventHandler
		on: BlMouseOutEvent
		do: [ :anEvent |
			(anEvent target ~= self canvas)
				ifTrue: [
					overlay detach.
					overlay removeFromParent ] ].


	aDiagrammerElement canvas addEventFilter: connector.
	aDiagrammerElement canvas addEventHandler: hoverOver.
	aDiagrammerElement canvas addEventHandler: hoverOut