api - hooks
onInstalledIn: aDiagrammerElement

	aDiagrammerElement canvas addEventHandler: selector.
	
	chooser := BlEventHandler on: BlMouseDownEvent do: [ :anEvent |
		| theParents |
				
		theParents := Array streamContents: [ :aStream |
			aStream nextPut: anEvent target.
			anEvent target parentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].
		
		theParents
			detect: [ :anElement | anElement parent = aDiagrammerElement canvas ]
			ifFound: [ :aFigure | aDiagrammerElement select: aFigure ]
			ifNone: [ aDiagrammerElement deselect ] ].
		
	editor := BlEventHandler on: BlMouseUpEvent do: [ :anEvent |
		| theParents |

		theParents := Array streamContents: [ :aStream |
			aStream nextPut: anEvent target.
			anEvent target parentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].

		theParents
			detect: [ :anElement | anElement parent = aDiagrammerElement canvas ]
			ifFound: [ :aFigure | aDiagrammerElement edit: aFigure ]
			ifNone: [ aDiagrammerElement closeEditor ] ].
	
	aDiagrammerElement canvas addEventHandler: chooser.
	aDiagrammerElement canvas addEventHandler: editor