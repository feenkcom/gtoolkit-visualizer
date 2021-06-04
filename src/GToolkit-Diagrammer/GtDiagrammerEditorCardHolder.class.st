"
I am an element holder for a card that represents an editor in the diagrammer editor list


"
Class {
	#name : #GtDiagrammerEditorCardHolder,
	#superclass : #BlInfiniteHolder,
	#category : #'GToolkit-Diagrammer-UI-Lists'
}

{ #category : #accessing }
GtDiagrammerEditorCardHolder >> editor: anEditor [
	
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
			aContainer layout: (BlGridLayout new cellSpacing: 10; columnCount: 1).
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ].

			anEditor hasVisualRepresentation
				ifTrue: [ aContainer addChild: anEditor editor ].

			aContainer addChildren: (theEditors
				select: #hasVisualRepresentation
				thenCollect: [ :eachEditor | self renderEditor: eachEditor ]).
			aContainer ])
]

{ #category : #initialization }
GtDiagrammerEditorCardHolder >> initialize [
	super initialize.

	itemElement := GtDiagrammerTitledCard new.
	itemElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #rendering }
GtDiagrammerEditorCardHolder >> renderEditor: anEditor [
	^ GtDiagrammerTitledCard new
		margin: (BlInsets empty);
		constraintsDo: [ :c | c horizontal matchParent ];
		border: BlBorder empty;
		title: anEditor title;
		titleTextDo: [ :aText | aText foreground: Color black ];
		content: anEditor editor
]
