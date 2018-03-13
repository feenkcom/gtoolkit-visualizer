*GToolkit-Diagrammer
editorForFromArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ nil ]) class;
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				| aHead |
				aHead := anEvent model new.
				aHead border: (self border copy).
				self fromHead: aHead.
				anEditor changed ]