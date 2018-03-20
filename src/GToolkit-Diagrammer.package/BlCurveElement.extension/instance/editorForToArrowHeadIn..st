*GToolkit-Diagrammer
editorForToArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ BlArrowheadNone new ]);
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				anEvent model applyAsToHeadOn: self.
				anEditor changed ]