*GToolkit-Diagrammer
editorForFromArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ BlArrowheadNone new ]);
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				anEvent model applyAsFromHeadOn: self.
				anEditor changed ]