*GToolkit-Diagrammer
editorForToArrowHeadIn: anEditor
	| aPicker |

	aPicker := GtDiagrammerArrowheadPicker new.
	aPicker select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ nil ]) class.
	aPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent |
			| aHead |
			aHead := anEvent entity new.
			aHead border: (self border copy).
			self toHead: aHead.
			anEditor changed ].	

	^ aPicker