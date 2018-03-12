*GToolkit-Diagrammer
editorForFromArrowHeadIn: anEditor

	^ GtDiagrammerArrowheadPicker new
		select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ nil ]) class;
		when: GtDiagrammerPickerSelected
			do: [ :anEvent |
				| aHead |
				aHead := anEvent entity new.
				aHead border: (self border copy).
				self fromHead: aHead.
				anEditor changed ]