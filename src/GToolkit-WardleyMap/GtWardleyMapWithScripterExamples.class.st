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
				GtWardleyMapElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aModel) ].
					
	"Ensure an extent to compute exact node positions, dragging, etc."
	aScripter do
		label: 'Ensure 800 @ 600 space extent';
		block: [ :aSpace | aSpace extent: 800 @ 600 ];
		onSpace;
		play.
	
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
			aStep assert
				label: 'Node A position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 194.0 @ 444.0 corner: 206.0 @ 456.0 ];
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep assert
				label: 'Node B position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 394.0 @ 144.0 corner: 406.0 @ 156.0 ];
				id: (#node asBlocElementId indexed: 1);
				play.

			aStep assert
				label: 'Node C position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 594.0 @ 294.0 corner: 606.0 @ 306.0 ];
				id: (#node asBlocElementId indexed: 2);
				play.

			aStep assert
				label: 'Node D position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 154.0 @ 460.0 corner: 166.0 @ 472.0 ];
				id: (#node asBlocElementId indexed: 3);
				play.

			aStep assert
				label: 'Node F position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 322.0 @ 450.0 corner: 334.0 @ 462.0 ];
				id: (#node asBlocElementId indexed: 5);
				play.

			aStep assert
				label: 'Node G position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 298.0 @ 462.0 corner: 310.0 @ 474.0 ];
				id: (#node asBlocElementId indexed: 6);
				play.

			aStep assert
				label: 'Pipeline A position';
				value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
					equals: [ 152.0 @ 456.0 corner: 248.0 @ 476.0 ];
				id: (#pipeline asBlocElementId indexed: 7);
				play ].


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
			aStep mouseMoveOver
				label: 'Hover Node A';
				id: (#node asBlocElementId indexed: 0);
				id: GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Node A is highlighted';
				value: [ :aNodeElement | aNodeElement background ]
					equals: [ Color gray asBlBackground ];
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep assert
				label: 'Label A is highlighted';
				value: [ :aLabelElement | 
						aLabelElement text iterator
							detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
							ifFound: [ :that | that paint ]
							ifNone: [ nil ] ]
					equals: [ GtWardleyMapConstants hoverColor ];
				id: (#node asBlocElementId indexed: 0);
				id: GtWardleyMapNodeLabelId;
				play ].


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
			aStep mouseMoveOver
				label: 'Hover Node A';
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep assert
				label: 'Node A is highlighted';
				value: [ :aNodeElement | aNodeElement background ]
					equals: [ GtWardleyMapConstants hoverColor asBlBackground ];
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep assert
				label: 'Label A is highlighted';
				value: [ :aLabelElement | 
						aLabelElement text iterator
							detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
							ifFound: [ :that | that paint ]
							ifNone: [ nil ] ]
					equals: [ GtWardleyMapConstants hoverColor ];
				id: (#node asBlocElementId indexed: 0);
				id: GtWardleyMapNodeLabelId;
				play ].


	^ aScripter
]
