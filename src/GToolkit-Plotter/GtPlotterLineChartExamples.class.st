"
I exemplify {{gtClass:GtPlotterLineChart}}.
"
Class {
	#name : #GtPlotterLineChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'examples - axes' }
GtPlotterLineChartExamples >> arbitraryObservationsWithNumericCoordinates [
	<gtExample>
	| chart observations element |
	observations := { 1 @ 2. 2 @ 3. 3 @ 1 }.
	chart := GtPlotterLineChart new
		with: (GtPlotterDataGroup new values: observations);
		valueX: #x;
		valueY: #y;
		highlightAllPoints;
		labelFormatX: [ :coordinate | 'Sample ', coordinate printString ].
	element := chart asElement.
	element constraintsDo: [ :c | c horizontal exact: 600. c vertical exact: 350 ].
	element forceLayout.
	self assert: chart newPointElements size equals: observations size.
	self assert: (chart labelFormatX value: 2) equals: 'Sample 2'.
	self assert: (chart defaultAxisLabelFor: #milestone) asString equals: '#milestone'.
	self assert: (chart defaultAxisLabelFor: observations first) asString equals: observations first printString.
	^ chart
]

{ #category : #'examples - axes' }
GtPlotterLineChartExamples >> axisTickLabelsUseGlamorousLabels [
	<gtExample>
	| chart labels |
	chart := self hikingProfile.
	chart asElement.
	labels := chart newAxisXTickLabelsElement.
	self assert: labels children notEmpty.
	labels children do: [ :each | self assert: (each isKindOf: BrLabel) ].
	labels := chart newAxisYTickLabelsElement.
	self assert: labels children notEmpty.
	labels children do: [ :each | self assert: (each isKindOf: BrLabel) ].
	^ chart
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commits [
	<gtExample>
	<return: #Array>
	^ GtPlotterRawLineExamples new commits
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUserData [
	<gtExample>
	<return: #GtPlotterDataGroup>
	^ GtPlotterDataGroup new values: self commitsAndUserValues
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUserDataGroupedByMonth [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| aData |
	aData := self commitsAndUserData.
	aData := aData
			groupedBy: [ :eachData | (eachData at: #date) asMonth ]
			colored: [ :user | Color purple ].
	^ aData
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUserDataGroupedByUser [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| aData colors |
	colors := {'jessica' -> Color green.
			'bill' -> Color blue.
			'joe' -> Color red} asOrderedDictionary.

	aData := self commitsAndUserData.
	aData := aData
			groupedBy: [ :eachData | eachData at: #user ]
			labelled: [ :user | user ]
			colored: [ :user | colors at: user ].
	^ aData
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUserDataGroupedByUserAndMonth [
	<gtExample>
	<return: #GtPlotterDataLogicalGroups>
	| aData |
	aData := self commitsAndUserDataGroupedByUser.
	aData := aData groupedBy: [ :eachData | (eachData at: #date) asMonth ].
	^ aData
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsAndUserRawValues [
	<gtExample>
	<return: #Array>
	^ {{Date
				year: 2015
				month: 10
				day: 5.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 10
				day: 5.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 10
				day: 6.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 10
				day: 7.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 10
				day: 7.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 10
				day: 8.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 10
				day: 9.
			'joe'.
			34}.
		{Date
				year: 2015
				month: 10
				day: 9.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 10
				day: 9.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 10.
			'joe'.
			33}.
		{Date
				year: 2015
				month: 10
				day: 10.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 11.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 10
				day: 12.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 10
				day: 12.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 10
				day: 14.
			'joe'.
			42}.
		{Date
				year: 2015
				month: 10
				day: 14.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 10
				day: 14.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 10
				day: 15.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 10
				day: 15.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 10
				day: 15.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 10
				day: 16.
			'joe'.
			42}.
		{Date
				year: 2015
				month: 10
				day: 16.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 10
				day: 16.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 17.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 10
				day: 18.
			'joe'.
			37}.
		{Date
				year: 2015
				month: 10
				day: 18.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 10
				day: 18.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 10
				day: 19.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 10
				day: 19.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 10
				day: 19.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 20.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 10
				day: 20.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 10
				day: 21.
			'joe'.
			30}.
		{Date
				year: 2015
				month: 10
				day: 21.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 10
				day: 21.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 22.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 10
				day: 22.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 10
				day: 23.
			'joe'.
			39}.
		{Date
				year: 2015
				month: 10
				day: 23.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 10
				day: 23.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 10
				day: 24.
			'joe'.
			35}.
		{Date
				year: 2015
				month: 10
				day: 24.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 10
				day: 25.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 10
				day: 26.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 10
				day: 26.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 10
				day: 26.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 10
				day: 27.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 10
				day: 27.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 10
				day: 28.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 10
				day: 29.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 10
				day: 30.
			'joe'.
			37}.
		{Date
				year: 2015
				month: 10
				day: 30.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 10
				day: 31.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 10
				day: 31.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 10
				day: 31.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 11
				day: 1.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 11
				day: 1.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 11
				day: 1.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 2.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 11
				day: 2.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 11
				day: 2.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 11
				day: 3.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 11
				day: 3.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 11
				day: 3.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 4.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 4.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 5.
			'joe'.
			34}.
		{Date
				year: 2015
				month: 11
				day: 5.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 11
				day: 5.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 6.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 6.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 7.
			'joe'.
			30}.
		{Date
				year: 2015
				month: 11
				day: 7.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 11
				day: 8.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 11
				day: 8.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 11
				day: 9.
			'joe'.
			39}.
		{Date
				year: 2015
				month: 11
				day: 9.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 11
				day: 10.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 11
				day: 10.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 11
				day: 11.
			'joe'.
			30}.
		{Date
				year: 2015
				month: 11
				day: 11.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 11.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 12.
			'joe'.
			35}.
		{Date
				year: 2015
				month: 11
				day: 12.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 11
				day: 13.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 11
				day: 13.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 14.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 11
				day: 15.
			'joe'.
			30}.
		{Date
				year: 2015
				month: 11
				day: 15.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 16.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 11
				day: 16.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 17.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 11
				day: 17.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 11
				day: 17.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 18.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 11
				day: 19.
			'joe'.
			41}.
		{Date
				year: 2015
				month: 11
				day: 20.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 11
				day: 20.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 21.
			'joe'.
			37}.
		{Date
				year: 2015
				month: 11
				day: 21.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 11
				day: 21.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 11
				day: 22.
			'joe'.
			39}.
		{Date
				year: 2015
				month: 11
				day: 22.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 11
				day: 22.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 11
				day: 23.
			'joe'.
			33}.
		{Date
				year: 2015
				month: 11
				day: 23.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 11
				day: 23.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 24.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 11
				day: 24.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 11
				day: 25.
			'joe'.
			39}.
		{Date
				year: 2015
				month: 11
				day: 25.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 11
				day: 25.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 26.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 11
				day: 27.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 11
				day: 28.
			'joe'.
			35}.
		{Date
				year: 2015
				month: 11
				day: 28.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 11
				day: 29.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 11
				day: 29.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 11
				day: 30.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 11
				day: 30.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 11
				day: 30.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 1.
			'joe'.
			41}.
		{Date
				year: 2015
				month: 12
				day: 1.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 12
				day: 1.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 2.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 12
				day: 2.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 12
				day: 3.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 12
				day: 4.
			'joe'.
			34}.
		{Date
				year: 2015
				month: 12
				day: 4.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 4.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 5.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 12
				day: 5.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 5.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 6.
			'joe'.
			33}.
		{Date
				year: 2015
				month: 12
				day: 6.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 7.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 8.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 12
				day: 8.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 9.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 12
				day: 9.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 12
				day: 9.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 10.
			'joe'.
			31}.
		{Date
				year: 2015
				month: 12
				day: 10.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 12
				day: 10.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 11.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 12
				day: 11.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 12.
			'joe'.
			42}.
		{Date
				year: 2015
				month: 12
				day: 12.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 12
				day: 13.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 14.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 12
				day: 14.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 15.
			'joe'.
			39}.
		{Date
				year: 2015
				month: 12
				day: 16.
			'joe'.
			40}.
		{Date
				year: 2015
				month: 12
				day: 16.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 12
				day: 17.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 12
				day: 17.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 12
				day: 18.
			'joe'.
			37}.
		{Date
				year: 2015
				month: 12
				day: 18.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 12
				day: 18.
			'jessica'.
			26}.
		{Date
				year: 2015
				month: 12
				day: 19.
			'joe'.
			37}.
		{Date
				year: 2015
				month: 12
				day: 20.
			'joe'.
			34}.
		{Date
				year: 2015
				month: 12
				day: 20.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 20.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 12
				day: 21.
			'joe'.
			32}.
		{Date
				year: 2015
				month: 12
				day: 21.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 12
				day: 21.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 22.
			'joe'.
			34}.
		{Date
				year: 2015
				month: 12
				day: 22.
			'bill'.
			15}.
		{Date
				year: 2015
				month: 12
				day: 22.
			'jessica'.
			27}.
		{Date
				year: 2015
				month: 12
				day: 23.
			'joe'.
			38}.
		{Date
				year: 2015
				month: 12
				day: 23.
			'bill'.
			17}.
		{Date
				year: 2015
				month: 12
				day: 23.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 24.
			'joe'.
			33}.
		{Date
				year: 2015
				month: 12
				day: 24.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 12
				day: 24.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 12
				day: 25.
			'joe'.
			41}.
		{Date
				year: 2015
				month: 12
				day: 25.
			'jessica'.
			29}.
		{Date
				year: 2015
				month: 12
				day: 26.
			'jessica'.
			28}.
		{Date
				year: 2015
				month: 12
				day: 27.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 12
				day: 27.
			'bill'.
			19}.
		{Date
				year: 2015
				month: 12
				day: 27.
			'jessica'.
			25}.
		{Date
				year: 2015
				month: 12
				day: 28.
			'joe'.
			33}.
		{Date
				year: 2015
				month: 12
				day: 29.
			'joe'.
			36}.
		{Date
				year: 2015
				month: 12
				day: 29.
			'bill'.
			18}.
		{Date
				year: 2015
				month: 12
				day: 30.
			'joe'.
			41}.
		{Date
				year: 2015
				month: 12
				day: 30.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 12
				day: 31.
			'joe'.
			40}.
		{Date
				year: 2015
				month: 12
				day: 31.
			'bill'.
			16}.
		{Date
				year: 2015
				month: 12
				day: 31.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 1
				day: 1.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 1
				day: 1.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 1
				day: 2.
			'joe'.
			34}.
		{Date
				year: 2016
				month: 1
				day: 2.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 1
				day: 3.
			'joe'.
			35}.
		{Date
				year: 2016
				month: 1
				day: 3.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 3.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 1
				day: 4.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 1
				day: 4.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 4.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 1
				day: 5.
			'joe'.
			39}.
		{Date
				year: 2016
				month: 1
				day: 6.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 1
				day: 6.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 1
				day: 7.
			'joe'.
			32}.
		{Date
				year: 2016
				month: 1
				day: 7.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 1
				day: 8.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 1
				day: 8.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 1
				day: 9.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 1
				day: 9.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 1
				day: 9.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 10.
			'joe'.
			41}.
		{Date
				year: 2016
				month: 1
				day: 10.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 11.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 1
				day: 11.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 1
				day: 11.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 1
				day: 12.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 1
				day: 12.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 1
				day: 12.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 1
				day: 13.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 1
				day: 13.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 14.
			'joe'.
			42}.
		{Date
				year: 2016
				month: 1
				day: 14.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 1
				day: 14.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 1
				day: 15.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 1
				day: 16.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 1
				day: 16.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 1
				day: 16.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 1
				day: 17.
			'joe'.
			37}.
		{Date
				year: 2016
				month: 1
				day: 17.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 18.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 1
				day: 18.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 1
				day: 19.
			'joe'.
			34}.
		{Date
				year: 2016
				month: 1
				day: 19.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 19.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 21.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 1
				day: 23.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 1
				day: 23.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 1
				day: 23.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 24.
			'joe'.
			42}.
		{Date
				year: 2016
				month: 1
				day: 24.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 25.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 1
				day: 25.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 26.
			'joe'.
			39}.
		{Date
				year: 2016
				month: 1
				day: 26.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 1
				day: 26.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 27.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 1
				day: 27.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 1
				day: 28.
			'joe'.
			35}.
		{Date
				year: 2016
				month: 1
				day: 28.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 1
				day: 29.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 1
				day: 29.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 1
				day: 30.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 1
				day: 30.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 1
				day: 31.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 1
				day: 31.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 1
				day: 31.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 1.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 2
				day: 2.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 2
				day: 2.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 2
				day: 3.
			'joe'.
			31}.
		{Date
				year: 2016
				month: 2
				day: 3.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 3.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 2
				day: 4.
			'joe'.
			35}.
		{Date
				year: 2016
				month: 2
				day: 5.
			'joe'.
			42}.
		{Date
				year: 2016
				month: 2
				day: 5.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 2
				day: 5.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 6.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 2
				day: 6.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 2
				day: 7.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 2
				day: 7.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 2
				day: 8.
			'joe'.
			32}.
		{Date
				year: 2016
				month: 2
				day: 8.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 2
				day: 8.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 9.
			'joe'.
			35}.
		{Date
				year: 2016
				month: 2
				day: 9.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 10.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 10.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 2
				day: 11.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 2
				day: 11.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 2
				day: 12.
			'joe'.
			42}.
		{Date
				year: 2016
				month: 2
				day: 12.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 2
				day: 13.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 2
				day: 13.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 2
				day: 14.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 15.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 2
				day: 15.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 16.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 2
				day: 16.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 2
				day: 17.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 2
				day: 17.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 18.
			'joe'.
			37}.
		{Date
				year: 2016
				month: 2
				day: 18.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 2
				day: 19.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 2
				day: 19.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 20.
			'joe'.
			37}.
		{Date
				year: 2016
				month: 2
				day: 20.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 2
				day: 21.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 2
				day: 22.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 2
				day: 22.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 2
				day: 23.
			'joe'.
			34}.
		{Date
				year: 2016
				month: 2
				day: 23.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 2
				day: 23.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 2
				day: 24.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 2
				day: 24.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 2
				day: 25.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 2
				day: 25.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 2
				day: 25.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 2
				day: 26.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 2
				day: 27.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 2
				day: 28.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 2
				day: 28.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 2
				day: 28.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 3
				day: 1.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 2.
			'joe'.
			40}.
		{Date
				year: 2016
				month: 3
				day: 3.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 4.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 4.
			'jessica'.
			25}.
		{Date
				year: 2016
				month: 3
				day: 5.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 3
				day: 6.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 3
				day: 7.
			'joe'.
			39}.
		{Date
				year: 2016
				month: 3
				day: 7.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 7.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 3
				day: 8.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 8.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 9.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 3
				day: 9.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 9.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 10.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 3
				day: 10.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 10.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 3
				day: 11.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 3
				day: 11.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 3
				day: 12.
			'joe'.
			30}.
		{Date
				year: 2016
				month: 3
				day: 12.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 13.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 3
				day: 14.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 3
				day: 15.
			'joe'.
			37}.
		{Date
				year: 2016
				month: 3
				day: 15.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 15.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 16.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 16.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 17.
			'joe'.
			41}.
		{Date
				year: 2016
				month: 3
				day: 17.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 18.
			'joe'.
			38}.
		{Date
				year: 2016
				month: 3
				day: 18.
			'bill'.
			16}.
		{Date
				year: 2016
				month: 3
				day: 20.
			'joe'.
			39}.
		{Date
				year: 2016
				month: 3
				day: 20.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 3
				day: 20.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 3
				day: 21.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 22.
			'joe'.
			39}.
		{Date
				year: 2016
				month: 3
				day: 22.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 23.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 23.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 3
				day: 24.
			'bill'.
			15}.
		{Date
				year: 2016
				month: 3
				day: 24.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 3
				day: 25.
			'joe'.
			32}.
		{Date
				year: 2016
				month: 3
				day: 25.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 25.
			'jessica'.
			27}.
		{Date
				year: 2016
				month: 3
				day: 26.
			'joe'.
			41}.
		{Date
				year: 2016
				month: 3
				day: 26.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 3
				day: 27.
			'joe'.
			37}.
		{Date
				year: 2016
				month: 3
				day: 27.
			'bill'.
			19}.
		{Date
				year: 2016
				month: 3
				day: 28.
			'joe'.
			33}.
		{Date
				year: 2016
				month: 3
				day: 28.
			'jessica'.
			29}.
		{Date
				year: 2016
				month: 3
				day: 29.
			'joe'.
			36}.
		{Date
				year: 2016
				month: 3
				day: 29.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 29.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 3
				day: 30.
			'joe'.
			35}.
		{Date
				year: 2016
				month: 3
				day: 30.
			'bill'.
			18}.
		{Date
				year: 2016
				month: 3
				day: 30.
			'jessica'.
			26}.
		{Date
				year: 2016
				month: 3
				day: 31.
			'joe'.
			33}.
		{Date
				year: 2016
				month: 4
				day: 1.
			'bill'.
			17}.
		{Date
				year: 2016
				month: 4
				day: 1.
			'jessica'.
			28}.
		{Date
				year: 2016
				month: 4
				day: 2.
			'bill'.
			19}}
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsAndUserValues [
	<gtExample>
	<return: #Array>
	^ self commitsAndUserRawValues
		collect: [ :e | 
			OrderedDictionary new
				at: #date put: e first;
				at: #user put: e second;
				at: #commits put: e third;
				yourself ]
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> commitsBasicChart [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData lineChart |
	aData := GtPlotterDataGroup new values: self commits.

	lineChart := GtPlotterLineChart new.
	lineChart with: aData.
	lineChart valueX: #key.
	lineChart scaleX: GtPlotterTimeScale new.

	lineChart valueY: #value.
	lineChart scaleY: GtPlotterLinearScale new.

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> commitsChart [
	<gtExample>
	<return: #GtPlotterLineChart>
	| lineChart |
	lineChart := self commitsBasicChart.

	lineChart
		titleX: 'Date';
		titleY: 'Number of commits per day'.

	^ lineChart
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsPerDayOfAllUsersData [
	<gtExample>
	<return: #GtPlotterDataGroup>
	^ GtPlotterDataGroup new values: self commitsPerDayOfAllUsersValues
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsPerDayOfAllUsersValues [
	<gtExample>
	<return: #Array>
	| theValues aGroup perDay |
	theValues := self commitsAndUserValues.
	aGroup := theValues groupedBy: [ :eachData | eachData at: #date ].
	perDay := aGroup
			collect: [ :eachArray | 
				OrderedDictionary new
					at: #date put: (eachArray first at: #date);
					at: #commits put: (eachArray sum: [ :e | e at: #commits ]);
					at: #users put: (eachArray collect: [ :e | e at: #user ]);
					yourself ]
			as: Array.
	perDay sort: [ :a :b | (a at: #date) < (b at: #date) ].
	^ perDay
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> customPointStencilOwnsClickHandling [
	<gtExample>
	| chart marker spawned click clicked |
	chart := self highlightedPointsWithTooltips.
	marker := (chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ]) first.
	marker when: GtPhlowObjectToSpawn do: [ :event | spawned := event tool ].
	click := BlClickEvent new.
	marker fireEvent: click.
	self assert: click isConsumed not.
	self assert: spawned isNil.
	clicked := false.
	chart pointStencil: [ BlElement new
		size: 10 @ 10;
		when: BlClickEvent do: [ :event | clicked := true. event consumed: true ] ].
	marker := (chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ]) first.
	click := BlClickEvent new.
	marker fireEvent: click.
	self assert: clicked.
	self assert: click isConsumed.
	^ marker
]

{ #category : #'examples - axes' }
GtPlotterLineChartExamples >> dateAxisFormattingIsPreserved [
	<gtExample>
	| chart element date |
	chart := self plot.
	date := chart data values first key.
	self assert: (chart labelFormatX value: date) asString
		equals: date monthAbbreviation, ' ', date year asString.
	element := chart asElement.
	element constraintsDo: [ :c | c horizontal exact: 600. c vertical exact: 350 ].
	element forceLayout.
	^ element
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> definedLineColor [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData lineChart |
	aData := GtPlotterDataGroup new values: self commits.
	aData := aData background: Color blue.

	lineChart := GtPlotterLineChart new
			with: aData;
			valueX: #key;
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			valueY: #value;
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day'.

	^ lineChart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> highlightExplicitPointsByIdentity [
	<gtExample>
	| chart first equal selected markers |
	chart := self pointsPreserveOccurrences.
	first := chart data values first.
	equal := chart data values second.
	self assert: first = equal.
	self assert: (first == equal) not.
	selected := OrderedCollection with: first with: first with: 99 -> 99.
	self assert: (chart highlightPoints: selected) == chart.
	selected removeAll.
	markers := chart newPointElements.
	self assert: markers size equals: 2.
	markers do: [ :marker |
		self assert: (marker userData at: #plotterPointContext) originalValue == first ].
	self assert: (markers collect: [ :each | (each userData at: #plotterPointContext) index ]) asArray equals: #(1 3).
	chart highlightPoints: { equal }.
	self assert: chart newPointElements size equals: 1.
	self assert: (chart newPointElements first userData at: #plotterPointContext) originalValue == equal.
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> highlightSelectionIsFluentAndReplaced [
	<gtExample>
	| chart |
	chart := self pointsPreserveOccurrences.
	self assert: (chart highlightAllPoints) == chart.
	self assert: chart newPointElements size equals: 4.
	self assert: (chart highlightPointsWhere: [ :each | each key = 3 ]) == chart.
	self assert: chart newPointElements size equals: 1.
	chart highlightPoints: #().
	self assert: chart newPointElements isEmpty.
	chart highlightAllPoints.
	self assert: chart newPointElements size equals: 4.
	chart highlightPointsWhere: nil.
	self assert: chart newPointElements isEmpty.
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> highlightedPoints [
	<gtExample>
	| chart markers |
	chart := self plot.
	chart highlightPointsWhere: [ :observation | observation value > 20 ].
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers size equals: (chart data values select: [ :each | each value > 20 ]) size.
	self assert: markers notEmpty.
	markers do: [ :marker |
		| context |
		context := marker userData at: #plotterPointContext.
		self assert: context originalValue == (context group values at: context index).
		self assert: (chart normalizedPointFor: context originalValue)
			equals: ((chart newContentLineVerticesFor: context group) at: context index) ].
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> highlightedPointsComposite [
	<gtExample>
	| composite chart |
	chart := self highlightedPointsWithTooltips.
	composite := GtPlotterCompositeChart new.
	composite addPlot: chart.
	self assert: composite asElement children notEmpty.
	^ composite
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> highlightedPointsWithTooltips [
	<gtExample>
	| chart markers |
	chart := self highlightedPoints.
	chart pointStencil: [ :context |
		BlElement new
			geometry: BlSquareGeometry new;
			size: 12 @ 12;
			background: context group color;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude
				text: context originalValue printString) ].
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers first geometry class equals: BlSquareGeometry.
	self assert: markers first ~~ markers second.
	^ chart
]

{ #category : #'examples - hiking' }
GtPlotterLineChartExamples >> hikingProfile [
	<gtExample>
	<return: #GtPlotterLineChart>
	| chart stencil |
	chart := GtPlotterLineChart new
		with: ((GtPlotterDataGroup new values: self hikingProfileData)
			background: (Color r: 0.2 g: 0.5 b: 0.3));
		valueX: [ :sample | sample at: #distanceKm ];
		valueY: [ :sample | sample at: #elevationMetres ];
		titleX: 'Distance along an illustrative Alpine hike (km)';
		titleY: 'Elevation (m) · synthetic route';
		ticksX: 7;
		ticksY: 6;
		minY: 900;
		maxY: 2300;
		labelFormatX: [ :distance | (distance printShowingDecimalPlaces: 1), ' km' ];
		labelFormatY: [ :elevation | (elevation printShowingDecimalPlaces: 0), ' m' ];
		highlightPointsWhere: [ :sample | (sample at: #landmark) notEmpty ].
	stencil := chart pointStencil.
	chart pointStencil: [ :context |
		| sample |
		sample := context originalValue.
		(stencil value: context)
			size: 10 @ 10;
			background: Color orange;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude text:
				(sample at: #landmark), ' · ',
				((sample at: #distanceKm) printShowingDecimalPlaces: 1), ' km · ',
				((sample at: #elevationMetres) printShowingDecimalPlaces: 0), ' m');
			yourself ].
	^ chart
]

{ #category : #'examples - hiking' }
GtPlotterLineChartExamples >> hikingProfileData [
	<gtExample>
	^ #(
		(0.0 1050 'Trailhead')
		(0.5 1080 '')
		(1.0 1150 '')
		(1.5 1240 '')
		(2.0 1320 '')
		(2.5 1360 'Forest clearing')
		(3.0 1410 '')
		(3.5 1520 '')
		(4.0 1630 '')
		(4.5 1710 'Mountain hut')
		(5.0 1750 '')
		(5.5 1840 '')
		(6.0 1960 '')
		(6.5 2070 '')
		(7.0 2150 'Summit')
		(7.5 2110 '')
		(8.0 2010 '')
		(8.5 1920 'Mountain pass')
		(9.0 1950 '')
		(9.5 1890 '')
		(10.0 1760 '')
		(10.5 1650 '')
		(11.0 1580 'Alpine lake')
		(11.5 1510 '')
		(12.0 1380 '')
		(12.5 1250 '')
		(13.0 1170 '')
		(13.5 1100 'Village')) collect: [ :sample |
		Dictionary new
			at: #distanceKm put: sample first;
			at: #elevationMetres put: sample second;
			at: #landmark put: sample third;
			yourself ]
]

{ #category : #'examples - axes' }
GtPlotterLineChartExamples >> numericAxesWithHighlightedSingleton [
	<gtExample>
	| chart element |
	chart := self pointsEmptyAndSingleton.
	element := chart asElement.
	element constraintsDo: [ :c | c horizontal exact: 600. c vertical exact: 350 ].
	element forceLayout.
	self assert: (chart labelFormatX value: 1) asString equals: '1'.
	self assert: (chart labelFormatY value: 0.5) asString
		equals: (0.5 printShowingDecimalPlaces: 0).
	self assert: element children notEmpty.
	^ element
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plot [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData lineChart |
	aData := GtPlotterDataGroup new values: self commits.
	aData := aData background: Color blue.

	lineChart := GtPlotterLineChart new
			with: aData;
			valueX: #key;
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: #value;
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day';
			ticksY: 10.

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotCommitsByMonth [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData aChart |
	aData := self commitsAndUserDataGroupedByMonth.

	aChart := GtPlotterLineChart new
			with: aData;
			valueX: [ :e | e at: #date ];
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: [ :e | e at: #commits ];
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per month';
			ticksY: 10.

	^ aChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotCommitsOfAllUsers [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData aChart |
	aData := self commitsPerDayOfAllUsersData.

	aChart := GtPlotterLineChart new
			with: aData;
			valueX: [ :e | e at: #date ];
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: [ :e | e at: #commits ];
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day';
			ticksY: 10.

	^ aChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotCommitsPerUser [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData aChart |
	aData := self commitsAndUserDataGroupedByUser.

	aChart := GtPlotterLineChart new
			with: aData;
			valueX: [ :e | e at: #date ];
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: [ :e | e at: #commits ];
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day';
			ticksY: 10.

	^ aChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotCommitsPerUserAndMonth [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData aChart |
	aData := self commitsAndUserDataGroupedByUserAndMonth.

	aChart := GtPlotterLineChart new
			with: aData;
			valueX: [ :e | e at: #date ];
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: [ :e | e at: #commits ];
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day';
			ticksY: 10.

	^ aChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotEmptyData [
	<gtExample>
	<return: #GtPlotterLineChart>
	| aData lineChart |
	aData := GtPlotterDataGroup new values: #().
	aData := aData background: Color blue.

	lineChart := GtPlotterLineChart new
			with: aData;
			valueX: #key;
			scaleX: GtPlotterTimeScale new;
			titleX: 'Date';
			ticksX: 10;
			valueY: #value;
			scaleY: GtPlotterLinearScale new;
			titleY: 'Number of commits per day';
			ticksY: 10.

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotWithDefaultProjections [
	<gtExample>
	<return: #GtPlotterLineChart>
	| lineChart |
	lineChart := self plot.
	lineChart
		projectionXValues: [ :aData | aData values select: [ :e | e value > 20 ] ].

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotWithProjections [
	<gtExample>
	<return: #GtPlotterLineChart>
	| lineChart |
	lineChart := self plot.
	lineChart
		projectionXValues: [ :aData | aData values select: [ :e | e value > 20 ] ];
		projectionXLabelElement: [ :aGtPlotterScaleContext | 
			BlTextElement new
				text: (aGtPlotterScaleContext originalValue value asRopedText , ' commits' asRopedText
						foreground: Color gray) ];
		projectionXLabelStyle: [ :anElement :aGtPlotterScaleContext | 
			anElement
				background: BlBackground transparent;
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude
						text: aGtPlotterScaleContext originalValue key asRopedText) ];
		projectionXLineStyle: [ :anElement :aGtPlotterScaleContext | 
			anElement
				background: (aGtPlotterScaleContext originalValue value > 30
						ifTrue: [ Color red ]
						ifFalse: [ Color veryLightGray ]) ].

	^ lineChart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointStencilPreservesInspection [
	<gtExample>
	| chart marker original spawned click defaultStencil |
	chart := self highlightedPoints.
	defaultStencil := chart pointStencil.
	chart pointStencil: [ :context |
		(defaultStencil value: context)
			geometry: BlSquareGeometry new;
			yourself ].
	marker := (chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ]) first.
	original := (marker userData at: #plotterPointContext) originalValue.
	marker when: GtPhlowObjectToSpawn do: [ :event | spawned := event tool ].
	click := BlClickEvent new.
	marker fireEvent: click.
	self assert: click isConsumed.
	self assert: spawned notNil.
	self assert: spawned object == original.
	^ marker
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointStencilWithoutContextAndReset [
	<gtExample>
	| chart markers |
	chart := self highlightedPoints.
	self assert: (chart pointStencil: [ BlElement new geometry: BlSquareGeometry new; size: 10 @ 10 ]) == chart.
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers first geometry class equals: BlSquareGeometry.
	chart pointStencil: nil.
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers first geometry class equals: BlCircleGeometry.
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsAcrossGroupsAndProjections [
	<gtExample>
	| chart markers content |
	chart := self plotCommitsPerUser.
	chart highlightAllPoints.
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers size equals: chart data values size.
	markers do: [ :marker |
		| context |
		context := marker userData at: #plotterPointContext.
		self assert: context originalValue == (context group values at: context index) ].
	chart := self plotWithProjections.
	chart highlightPointsWhere: [ :each | each value > 20 ].
	content := chart contentStencil asElement.
	self assert: (content children select: [ :each | each userData includesKey: #plotterPointContext ]) size equals: (chart data values select: [ :each | each value > 20 ]) size.
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsClickToInspect [
	<gtExample>
	| chart marker original spawned click |
	chart := self highlightedPoints.
	marker := chart newPointElements first.
	original := (marker userData at: #plotterPointContext) originalValue.
	marker when: GtPhlowObjectToSpawn do: [ :event | spawned := event tool ].
	click := BlClickEvent new.
	marker fireEvent: click.
	self assert: click isConsumed.
	self assert: spawned notNil.
	self assert: spawned object == original.
	^ marker
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsDisabledAndNoMatches [
	<gtExample>
	| chart count content |
	chart := self plot.
	count := chart contentStencil asElement children size.
	self assert: chart newPointElements isEmpty.
	chart highlightPointsWhere: [ :each | false ].
	self assert: chart contentStencil asElement children size equals: count.
	chart highlightAllPoints.
	content := chart contentStencil asElement.
	self assert: (content children select: [ :each | each userData includesKey: #plotterPointContext ]) size equals: chart data values size.
	chart highlightPoints: #().
	self assert: chart contentStencil asElement children size equals: count.
	^ chart
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsEmptyAndSingleton [
	<gtExample>
	| empty singleton markers |
	empty := self plotEmptyData.
	empty highlightAllPoints.
	self assert: empty newPointElements isEmpty.
	self assert: empty asElement children notEmpty.
	singleton := GtPlotterLineChart new
		with: (GtPlotterDataGroup new values: { 1 -> 2 });
		minX: 0; maxX: 2; minY: 0; maxY: 4;
		highlightAllPoints.
	markers := singleton contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers size equals: 1.
	self assert: (singleton normalizedPointFor: 1 -> 2) equals: 0.5 @ 0.5.
	^ singleton
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsFollowResize [
	<gtExample>
	| chart content marker |
	chart := self pointsPreserveOccurrences.
	content := chart newContentElement.
	content constraintsDo: [ :c | c horizontal exact: 400. c vertical exact: 200 ].
	content forceLayout.
	marker := content children detect: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: marker bounds inParent center equals: 100 @ 100.
	self assert: marker extent equals: 8 @ 8.
	content constraintsDo: [ :c | c horizontal exact: 800. c vertical exact: 400 ].
	content forceLayout.
	self assert: marker bounds inParent center equals: 200 @ 200.
	self assert: marker extent equals: 8 @ 8.
	^ content
]

{ #category : #'examples - points' }
GtPlotterLineChartExamples >> pointsPreserveOccurrences [
	<gtExample>
	| first equal chart markers |
	first := 1 -> 2.
	equal := 1 -> 2.
	chart := GtPlotterLineChart new
		with: (GtPlotterDataGroup new values: { first. equal. first. 3 -> 4 });
		minX: 0; maxX: 4; minY: 0; maxY: 4;
		highlightPointsWhere: [ :each | each value = 2 ].
	markers := chart contentStencil asElement children
		select: [ :each | each userData includesKey: #plotterPointContext ].
	self assert: markers size equals: 3.
	self assert: (markers first userData at: #plotterPointContext) originalValue == first.
	self assert: (markers second userData at: #plotterPointContext) originalValue == equal.
	self assert: (markers third userData at: #plotterPointContext) originalValue == first.
	self assert: (markers collect: [ :each | (each userData at: #plotterPointContext) index ]) asArray equals: #(1 2 3).
	self assert: (chart normalizedPointFor: first) equals: 0.25 @ 0.5.
	^ chart
]

{ #category : #'examples - temperature' }
GtPlotterLineChartExamples >> temperatureOverTwoDays [
	<gtExample>
	<return: #GtPlotterLineChart>
	| source readings peaks chart stencil |
	source := self temperatureSourceData.
	readings := (source at: #temperatures) collectWithIndex: [ :temperature :index |
		((source at: #start) + (index - 1) hours) -> temperature ].
	peaks := { (readings first: 24) detectMax: #value.
		(readings last: 24) detectMax: #value }.
	chart := GtPlotterLineChart new
		with: ((GtPlotterDataGroup new values: readings) background: (Color r: 0.15 g: 0.45 b: 0.7));
		scaleX: GtPlotterTimeScale new;
		valueX: #key;
		valueY: #value;
		titleX: 'Bern · 1–2 July 2024 · UTC';
		titleY: 'Air temperature at 2 m (°C) · Open-Meteo';
		ticksX: 8;
		ticksY: 6;
		minY: 12;
		maxY: 23;
		labelFormatX: [ :time | time dayOfMonth asString, ' Jul ', (time hour printString padLeftTo: 2 with: $0), ':00' ];
		labelFormatY: [ :temperature | (temperature printShowingDecimalPlaces: 0), ' °C' ];
		highlightPoints: peaks.
	stencil := chart pointStencil.
	chart pointStencil: [ :context |
		(stencil value: context)
			size: 10 @ 10;
			background: Color red;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude text:
				context originalValue key printString, ' · ',
				(context originalValue value printShowingDecimalPlaces: 1), ' °C');
			yourself ].
	^ chart
]

{ #category : #'examples - temperature' }
GtPlotterLineChartExamples >> temperatureSourceData [
	<gtExample>
	^ Dictionary new
		at: #source put: 'Open-Meteo Historical Weather API (gridded historical weather, not a station observation)';
		at: #url put: 'https://archive-api.open-meteo.com/v1/archive?latitude=46.948&longitude=7.4474&start_date=2024-07-01&end_date=2024-07-02&hourly=temperature_2m&timezone=UTC';
		at: #location put: 'Bern, Switzerland';
		at: #latitude put: 46.924427;
		at: #longitude put: 7.439222;
		at: #unit put: '°C';
		at: #start put: (DateAndTime fromString: '2024-07-01T00:00:00+00:00');
		at: #temperatures put: #(15.0 15.7 14.2 15.4 15.3 15.2 15.6 16.0 17.0 18.0 19.2 20.3 20.2 21.0 21.2 19.2 17.4 17.5 16.7 16.2 14.7 14.5 13.5 13.7 13.3 14.6 14.6 14.5 14.1 13.7 13.8 14.3 14.8 16.1 16.8 17.7 18.9 19.1 18.5 17.5 15.8 15.5 14.9 14.4 13.9 13.7 13.6 13.4);
		yourself
]
