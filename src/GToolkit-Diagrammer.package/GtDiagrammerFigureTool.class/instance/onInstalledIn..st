api - hooks
onInstalledIn: aDiagrammerElement
	super onInstalledIn: aDiagrammerElement.
	
	creator := BlEventHandler on: BlClickEvent do: [ :anEvent |
		| aLocation aFigureElement aTargetElement |
		
		aTargetElement := anEvent target.
		
		"`anEvent currentTarget` is already a canvas"
		aLocation := aTargetElement globalPointToLocal: anEvent position.

		aFigureElement := self
			instantiate: self style
			at: aLocation
			in: aTargetElement.

		self onInstantiated: aFigureElement in: aDiagrammerElement ].
	
	hoverOver := BlEventHandler on: BlMouseOverEvent do: [ :anEvent |
		(anEvent target ~= self canvas)
			ifTrue: [
				overlay geometry: anEvent target geometry copy.
				overlay attachTo: anEvent target.
				overlay hasParent ifFalse: [ self canvas addChild: overlay ] ] ].

	hoverOut := BlEventHandler
		on: BlMouseOutEvent
		do: [ :anEvent |
			(anEvent target ~= self canvas)
				ifTrue: [
					overlay detach.
					overlay removeFromParent ] ].

	aDiagrammerElement canvas addEventHandler: creator.
	aDiagrammerElement canvas addEventHandler: hoverOver.
	aDiagrammerElement canvas addEventHandler: hoverOut