"
Browser data created with:

```
browsers := { 'Chrome' . 'Safari' . 'Firefox' . 'Opera' . 'Edge' }.
dangers := { #low . #medium . #high }.

Clipboard clipboardText: (String streamContents: [ :aStream |
	aStream nextPutAll: '#('; cr.
	
	10000 timesRepeat: [
		aStream tab; tab; nextPutAll: '#('.
		aStream print: browsers atRandom; space.
		aStream print: ((12  10) atRandom); space.
		aStream print: 2 atRandom even; space.
		aStream nextPutAll: dangers atRandom printString.
		aStream nextPut: $); cr.
	].
	
	aStream tab; nextPut: $).
])
```


"
Class {
	#name : #GtPlotterDataGroupExamples,
	#superclass : #GtPlotterDataExamples,
	#category : #'GToolkit-Plotter-Example - Data'
}

{ #category : #'examples - grouping' }
GtPlotterDataGroupExamples >> groupByBrowser [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| aGroup |
	aGroup := self browserDataGroupSortedByBrowser
			groupedBy: [ :eachItem | eachItem at: #browser ].

	self assert: aGroup isLogicalGroup.
	self assert: aGroup isComposite.
	self assert: aGroup isLogical.
	self assert: aGroup isDecorator not.
	self assert: aGroup size equals: 5.

	self assert: (aGroup at: 1) isDecorator.
	self assert: (aGroup at: 1) criteria equals: 'Chrome'.
	self assert: (aGroup at: 1) size equals: 2054.

	self assert: (aGroup at: 2) isDecorator.
	self assert: (aGroup at: 2) criteria equals: 'Edge'.
	self assert: (aGroup at: 2) size equals: 2043.

	self assert: (aGroup at: 3) isDecorator.
	self assert: (aGroup at: 3) criteria equals: 'Firefox'.
	self assert: (aGroup at: 3) size equals: 1955.

	self assert: (aGroup at: 4) isDecorator.
	self assert: (aGroup at: 4) criteria equals: 'Opera'.
	self assert: (aGroup at: 4) size equals: 1998.

	self assert: (aGroup at: 5) isDecorator.
	self assert: (aGroup at: 5) criteria equals: 'Safari'.
	self assert: (aGroup at: 5) size equals: 1950.

	^ aGroup
]

{ #category : #'examples - grouping' }
GtPlotterDataGroupExamples >> groupByBrowserThenByDanger [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	^ self groupByBrowser groupedBy: [ :eachItem | eachItem at: #danger ]
]

{ #category : #'examples - colored' }
GtPlotterDataGroupExamples >> groupByBrowserThenByDangerWithColor [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| theColors |
	theColors := {#low -> Color gray.
			#medium -> Color orange.
			#high -> Color red} asDictionary.

	^ self groupByBrowserWithLabel
		groupedBy: [ :eachItem | eachItem at: #danger ]
		colored: [ :aDangerValue | theColors at: aDangerValue ]
]

{ #category : #'examples - labelled' }
GtPlotterDataGroupExamples >> groupByBrowserWithLabel [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| theGroups theLabels |
	theGroups := self browserDataGroup
			groupedBy: [ :eachItem | eachItem at: #browser ]
			labelled: [ :aBrowserName | aBrowserName ].

	theLabels := Array
			streamContents: [ :aStream | 
				theGroups
					do: [ :eachGroup | eachGroup labelDo: [ :aLabel | aStream nextPut: aLabel ] ] ].

	self assert: theGroups size equals: 5.
	self assert: theLabels size equals: 5.
	self assert: theLabels asSet equals: self class browsers asSet.

	^ theGroups
]

{ #category : #'examples - labelled' }
GtPlotterDataGroupExamples >> groupByBrowserWithLabelSorted [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| theGroups theLabels |
	theGroups := self groupByBrowserWithLabel
			sorted: [ :aGroup :anotherGroup | aGroup label < anotherGroup label ].

	theLabels := Array
			streamContents: [ :aStream | 
				theGroups
					do: [ :eachGroup | eachGroup labelDo: [ :aLabel | aStream nextPut: aLabel ] ] ].

	self assert: theGroups size equals: 5.
	self assert: theLabels size equals: 5.
	self assert: theLabels equals: self class browsers sorted.

	^ theGroups
]

{ #category : #'examples - named grouping' }
GtPlotterDataGroupExamples >> groupByBrowserWithMultipleDecorations [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	^ self browserDataGroup
		groupedBy: [ :eachItem | eachItem at: #browser ]
		decorated: [ :eachKey :theValues | 
			{GtPlotterDataGroupWithCriteria new criteria: eachKey.
				GtPlotterDataGroupWithStacking new} ]
]

{ #category : #'examples - named grouping' }
GtPlotterDataGroupExamples >> groupByBrowserWithName [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	^ self browserDataGroup
		groupedBy: [ :eachItem | eachItem at: #browser ]
		named: #Browser
]

{ #category : #'examples - named grouping' }
GtPlotterDataGroupExamples >> groupByBrowserWithNameThenByDangerWithName [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	^ self groupByBrowserWithName
		groupedBy: [ :eachItem | eachItem at: #danger ]
		named: #Danger
]

{ #category : #'examples - named grouping' }
GtPlotterDataGroupExamples >> groupByBrowserWithNameThenByDangerWithNameThenByVisted [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	^ self groupByBrowserWithNameThenByDangerWithName
		groupedBy: [ :eachItem | eachItem at: #visited ]
		named: #Visited
]
