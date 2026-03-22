"
1. Circle layout 

This layout orders a graph's nodes in a circular formation. A very basic example of this layout is shown below. The example demonstrates how 10 nodes belonging to the same container are laid out using this algorithm.

{{gtExample:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10SimpleNodes|expanded=true|previewExpanded=true}}

The next example show nodes of varying sizes .

{{gtExample:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAndNodesOfIncreasingSize|expanded=true|previewExpanded=true}}

It can be noticed that it is not necessary to specify the circle's radius - it is automatically calculated so that the nodes do not overlap.  The following example shows this feature in action by laying out 10 nodes, much bigger than those used in the preivous example.

{{gtExample:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10BigNodes|expanded=true|previewExpanded=true}}


Optionally, a threshold value can be provided. If that is not the case, the radius will be calculated so that the nodes are close to each other in the resulting layout. If more space is required, the threshold can be manually specified. The larged that value is, the more space there will be between the nodes. The next example shows the same 10 nodes as in the first example, but with the distance parameter (threshold) set to  a value which is twice as big as the default one.

{{gtExample:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10SimpleNodesWithDistance|expanded=true|previewExpanded=true}}

The nodes don't have to be plain geometric shapes - they can be complex elements, like textual editors, as demostrated in the following example.

{{gtExample:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10EditorNodes|expanded=true|previewExpanded=true}}


"
Class {
	#name : #GtGradCircleLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradCircleLayoutExamples >> circleLayout [
	<gtExample>
	<return: #GtGradCircleLayout>
	| aCircleLayout |
	aCircleLayout := GtGradCircleLayout new.
	self assert: aCircleLayout distance equals: 50.

	^ aCircleLayout
]

{ #category : #'examples - instance creation' }
GtGradCircleLayoutExamples >> circleLayout: distance [
	<gtExample>
	| aCircleLayout |

	aCircleLayout := GtGradCircleLayout new.
	aCircleLayout  distance: distance.
	self assert: aCircleLayout distance equals: distance.

	^ aCircleLayout
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> containerWithCircleLayout [
	<gtExample>
	<return: #BlElement>
	| aContainer aCircleLayout |
	aContainer := self container.
	aCircleLayout := self circleLayout.

	aContainer layout: aCircleLayout.

	^ aContainer
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> containerWithCircleLayout: layoutDistance [
	<gtExample>
	| aContainer aCircleLayout |
	
	aContainer := self container. 
	aCircleLayout := self circleLayout: layoutDistance.

	aContainer layout: aCircleLayout.
	
	^ aContainer
]

{ #category : #'examples - layout' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAnd10BigNodes [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes |
	aContainer := self containerWithCircleLayout.
	theNodes := self bigNodesN: 10.
	aContainer addChildren: theNodes.

	aContainer forceLayout.

	self assert: aContainer position equals: 0 @ 0.


	^ aContainer
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAnd10EditorNodes [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes |
	aContainer := self containerWithCircleLayout.
	theNodes := self editorNodes10WithRandomContent.

	aContainer addChildren: theNodes.

	^ aContainer
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAnd10EditorNodesAndLine [
	<gtExample>
	<label: 'An example of a passive edge that is not taken into account by the layout'>
	<return: #BlElement>
	| aContainer fromNode toNode aLine |
	aContainer := self containerWithCircleLayoutAnd10EditorNodes.

	fromNode := aContainer children first.
	toNode := aContainer children at: aContainer children size // 2.

	aLine := self line.
	aLine fromAnchor: (BlElementCenterAnchor element: fromNode).
	aLine toAnchor: (BlElementCenterAnchor element: toNode).

	aContainer addChild: aLine.

	^ aContainer
]

{ #category : #'examples - layout' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAnd10SimpleNodes [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes theNodeExtents theNodePositions |
	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.

	aContainer forceLayout.

	self assert: aContainer position equals: 0 @ 0.
	self assert: aContainer extent equals: 296 @ 254.

	theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].

	self
		assert: theNodeExtents asArray
		equals: (10 timesCollect: [ self nodeExtent ]).
	self
		assert: theNodePositions asArray
		equals: {246.0 @ 117.0.
				223.0 @ 189.0.
				161.0 @ 234.0.
				85.0 @ 234.0.
				23.0 @ 189.0.
				0.0 @ 117.0.
				23.0 @ 45.0.
				85.0 @ 0.0.
				161.0 @ 0.0.
				223.0 @ 45.0}.

	^ aContainer
]

{ #category : #'examples - layout' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAnd10SimpleNodesWithDistance [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes distance |
	distance := 100.
	aContainer := self containerWithCircleLayout: distance.
	theNodes := self simpleNodes10.
	aContainer addChildren: theNodes.

	aContainer forceLayout.

	self assert: aContainer position equals: 0 @ 0.




	^ aContainer
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAndALargeNumberOfNodes [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes |
	aContainer := self containerWithCircleLayout.
	theNodes := self simpleNodesN: 100.
	aContainer addChildren: theNodes.

	aContainer forceLayout.

	^ aContainer
]

{ #category : #'examples - layout' }
GtGradCircleLayoutExamples >> containerWithCircleLayoutAndNodesOfIncreasingSize [
	<gtExample>
	<return: #BlElement>
	| aContainer theNodes |
	aContainer := self containerWithCircleLayout.
	theNodes := self createNNodesOfIncreasingSize: 10.
	aContainer addChildren: theNodes.

	aContainer forceLayout.

	self assert: aContainer position equals: 0 @ 0.

	^ aContainer
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> editorNodes10 [
	<gtExample>
	<return: #Array>
	^ 10
		timesCollect: [ | anEditor |
			anEditor := self editor.
			anEditor graph beNode.
			anEditor ]
]

{ #category : #'examples - composite' }
GtGradCircleLayoutExamples >> editorNodes10WithRandomContent [
	<gtExample>
	<return: #OrderedCollection>
	^ ((Character space split: String loremIpsum) first: 10)
		collect: [ :word | 
			| anEditor anEditorModel |
			anEditorModel := BrTextEditorModel new.
			anEditorModel text: word asRopedText.

			anEditor := BrEditorElement new.
			anEditor editor: anEditorModel.
			anEditor size: 140 @ 80.

			anEditor background: Color veryVeryLightGray.
			anEditor
				border: (BlBorder builder
						width: 1;
						paint: Color black) build.
			anEditor geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
			anEditor graph beNode.
			anEditor ]
]

{ #category : #'as yet unclassified' }
GtGradCircleLayoutExamples >> exampleWithLogger [
	<gtExample>
	<return: #MemoryLogger>
	| aContainer theNodes logger |
	"Previously falling example."
	aContainer := self containerWithCircleLayout.

	theNodes := 10
			timesCollect: [ :index | 
				| aNode |
				aNode := BlElement new
						background: (Color lightGray alpha: 0.5);
						border: (BlBorder builder
								width: 1;
								paint: Color black) build;
						size: 500 @ 200;
						labeled: 'Node ' , index asString.
				aNode graph beNode.
				aNode ].
	aContainer addChildren: theNodes.

	logger := MemoryLogger new.
	logger runDuring: [ aContainer forceLayout ].

	^ logger
]
