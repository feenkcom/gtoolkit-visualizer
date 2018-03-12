accessing
editor: anEditor

	itemElement title: anEditor title.
	itemElement content: (anEditor allEditorsThatMeetCondition
		ifEmpty: [ anEditor editor ]
		ifNotEmpty: [ :theEditors |
			| aContainer |
			
			aContainer := BlElement new.
			aContainer background: (Color lightGray alpha: 0.1).
			aContainer layout: (BlLinearLayout  vertical"cellSpacing: 10").
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ].

			aContainer addChild: anEditor editor.
			aContainer addChildren: (theEditors collect: [ :eachEditor | self renderEditor: eachEditor ]).
			aContainer ])