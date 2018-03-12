*GToolkit-Diagrammer
editorForToArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ nil ]) class;
		when: GtDiagrammerPickerSelected
			do: [ :anEvent |
				| aHead |
				aHead := anEvent entity new.
				aHead border: (self border copy).
				self toHead: aHead.
				anEditor changed ]