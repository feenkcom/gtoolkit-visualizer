accessing
editor: anEditor
	
	anEditor hasVisualRepresentation
		ifTrue: [ itemElement background: Color white ]
		ifFalse: [ itemElement background: (Color veryLightGray alpha: 0.1) ].
	
	itemElement title: anEditor title.
	itemElement content: (anEditor allEditorsThatMeetCondition
		ifEmpty: [
			anEditor hasVisualRepresentation ifFalse: [ self error: 'Editor UI is not provided' ].
			anEditor editor ]
		ifNotEmpty: [ :theEditors |
			| aContainer |

			aContainer := BlElement new.
			aContainer layout: (BlGridLayout horizontal cellSpacing: 10; columnCount: 1).
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ].

			anEditor hasVisualRepresentation
				ifTrue: [ aContainer addChild: anEditor editor ].

			aContainer addChildren: (theEditors
				select: #hasVisualRepresentation
				thenCollect: [ :eachEditor | self renderEditor: eachEditor ]).
			aContainer ])