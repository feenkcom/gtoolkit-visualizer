Class {
	#name : #GtNestedTreemapExamples,
	#superclass : #Object,
	#category : #'GToolkit-TreeMap-Examples'
}

{ #category : #'examples - ui' }
GtNestedTreemapExamples >> basicNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := GtNestedRectangleTreeMap new.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> basicTreeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtNestedTreeBuilder new.
	self assert: aBuilder data isNotNil.
	self assert: aBuilder data isEmpty.
	self assert: aBuilder groupBy isNotNil.
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> builderWithGroupByColorSetup [
	<gtExample>
	| aBuilder |
	aBuilder := self basicTreeBuilder.
	aBuilder data: self hundredRandomModels.
	aBuilder groupBy: [ :anItem | anItem second ].
	aBuilder weight: [ :anItem | anItem first ].
	self assert: aBuilder data size equals: 100.
	self assert: aBuilder groupBy isNotNil.
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> groupByColor [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self builderWithGroupByColorSetup.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 4 different colors"
	self assert: aResult numberOfNodes <= 4.
	self assert: aResult weight isNumber.
	^ aResult
]

{ #category : #'examples - ui' }
GtNestedTreemapExamples >> hundredNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := self basicNestedRectangleTreemap.
	aBuilder
		roots: self hundredRandomModels;
		leavesSize: [ :anArray | anArray first ];
		leafEllipse: [ :anElement :anArray | 
			anElement background: anArray second ].
	^ aBuilder asElement 
]

{ #category : #'examples - model' }
GtNestedTreemapExamples >> hundredRandomModels [
	<gtExample>
	^ 100 timesCollect: [ self oneRandomModel ]
]

{ #category : #'examples - model' }
GtNestedTreemapExamples >> oneRandomModel [
	<gtExample>
	^ Array 
		with: (1 to: 50) atRandom 
		with: { Color green. Color blue. Color red. Color yellow } atRandom
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> sevelBuilderWithGroupByColorSetup [
	<gtExample>
	| aBuilder |
	aBuilder := self basicTreeBuilder.
	aBuilder data: self sevenModel.
	aBuilder groupBy: [ :anItem | anItem second ].
	aBuilder weight: [ :anItem | anItem first ].
	self assert: aBuilder data size equals: 7.
	self assert: aBuilder groupBy isNotNil.
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> sevenByColor [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self sevelBuilderWithGroupByColorSetup.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 3 different colors"
	self assert: aResult numberOfNodes <= 3.
	self assert: aResult weight isNumber.
	^ aResult
]

{ #category : #'examples - model' }
GtNestedTreemapExamples >> sevenModel [
	<gtExample>
	^ { 
		{ 6. Color yellow }.
		{ 6. Color blue }. 
		{ 4. Color red }. 
		{ 3. Color yellow }.
		{ 2. Color blue }.
		{ 2. Color red }.
		{ 1. Color yellow } }
]

{ #category : #'examples - ui' }
GtNestedTreemapExamples >> sevenNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := self basicNestedRectangleTreemap.
	aBuilder
		roots: self sevenModel;
		leavesSize: [ :anArray | anArray first ];
		containerEllipse: [ :anElement :anArray | 
			anElement 
				addChild: (BlElement new
					background: Color veryLightGray;
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ]) ];
		leafEllipse: [ :anElement :anArray | 
			anElement 
				addChild: (BlElement new
					background: anArray second;
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ]) ].
	^ aBuilder asElement 
]
