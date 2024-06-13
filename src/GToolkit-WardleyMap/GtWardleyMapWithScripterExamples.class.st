Class {
	#name : #GtWardleyMapWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapModelExamples new newMapWithPipelineInnerNodes ]
			element: [ :aModel | 
				GtWardleyMapCanvasElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aModel) ].	"Ensure an extent to compute exact node positions, dragging, etc."
	aScripter
		doStep: [ :s | 
			s
				label: 'Ensure 800 @ 600 space extent';
				block: [ :aSpace | aSpace extent: 800 @ 600 ];
				onSpace ].

	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_assertInitialWidgetPositions [
	<gtExample>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		checks: 'Assert widget positions'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Node A position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 194.0 @ 444.0 corner: 206.0 @ 456.0 ];
						id: (#node asBlocElementId indexed: 0) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node B position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 394.0 @ 144.0 corner: 406.0 @ 156.0 ];
						id: (#node asBlocElementId indexed: 1) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node C position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 594.0 @ 294.0 corner: 606.0 @ 306.0 ];
						id: (#node asBlocElementId indexed: 2) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node D position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 154.0 @ 460.0 corner: 166.0 @ 472.0 ];
						id: (#node asBlocElementId indexed: 3) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node F position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 322.0 @ 450.0 corner: 334.0 @ 462.0 ];
						id: (#node asBlocElementId indexed: 5) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node G position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 298.0 @ 462.0 corner: 310.0 @ 474.0 ];
						id: (#node asBlocElementId indexed: 6) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Pipeline A position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 152.0 @ 456.0 corner: 248.0 @ 476.0 ];
						id: (#pipeline asBlocElementId indexed: 7) ] ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_mouseOverLabelA [
	<gtExample>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Node A hovering'
		do: [ :aStep | 
			aStep
				mouseMoveOverStep: [ :s | 
					s
						label: 'Hover Node A';
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node A is highlighted';
						value: [ :aNodeElement | aNodeElement background ]
							equals: [ Color gray asBlBackground ];
						id: (#node asBlocElementId indexed: 0);
						/ #node ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Label A is highlighted';
						value: [ :aLabelElement | 
								aLabelElement text iterator
									detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
									ifFound: [ :that | that paint ]
									ifNone: [ nil ] ]
							equals: [ GtWardleyMapConstants hoverColor ];
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ] ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_mouseOverNodeA [
	<gtExample>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Node A hovering'
		do: [ :aStep | 
			aStep
				mouseMoveOverStep: [ :s | 
					s
						label: 'Hover Node A';
						id: (#node asBlocElementId indexed: 0) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node A is highlighted';
						value: [ :aNodeElement | aNodeElement background ]
							equals: [ GtWardleyMapConstants hoverColor asBlBackground ];
						id: (#node asBlocElementId indexed: 0);
						/ #node ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Label A is highlighted';
						value: [ :aLabelElement | 
								aLabelElement text iterator
									detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
									ifFound: [ :that | that paint ]
									ifNone: [ nil ] ]
							equals: [ GtWardleyMapConstants hoverColor ];
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ] ].


	^ aScripter
]
