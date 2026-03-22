"
I am an abstract `worst()` function defined in the paper by Mark Bruls, Kees Huizing, and Jarke J. van Wij, ""Squarified Treemaps"" [PDF](https://www.win.tue.nl/~vanwijk/stm.pdf). The function `worst()` gives the highest aspect ratio of a list of rectangles, given the length of the side along which they are to be laid out. 

I am used by {{gtClass:GtGraphTreemapSquarifyStep}}.

1. # Example


For {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithTwoNodes|label=#nodesCount}} nodes that are located along the side of {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithTwoNodes|label=#length}} length, and with total are size of {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithTwoNodes|label=#totalArea}}, the worst aspect ratio is {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithTwoNodes|label=#value}}:
{{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithTwoNodes|previewShow=#gtPreviewFor:|previewExpanded=true|codeExpanded=falsec}}

If we add to the same area another node, we end up with {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithThreeNodes|label=#nodesCount}} nodes and the worst aspect ratio of {{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithThreeNodes|label=#value}} value. As this value is bigger then the previous one, {{gtClass:GtGraphTreemapSquarifyStep}} decides to pass the new node to a new area:
{{gtExample:GtGraphTreemapLayoutExamples>>#worstAspectRatioWithThreeNodes|previewShow=#gtPreviewFor:|previewExpanded=true|codeExpanded=false}}


"
Class {
	#name : #GtGraphTreemapSquarifyWorst,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'totalArea',
		'length'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapSquarifyWorst class >> aspectRatio [
	^ GtGraphTreemapSquarifyWorstAspectRatio new
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst class >> default [
	^ self aspectRatio
]

{ #category : #comparing }
GtGraphTreemapSquarifyWorst >> >= aGtGraphTreemapSquarifyWorst [ 
	^ self value >= aGtGraphTreemapSquarifyWorst value
]

{ #category : #adding }
GtGraphTreemapSquarifyWorst >> addNode: aNode [ 
	self nodes: (self nodes copyWith: aNode)
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> area [
	^ self weight * self totalArea
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> breadth [
	^ self area / self length
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtNodesFor: aView [
	<gtView>
	^ GtGraphTreemapSquarifyWorstPreview new
		worst: self;
		gtNodesFor: aView
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtPreviewFor: aView [
	<gtView>
	^ GtGraphTreemapSquarifyWorstPreview new
		worst: self;
		gtPreviewFor: aView
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtReversedPreviewFor: aView [
	<gtView>
	^ GtGraphTreemapSquarifyWorstPreview new
		worst: self;
		gtReversedPreviewFor: aView
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorst >> gtWorstValueFor: aView [
	<gtView>
	^ GtGraphTreemapSquarifyWorstPreview new
		worst: self;
		gtWorstValueFor: aView
]

{ #category : #initialization }
GtGraphTreemapSquarifyWorst >> initialize [
	super initialize.
	nodes := #().
	totalArea := 0.
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length [
	^ length
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> length: anObject [
	length := anObject
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> maxWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMax: [ :eachNode | eachNode weight ].
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> minWeightNode [
	<return: #GtGraphTreemapNode>
	^ self nodes detectMin: [ :eachNode | eachNode weight ].
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes [
	<return: #Array of: #GtGraphTreemapNode>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> nodes: anArray [
	nodes := anArray
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodesBreadth [
	^ self area / self length
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> nodesCount [
	<return: #Integer>
	^ self nodes size
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> totalArea [
	<return: #Number>
	^ totalArea
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorst >> totalArea: anObject [
	totalArea := anObject
]

{ #category : #evaluating }
GtGraphTreemapSquarifyWorst >> value [
	"Return worst aspect ratio value"
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorst >> weight [
	"Return sum of all node weights"
	<return: #Number>
	^ self nodes 
		ifNotEmpty: [ :theNodes | theNodes sum: #weight ]
		ifEmpty: [ 0 ]
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorst >> worstValueForNode: aNode [
	"Worst value for a node"
	^ self subclassResponsibility
]
