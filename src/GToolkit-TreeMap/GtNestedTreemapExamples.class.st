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

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> basicTreeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtNestedTreeBuilder new.
	self assert: aBuilder data isNotNil.
	self assert: aBuilder data isEmpty.
	self assert: aBuilder weight isNotNil.
	self assert: aBuilder step allSteps size equals: 1.
	^ aBuilder
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> groupByColorAndNameBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder groupBy: [ :anItem | anItem third ].
	self assert: aBuilder weight isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> groupByColorAndNameSummarize [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndNameSummarizeBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 3 different colors"
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult nodes first nodes size equals: 2.
	self assert: aResult nodes first leaves size equals: 0.
	self assert: aResult nodes second nodes size equals: 2.
	self assert: aResult nodes second leaves size equals: 0.
	self assert: aResult nodes third nodes size equals: 2.
	self assert: aResult nodes third leaves size equals: 0.
	^ aResult
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> groupByColorAndNameSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorAndNameBuilder.
	aBuilder summarize.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> groupByColorAndSummarize [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndSummarizeBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult nodes first items size equals: 3.
	self assert: aResult nodes second items size equals: 2.
	self assert: aResult nodes third items size equals: 2.
	^ aResult
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> groupByColorAndSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder summarize.
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> groupByColorBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder groupBy: [ :anItem | anItem second ].
	self assert: aBuilder step groupBy isNotNil.
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> groupByColorRejectPeterBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder reject: [ :anItem | anItem third = 'peter' ].
	self assert: aBuilder step isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> hundredByColor [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorBuilder.
	aBuilder data: self hundredRandomModels.
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

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> noGrouping [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self noGroupingBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 7.
	self assert: aResult nodes isEmpty.
	self assert: aResult leaves size equals: 7.
	^ aResult
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> noGroupingBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicTreeBuilder.
	aBuilder weight: [ :anItem | anItem first ].
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> noGroupingSummarize [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self noGroupingSummarizeBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult items size equals: 7.
	^ aResult
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> noGroupingSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder summarize.
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : #'examples - model' }
GtNestedTreemapExamples >> oneRandomModel [
	<gtExample>
	^ Array 
		with: (1 to: 50) atRandom 
		with: { Color green. Color blue. Color red. Color yellow } atRandom
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> rejectPeterGroupByColorBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder reject: [ :anItem | anItem third = 'peter' ].
	aBuilder groupBy: [ :anItem | anItem second ].
	self assert: aBuilder step isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : #'examples - rejecting' }
GtNestedTreemapExamples >> rejectingSix [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self rejectingSixBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 5.
	self assert: aResult nodes isEmpty.
	self assert: aResult leaves size equals: 5.
	^ aResult
]

{ #category : #'examples - rejecting' }
GtNestedTreemapExamples >> rejectingSixAndAnna [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self rejectingSixAndAnnaBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult nodes isEmpty.
	self assert: aResult leaves size equals: 3.
	^ aResult
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> rejectingSixAndAnnaBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self rejectingSixBuilder.
	aBuilder reject: [ :anItem | anItem third = 'anna' ].
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : #'examples - tree builder' }
GtNestedTreemapExamples >> rejectingSixBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder reject: [ :anItem | anItem first = 6 ].
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> sevenByColor [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult nodes first nodes size equals: 0.
	self assert: aResult nodes first leaves size equals: 3.
	self assert: aResult nodes second nodes size equals: 0.
	self assert: aResult nodes second leaves size equals: 2.
	self assert: aResult nodes third nodes size equals: 0.
	self assert: aResult nodes third leaves size equals: 2.
	^ aResult
]

{ #category : #'examples - grouping' }
GtNestedTreemapExamples >> sevenByColorAndName [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndNameBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 3 different colors"
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult nodes first nodes size equals: 2.
	self assert: aResult nodes first leaves size equals: 0.
	self assert: aResult nodes second nodes size equals: 2.
	self assert: aResult nodes second leaves size equals: 0.
	self assert: aResult nodes third nodes size equals: 2.
	self assert: aResult nodes third leaves size equals: 0.
	^ aResult
]

{ #category : #'examples - model' }
GtNestedTreemapExamples >> sevenModel [
	<gtExample>
	^ { 
		{ 6. Color yellow. 'peter' }.
		{ 6. Color blue. 'peter' }. 
		{ 4. Color red. 'natasa' }. 
		{ 3. Color yellow. 'anna' }.
		{ 2. Color blue. 'anna' }.
		{ 2. Color red. 'peter' }.
		{ 1. Color yellow. 'peter' } }
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
