"
1. Building treemaps
A treemap represents a tree. That means that before we can represent a treemap, we first need a tree.

Let's start with visualizing a directory containing files and other directories. To define the treemap, we start from a root directory and specify the structure should be navigated recursively through `directories` and the leaves of the tree are the `files`.

{{gtExample:GtBuildingTreeMapsExplanation>>#fileReferenceTreeMap|previewShow=#gtLiveFor:|previewExpanded=}}

The above treemap represents all leaves using the same weight. We can also specify different sizes.

{{gtExample:GtBuildingTreeMapsExplanation>>#fileReferenceTreeMapWithLeavesSize|previewShow=#gtLiveFor:|previewExpanded=}}

This is the basic mechanism.
1. # Manufacturing trees

Sometimes, we have a data structure that is a tree, but no easy way to navigate it. For example, the code model of Pharo relies on package, package tag and class, but there is no uniform way to traverse them nicely. That's when we benefit from the {{gtClass:GtNestedTreeBuilder}}. 

For example, here we get all classes that start with the `Br` prefix. We group those first by package and then by the package tag.

{{gtExample:GtBuildingTreeMapsExplanation>>#tree|previewExpanded|previewShow=#gtTreeFor:}}

The result is a {{gtClass:GtNestedTreeNode|label=nested tree node}} that can be traversed uniformly.

So, now we can construct the treemap.

{{gtExample:GtBuildingTreeMapsExplanation>>#treemapWithLeavesSize|previewExpanded=|previewShow=#gtLiveFor:}}
1. # Specifying custom elements

The default shapes of a treemap can be fine, but sometimes we want to emphasize items. After all, it is a map.

In our case, let's aim to highlight the classes that define at least one custom inspector view with one color, and those that define examples with another color. To make this happen we specify {{gtMethod:GtNestedRectangleTreeMap>>leafElement:}}. The block receives an element that can be customized. You cannot create a new element because a treemap constrains the shape and size of the element.

{{gtExample:GtBuildingTreeMapsExplanation>>#treemapWithCustomLeafElement|previewExpanded=|previewShow=#gtLiveFor:}}

Similarly, we can also customize the container element. For example, let's add a label with the package names.

{{gtExample:GtBuildingTreeMapsExplanation>>#treemapWithCustomContainerElement|previewShow=#gtLiveFor:|previewExpanded=}}


"
Class {
	#name : #GtBuildingTreeMapsExplanation,
	#superclass : #Object,
	#category : #'GToolkit-TreeMap-Examples'
}

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> fileReference [
	<gtExample>
	<return: #FileReference>
	^ GtResourcesUtility resourceAtPath: 'feenkcom/gtoolkit/doc'
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> fileReferenceTreeMap [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ GtNestedRectangleTreeMap new
		roots: {self fileReference};
		leaves: [ :aNode | aNode files ];
		deep: [ :aNode | aNode directories ]
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> fileReferenceTreeMapWithLeavesSize [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ self fileReferenceTreeMap leavesSize: [ :aNode | aNode size max: 1000 ]
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> tree [
	<gtExample>
	<return: #GtNestedTreeNode>
	^ GtNestedTreeBuilder new
		data: (Smalltalk allClassesAndTraits select: [ :c | c name beginsWith: 'Br' ]);
		groupBy: [ :aClass | aClass package ];
		groupBy: [ :aClass | aClass package tags detect: [ :e | e includesClass: aClass ] ];
		weight: [ :aClass | aClass methods size max: 1 ];
		build
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> treemap [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ GtNestedRectangleTreeMap new
		roots: {self tree};
		leaves: [ :aNode | aNode leaves ];
		deep: [ :aNode | aNode nodes ]
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> treemapWithCustomContainerElement [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ self treemapWithCustomLeafElement
		containerElement: [ :anElement :aNodeContext | 
			aNodeContext level = 2
				ifTrue: [ anElement
						addChild: (BrLabel new
								text: (aNodeContext model name name withoutPrefix: 'Brick-');
								aptitude: (BrGlamorousLabelAptitude new
										fontSize: 8;
										foreground: Color gray);
								constraintsDo: [ :c | c ignoreByLayout ]) ].
			anElement
				border: (BlBorder paint: (Color gray alpha: 0.7 / aNodeContext level) width: 1).
			anElement padding: (BlInsets all: 1) ]
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> treemapWithCustomLeafElement [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ self treemapWithLeavesSize
		leafElement: [ :anElement :aLeafContext | 
			| isGtView isGtExample |
			isGtView := aLeafContext model item itOrItsSuperclassesDefineGTViews.
			isGtExample := aLeafContext model item methods
					anySatisfy: [ :aMethod | aMethod isGTExampleMethod ].
			anElement
				border: (BlBorder paint: (Color gray alpha: 0.5 / aLeafContext level) width: 1).
			anElement
				background: (isGtView
						ifTrue: [ Color blue alpha: 0.6 ]
						ifFalse: [ isGtExample
								ifTrue: [ Color green muchDarker alpha: 0.6 ]
								ifFalse: [ Color transparent ] ]) ]
]

{ #category : #accessing }
GtBuildingTreeMapsExplanation >> treemapWithLeavesSize [
	<gtExample>
	<return: #GtNestedRectangleTreeMap>
	^ self treemap leavesSize: [ :aNode | aNode weight ]
]
