Class {
	#name : #GtExampleSpawnerExamples,
	#superclass : #BrRBTextStyler,
	#category : 'GToolkit-Connector'
}

{ #category : #'as yet unclassified' }
GtExampleSpawnerExamples >> initialSketch [
	<gtExample>
	| scalableElement root spawner newMethod line edge styler editor editorElement |
	scalableElement := BlScalableElement new.
	scalableElement maxScale: 2.0.
	scalableElement minScale: 0.5.

	root := BlElement new.
	scalableElement contentElement: root.
	root constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	scalableElement constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	spawner := [ :method | 
		text := method sourceCode asRopedText.
		styler := GtConnectorExampleStyler new 
			exampleAction: [ :exampleMethod :messageNode :button |
				newMethod := spawner value: exampleMethod.
				line := BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.2) width: 5).
				line
					fromAnchor: (BlElementCenterAnchor element: button button);
					toAnchor: (BlElementCenterLeftAnchor element: newMethod).
				line constraints ignoreByLayout.
				root addChild: line.
				root addChild: newMethod.
				edge := GtGraphEdge new from: (button button
							deep: #parent
							select: [ :each | each isKindOf: BrEditorElement ]) first to: newMethod.
				button button constraints graph addConnectedEdge: edge.
				newMethod constraints graph addConnectedEdge: edge ];
			classOrMetaClass: GtDummyExamplesOnClassSide class.
		editor := BrTextEditor new.
		editor styler: styler.
		editor text: text.
		editorElement := BrEditorElement new.
		editorElement constraintsDo: [ :c |
		    c horizontal fitContent.
		    c vertical fitContent ].
		editorElement editor: editor ].
	root addChild: (spawner value: GtDummyExamplesOnClassSide class>>#ppp).
	root layout: (GtGraphHorizontalTreeLayout new horizontalGap: 100; layered).
	^ scalableElement
]
