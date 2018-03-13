*GToolkit-Diagrammer
editorForToArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ nil ]) class;
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				| aHead |
				aHead := anEvent model new.
				aHead border: (self border copy).
				self toHead: aHead.
				anEditor changed ]