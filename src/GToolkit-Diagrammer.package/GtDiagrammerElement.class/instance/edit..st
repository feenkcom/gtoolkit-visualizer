actions
edit: anElement
	| theEditors theCards |

	sidebar removeChildrenIn: #editor.
	
	theEditors := GtDiagrammerFigureEditor editorsOf: anElement.
	
	theCards := theEditors collect: [ :anEditor |
		| aCard |
		aCard := GtDiagrammerTitledCard new.
		aCard title: anEditor title.
		aCard content: anEditor editor.
		aCard constraintsDo: [ :c | c horizontal matchParent ].		
		aCard ].

	sidebar addChildren: theCards in: #editor