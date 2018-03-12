*GToolkit-Diagrammer
editorForFromArrowHeadIn: anEditor
	| aPicker |

	aPicker := GtDiagrammerArrowheadPicker new.
	aPicker select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ nil ]) class.
	aPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			| aHead |
			aHead := anEvent entity new.
			aHead border: (self border copy).
			self fromHead: aHead.
			anEditor changed ].	

	^ aPicker