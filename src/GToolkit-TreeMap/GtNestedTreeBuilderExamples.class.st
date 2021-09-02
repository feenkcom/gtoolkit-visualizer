Class {
	#name : 'GtNestedTreeBuilderExamples',
	#superclass : 'Object',
	#category : 'GToolkit-TreeMap-Examples'
}

{ #category : 'examples - ui' }
GtNestedTreeBuilderExamples >> basicNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := GtNestedRectangleTreeMap new.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> basicTreeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtNestedTreeBuilder new.
	self assert: aBuilder data isNotNil.
	self assert: aBuilder data isEmpty.
	self assert: aBuilder weight isNotNil.
	self assert: aBuilder step allSteps size equals: 1.
	^ aBuilder
]

{ #category : 'utilities - disk content' }
GtNestedTreeBuilderExamples >> createDirectories: aMaxDirectories files: aMaxFiles upTo: aMaxLevels in: aDirectory [ 
	aMaxLevels <= 0 ifTrue: [ ^ self ].
	self createDirectories: (aMaxDirectories // 2 to: aMaxDirectories) atRandom in: aDirectory.
	self createFiles: (aMaxFiles // 2 to: aMaxDirectories) atRandom in: aDirectory.
	aDirectory directories do: [ :eachDirectory | 
		self createDirectories: aMaxDirectories files: aMaxFiles upTo: aMaxLevels - 1 in: eachDirectory ]
]

{ #category : 'utilities - disk content' }
GtNestedTreeBuilderExamples >> createDirectories: aNumberOfDirectories in: aDirectory [ 
	aNumberOfDirectories timesCollect: [ :anIndex | 
		(aDirectory / ('dir-', anIndex asString)) ensureCreateDirectory ]
]

{ #category : 'utilities - disk content' }
GtNestedTreeBuilderExamples >> createFiles: aNumberOfFiles in: aDirectory [ 
	aNumberOfFiles timesCollect: [ :anIndex | 
		(aDirectory / ('file-', anIndex asString, '.txt')) writeStreamEncoded: #utf8 do: [ :aStream | 
			aStream nextPutAll: (String loremIpsum: (50 to: 100) atRandom) ] ]
]

{ #category : 'examples - model' }
GtNestedTreeBuilderExamples >> directory [
	<gtExample>
	| aFileSystem |
	aFileSystem := FileSystem memory.
	self createDirectories: 5 files: 5 upTo: 3 in: aFileSystem workingDirectory.
	^ aFileSystem workingDirectory
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> directoryBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicTreeBuilder.
	aBuilder collectNodes: [ :aDir | aDir directories ] leaves: [ :aDir | aDir files ].
	aBuilder weight: [ :aFile | aFile size ].
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : 'examples - collect nodes and leaves' }
GtNestedTreeBuilderExamples >> directoryStructure [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self directoryBuilder.
	aBuilder data: self directory.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes <= 5.
	self assert: aResult numberOfLeaves <= 5.
	^ aResult
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorAndNameAndInstrumentBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorAndNameBuilder.
	aBuilder groupBy: [ :anItem | anItem fourth ].
	self assert: aBuilder weight isNotNil.
	self assert: aBuilder step allSteps size equals: 4.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorAndNameBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder groupBy: [ :anItem | anItem third ].
	self assert: aBuilder weight isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorAndNameSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorAndNameBuilder.
	aBuilder summarize.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorAndSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder summarize.
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder groupBy: [ :anItem | anItem second ].
	self assert: aBuilder step groupBy isNotNil.
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> groupByColorRejectPeterBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self groupByColorBuilder.
	aBuilder reject: [ :anItem | anItem third = 'peter' ].
	self assert: aBuilder step isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> hundredByColor [
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

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> hundredByColorAndName [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndNameBuilder.
	aBuilder data: self hundredRandomModels.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 4 different colors"
	self assert: aResult numberOfNodes <= 4.
	self assert: aResult weight isNumber.
	^ aResult
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> hundredGroupByColorAndNameAndInstrument [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndNameAndInstrumentBuilder.
	aBuilder data: self hundredRandomModels.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 4 different colors"
	self assert: aResult numberOfNodes <= 4.
	self assert: aResult weight isNumber.
	^ aResult
]

{ #category : 'examples - ui' }
GtNestedTreeBuilderExamples >> hundredNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := self basicNestedRectangleTreemap.
	aBuilder
		roots: self hundredRandomModels;
		leavesSize: [ :anArray | anArray first ];
		leafElement: [ :anElement :anArray | 
			anElement background: anArray second ].
	^ aBuilder asElement 
]

{ #category : 'examples - model' }
GtNestedTreeBuilderExamples >> hundredRandomModels [
	<gtExample>
	^ 100 timesCollect: [ self oneRandomModel ]
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> noGroupingBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicTreeBuilder.
	aBuilder weight: [ :anItem | anItem first ].
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> noGroupingSummarizeBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder summarize.
	self assert: aBuilder weight isNotNil.
	^ aBuilder
]

{ #category : 'examples - model' }
GtNestedTreeBuilderExamples >> oneRandomModel [
	<gtExample>
	^ Array 
		with: (1 to: 50) atRandom 
		with: { Color green. Color blue. Color red. Color yellow } atRandom
		with: #( 'peter' 'anna' 'natasha' ) atRandom
		with: #( 'guitar' 'violine' 'saxophone' 'piano')
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> rejectPeterGroupByColorBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder reject: [ :anItem | anItem third = 'peter' ].
	aBuilder groupBy: [ :anItem | anItem second ].
	self assert: aBuilder step isNotNil.
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : 'examples - rejecting' }
GtNestedTreeBuilderExamples >> rejectingSix [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self rejectingSixBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 0.
	self assert: aResult numberOfLeaves equals: 5.
	^ aResult
]

{ #category : 'examples - rejecting' }
GtNestedTreeBuilderExamples >> rejectingSixAndAnna [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self rejectingSixAndAnnaBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 0.
	self assert: aResult numberOfLeaves equals: 3.
	^ aResult
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> rejectingSixAndAnnaBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self rejectingSixBuilder.
	aBuilder reject: [ :anItem | anItem third = 'anna' ].
	self assert: aBuilder step allSteps size equals: 3.
	^ aBuilder
]

{ #category : 'examples - tree builder' }
GtNestedTreeBuilderExamples >> rejectingSixBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self noGroupingBuilder.
	aBuilder reject: [ :anItem | anItem first = 6 ].
	self assert: aBuilder step allSteps size equals: 2.
	^ aBuilder
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenByColor [
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

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenByColorAndName [
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

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenGroupByColorAndNameSummarize [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndNameSummarizeBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	"We have at most 3 different colors"
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 3.
	self assert: aResult numberOfLeaves equals: 0.
	self assert: aResult nodes first numberOfNodes equals: 0.
	self assert: aResult nodes first numberOfLeaves equals: 2.
	self assert: aResult nodes second numberOfNodes equals: 0.
	self assert: aResult nodes second numberOfLeaves equals: 2.
	self assert: aResult nodes third numberOfNodes equals: 0.
	self assert: aResult nodes third numberOfLeaves equals: 2.
	^ aResult
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenGroupByColorAndSummarize [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self groupByColorAndSummarizeBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 0.
	self assert: aResult numberOfLeaves equals: 3.
	self assert: aResult leaves first items size equals: 3.
	self assert: aResult leaves second items size equals: 2.
	self assert: aResult leaves third items size equals: 2.
	^ aResult
]

{ #category : 'examples - model' }
GtNestedTreeBuilderExamples >> sevenModel [
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

{ #category : 'examples - ui' }
GtNestedTreeBuilderExamples >> sevenNestedRectangleTreemap [
	<gtExample>
	| aBuilder |
	aBuilder := self basicNestedRectangleTreemap.
	aBuilder
		roots: self sevenModel;
		leavesSize: [ :anArray | anArray first ];
		containerElement: [ :anElement :anArray | 
			anElement 
				addChild: (BlElement new
					background: Color veryLightGray;
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ]) ];
		leafElement: [ :anElement :anArray | 
			anElement 
				addChild: (BlElement new
					background: anArray second;
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ]) ].
	^ aBuilder asElement 
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenNoGrouping [
	<gtExample>
	| aBuilder aResult |
	aBuilder := self noGroupingBuilder.
	aBuilder data: self sevenModel.
	aResult := aBuilder build.
	self assert: aResult isNotNil.
	self assert: aResult weight isNumber.
	self assert: aResult numberOfNodes equals: 0.
	self assert: aResult numberOfLeaves equals: 7.
	^ aResult
]

{ #category : 'examples - grouping' }
GtNestedTreeBuilderExamples >> sevenNoGroupingSummarize [
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
