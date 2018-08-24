Extension { #name : #BlCurveElement }

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> diagrammerAnchorEditor: aComposite [
	<diagrammerEditor: 6>
		
	aComposite with
		title: 'Anchors';
		and: [ :newEditor |
			newEditor
				title: 'From anchor';
				editor: [ self editorForFromAnchor ] ];
		and: [ :newEditor |
			newEditor
				title: 'To anchor';
				editor: [ self editorForToAnchor ] ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> diagrammerArrowheadEditor: aComposite [
	<diagrammerEditor: 5>

	aComposite with
		title: 'Arrow heads';
		and: [ :newEditor |
			newEditor
				title: 'From head';
				editor: [ self editorForFromArrowHeadIn: newEditor ].
			newEditor with
				title: 'From head style';
				from: [ self fromHead ];
				when: [ self hasFromHead ] ];
		and: [ :newEditor |
			newEditor
				title: 'To head';
				editor: [ self editorForToArrowHeadIn: newEditor ].
			newEditor with
				title: 'To head style';
				from: [ self toHead ];
				when: [ self hasToHead ] ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> diagrammerBackgroundEditor: anEditor [
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> diagrammerGeometryEditor: aComposite [
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> editorForFromAnchor [

	^ GtDiagrammerRelativeGeometryAnchorPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: self fromAnchor class;
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				self fromAnchor: (anEvent model
					referenceElement: self fromAnchor referenceElement
					relatedTo: self toAnchor referenceElement) ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> editorForFromArrowHeadIn: anEditor [

	^ GtDiagrammerArrowheadPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: (self hasFromHead ifTrue: [ self fromHead ] ifFalse: [ BlArrowheadNone new ]);
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				anEvent model applyAsFromHeadOn: self.
				anEditor changed ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> editorForToAnchor [

	^ GtDiagrammerRelativeGeometryAnchorPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: self toAnchor class;
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				self toAnchor: (anEvent model
					referenceElement: self toAnchor referenceElement
					relatedTo: self fromAnchor referenceElement) ]
]

{ #category : #'*GToolkit-Diagrammer' }
BlCurveElement >> editorForToArrowHeadIn: anEditor [

	^ GtDiagrammerArrowheadPicker new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		select: (self hasToHead ifTrue: [ self toHead ] ifFalse: [ BlArrowheadNone new ]);
		when: BrToggleActivatedEvent
			do: [ :anEvent |
				anEvent model applyAsToHeadOn: self.
				anEditor changed ]
]
