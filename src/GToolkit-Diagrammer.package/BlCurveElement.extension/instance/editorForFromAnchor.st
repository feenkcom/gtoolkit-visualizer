*GToolkit-Diagrammer
editorForFromAnchor

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