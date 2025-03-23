"
I exemplify {{gtClass:GtPlotterHorizontalBarChart}}.
"
Class {
	#name : #GtPlotterHorizontalBarChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'example - dependencies' }
GtPlotterHorizontalBarChartExamples >> brickDependenciesSizesBarChart [
	<gtExample>
	| projects packages theData maxLines aBarWidthScale barChart |
	projects := BaselineOfBrick version
			withDeepCollect: [ :each | each projects collect: #version ]
			as: Set.
	packages := projects
			collect: [ :project | 
				{project.
					project gtRPackages sumNumbers: #linesOfCode} ].
	theData := GtPlotterDataGroup new values: packages.
	theData := theData sorted: [ :a :b | a last > b last ].
	theData := theData
			labelled: [ :each | each first gtDisplayString gtRemovePrefix: 'BaselineOf' ].
	theData := theData background: [ :each | Color blue alpha: 0.5 ].

	maxLines := theData
			inject: 0
			intoValues: [ :anAmount :eachValue | anAmount max: eachValue last ].
	aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: maxLines.

	barChart := GtPlotterHorizontalBarChart new.
	barChart
		barElement: [ :aGtPlotterContext | 
			BlElement new
				aptitude: ((BrGlamorousWithExplicitTooltipAptitude
						text: aGtPlotterContext originalValue second)
						hideDelay: 0;
						showDelay: 0) ].
	barChart barLabelSpacing: 160.
	barChart barWidthScale: aBarWidthScale.
	barChart barWidthData: [ :eachValue | eachValue last ].
	barChart amountOfTicks: 4.
	barChart with: theData.

	^ barChart
]

{ #category : #'example - browser data' }
GtPlotterHorizontalBarChartExamples >> browserDataChart [
	<gtExample>
	| theColors theData barChart aMaxDuration aBarWidthScale |
	
	theColors := { 
		#low -> Color gray.
		#medium -> Color orange.
		#high -> Color red
	} asOrderedDictionary.
	
	theData := GtPlotterDataGroup new values: (GtPlotterDataGroupExamples new browserData first: 20).
	theData := theData sorted: [ :a :b | (a at: #duration) > (b at: #duration) ].
	
	theData := theData
		groupedBy: [ :eachValue | eachValue at: #browser ]
		sorted: [ :a :b | a < b ]
		labelled: #yourself.

	theData := theData
		groupedBy: [ :eachValue | eachValue at: #danger ]
		sorted: [ :a :b | (theColors indexOfKey: a) > (theColors indexOfKey: b) ]
		colored: [ :eachDanger | theColors at: eachDanger ].

	aMaxDuration := theData inject: 0 days intoValues: [ :aDuration :eachValue | aDuration max: (eachValue at: #duration) ].
	aBarWidthScale := GtPlotterDurationScale new domainFrom: 0 minutes to: (aMaxDuration / 1 year) ceiling years.

	barChart := GtPlotterHorizontalBarChart new.
	barChart barElement: [ BlElement new geometry: BlStadiumGeometry new ].
	barChart barWidthScale: aBarWidthScale.
	barChart barWidthData: [ :eachValue | eachValue at: #duration ].
	barChart amountOfTicks: 4.
	barChart with: theData.

	^ barChart
]

{ #category : #'example - website visits' }
GtPlotterHorizontalBarChartExamples >> chartWebsiteVisits [
	<gtExample>
	| theData |

	theData := GtPlotterDataGroup new values: self websiteVisits.
	theData := theData sorted: [ :a :b | (a at: #duration) > (b at: #duration) ].
	theData := theData labelled: [ :each | each at: #domain ].	

	^ self websiteVisitsChartFromData: theData
]

{ #category : #'example - website visits' }
GtPlotterHorizontalBarChartExamples >> chartWebsiteVisitsGroupedByZone [
	<gtExample>
	| theData |

	theData := GtPlotterDataGroup new values: self websiteVisits.
	theData := theData sorted: [ :a :b | (a at: #duration) > (b at: #duration) ].
	theData := theData
		groupedBy: [ :each | ((each at: #domain) splitOn: '.') last ]
		labelled: #yourself.

	^ self websiteVisitsChartFromData: theData
]

{ #category : #'example - website visits' }
GtPlotterHorizontalBarChartExamples >> chartWebsiteVisitsGroupedByZoneAndColored [
	<gtExample>
	| theData theColors |
	
	theColors := { 
		#com -> Color gray.
	} asOrderedDictionary.

	theData := GtPlotterDataGroup new values: self websiteVisits.
	theData := theData sorted: [ :a :b | (a at: #duration) > (b at: #duration) ].
	theData := theData
		groupedBy: [ :each | ((each at: #domain) splitOn: '.') last ]
		then: [ :eachGroup :eachZone |
			| aColor |
			aColor := theColors
				at: eachZone
				ifAbsent: [ Color veryVeryLightGray ].
			(eachGroup background: aColor) labelled: eachZone ].

	^ self websiteVisitsChartFromData: theData
]

{ #category : #'example - sequoia' }
GtPlotterHorizontalBarChartExamples >> sequoiaSearchResults [
	<gtExample>
	| theData barChart aMaxPages aBarWidthScale border threshold |
		
	theData := GtPlotterDataGroup new values: self sequoias.
	theData := theData labelled: [ :each | each at: #species ].
	theData := theData background: [ :each | (each at: #extinct)
		ifTrue: [ Color r: 216 g: 55 b: 62 range: 255 ]
		ifFalse: [ Color r: 66 g: 188 b: 238 range: 255 ] ].

	aMaxPages := theData inject: 0 intoValues: [ :anAmount :eachValue | anAmount max: (eachValue at: #pages) ].
	aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: aMaxPages.

	barChart := GtPlotterHorizontalBarChart new.
	barChart barLabelSpacing: 185.
	barChart barWidthScale: aBarWidthScale.
	barChart barWidthData: [ :eachValue | eachValue at: #pages ].
	barChart amountOfTicks: 4.
	barChart with: theData.
	
	threshold := 10000.
	border := BlBorderBuilder new
		paint: Color blue;
		dashed;
		capRound;
		width: 2;
		build.
	barChart newVerticalLine
		lineStencil: [ BlLineElement new border: border ];
		dataValue: threshold.
	
	^ barChart
]

{ #category : #'example - sequoia' }
GtPlotterHorizontalBarChartExamples >> sequoiaSearchResultsGroupedByGenus [
	<gtExample>
	| theData barChart aMaxPages aBarWidthScale |
	theData := GtPlotterDataGroup new values: self sequoias.

	theData := theData sorted: [ :a :b | (a at: #pages) > (b at: #pages) ].

	theData := theData
			groupedBy: [ :each | each at: #genus ]
			sorted: [ :a :b | a < b ]
			labelled: [ :eachGenus | eachGenus ].

	theData := theData
			background: [ :each | 
				(each at: #extinct)
					ifTrue: [ Color
							r: 216
							g: 55
							b: 62
							range: 255 ]
					ifFalse: [ Color
							r: 66
							g: 188
							b: 238
							range: 255 ] ].

	aMaxPages := theData
			inject: 0
			intoValues: [ :anAmount :eachValue | anAmount max: (eachValue at: #pages) ].
	aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: aMaxPages.

	barChart := GtPlotterHorizontalBarChart new.
	barChart
		barElement: [ :aGtPlotterContext | 
			BlElement new
				aptitude: ((BrGlamorousWithExplicitTooltipAptitude
						text: (aGtPlotterContext originalValue at: #species))
						hideDelay: 0;
						showDelay: 0) ].
	barChart barLabelSpacing: 125.
	barChart barWidthScale: aBarWidthScale.
	barChart barWidthData: [ :eachValue | eachValue at: #pages ].
	barChart amountOfTicks: 4.
	barChart with: theData.

	^ barChart
]

{ #category : #'example - sequoia' }
GtPlotterHorizontalBarChartExamples >> sequoiaSearchResultsGroupedByGenusAndExtinctAsAdjacentBars [
	<gtExample>
	| theData barChart aMaxPages aBarWidthScale aBarHeightScale |
		
	theData := GtPlotterDataGroup new values: self sequoias.
	
	theData := theData sorted: [ :a :b | (a at: #pages) > (b at: #pages) ].
	
	theData := theData
		groupedBy: [ :each | each at: #genus ]
		sorted: [ :a :b | a key < b key ]
		labelled: [ :eachGenus | eachGenus ].
	
	theData := theData
		groupedBy: [ :each | each at: #extinct ]
		sorted: [ :a :b | a key not ]
		colored: [ :isExtinct | isExtinct
			ifTrue: [ Color r: 216 g: 55 b: 62 range: 255 ]
			ifFalse: [ Color r: 66 g: 188 b: 238 range: 255 ] ].

	aMaxPages := theData inject: 0 intoValues: [ :anAmount :eachValue | anAmount max: (eachValue at: #pages) ].
	aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: aMaxPages.
	aBarHeightScale := GtPlotterLinearScale new
		domainFrom: 0 to: theData size;
		rangeFrom: 10 to: 60.

	barChart := GtPlotterHorizontalBarChart new.
	barChart withAdjacentBars.
	barChart groupSpacing: 5.
	barChart barLabelSpacing: 125.
	barChart barWidthScale: aBarWidthScale.
	barChart barWidthData: [ :eachValue | eachValue at: #pages ].
	barChart barHeightScale: aBarHeightScale.
	barChart barHeightData: [ :eachGroup | eachGroup size ].
	barChart amountOfTicks: 4.
	barChart with: theData.

	^ barChart
]

{ #category : #'example - website visits' }
GtPlotterHorizontalBarChartExamples >> websiteVisitsChartFromData: theData [
	| aMaxDuration aBarWidthScale aMaxFrequency aBarHeightScale barChart border threshold |

	aMaxDuration := theData inject: 0 days intoValues: [ :aDuration :eachValue | aDuration max: (eachValue at: #duration) ].
	aBarWidthScale := GtPlotterDurationScale new domainFrom: 0 minutes to: aMaxDuration.

	aMaxFrequency := theData inject: 0 intoValues: [ :aDuration :eachValue | aDuration max: (eachValue at: #frequency) ].
	aBarHeightScale := GtPlotterLinearScale new
		domainFrom: 0 to: aMaxFrequency;
		rangeFrom: 10 to: 40.

	barChart := GtPlotterHorizontalBarChart new
		barLabelSpacing: 120;
		barGap: 6;
		barWidthScale: aBarWidthScale;
		barWidthData: [ :eachValue | eachValue at: #duration ];
		barHeightScale: aBarHeightScale;
		barHeightData: [ :eachValue | eachValue at: #frequency ];
		amountOfTicks: 4;
		with: theData.
	threshold := 5 minutes.
	border := BlBorderBuilder new
		paint: Color blue;
		dashed;
		capRound;
		width: 2;
		build.
	barChart newVerticalLine 
		lineStencil: [ BlLineElement new border: border ];
		dataValue: threshold.
	^ barChart
]
