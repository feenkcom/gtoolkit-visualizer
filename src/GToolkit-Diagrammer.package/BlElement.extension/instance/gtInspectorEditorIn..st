*GToolkit-Diagrammer
gtInspectorEditorIn: aComposite
	<gtInspectorPresentationOrder: 12>
	^ aComposite bloc
		title: 'Editor';
		element: [ | theEditors container |
			theEditors := GtDiagrammerFigureEditor editorsOf: self.
			
			container := BlElement new.
			container layout: BlLinearLayout vertical.
			container constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			theEditors do: [ :anEditor |
				| aTitle |
				aTitle := BlTextEditElement new text: (anEditor title asRopedText).
				aTitle margin: (BlInsets all: 5). 
				container addChild: aTitle.
				container addChild: anEditor editor ].
			
			container ]