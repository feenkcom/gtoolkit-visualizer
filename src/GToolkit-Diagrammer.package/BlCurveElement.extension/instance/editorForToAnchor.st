*GToolkit-Diagrammer
editorForToAnchor

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