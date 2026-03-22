Class {
	#name : #GtPlotterScaleBasedElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #accessing }
GtPlotterScaleBasedElementExamples class >> normalDistribution [
	^ #(0.0 0.0897 0.18130000000000002 0.2222 0.3211 0.3249 0.3317 0.33680000000000004 0.33790000000000003 0.3587 0.35950000000000004 0.365 0.39180000000000004 0.3947 0.3987 0.40280000000000005 0.4038 0.40940000000000004 0.4118 0.4171 0.4184 0.43520000000000003 0.441 0.4495 0.4509 0.454 0.4559 0.4559 0.4562 0.4575 0.45880000000000004 0.4602 0.4743 0.47840000000000005 0.4812 0.4888 0.48910000000000003 0.4897 0.4913 0.506 0.5159 0.5205000000000001 0.5213 0.5225000000000001 0.5236000000000001 0.5312 0.5361 0.5474 0.5596 0.5645 0.5654 0.5661 0.5662 0.5730000000000001 0.5767 0.5799000000000001 0.5835 0.5936 0.5942000000000001 0.5958 0.597 0.602 0.6025 0.6072000000000001 0.609 0.6097 0.6141 0.6146 0.6204000000000001 0.6225 0.6231 0.6358 0.6386000000000001 0.6489 0.6724 0.6751 0.6779000000000001 0.6784 0.6833 0.6858000000000001 0.7059000000000001 0.7103 0.7139 0.7177 0.7189 0.7295 0.7307 0.7428 0.7565000000000001 0.7701 0.773 0.7774000000000001 0.8072 0.8165 0.8385 0.8553000000000001 0.8591000000000001 0.8676 0.8764000000000001 1.0)
]

{ #category : #accessing }
GtPlotterScaleBasedElementExamples class >> points [
	<script: 'self points'>
	^ #(4.175 6.65 4.325 8.3 5.925 4.15 7.075 9.5 7.775 8.05 9.325 11.6 9.325 6.55 11.975 6.65 12.025 8.8 11.675 9.85 10.025 9.9 8.825 12.75 12.225 13.25 13.325 10.2 15.125 8.15 15.125 8.15 15.825 9.35 18.775 8.25 18.825 8.7 18.825 13.75 16.325 14 14.175 10.7 16.075 12.1 15.025 14.2 19.075 17 20.325 16.1 20.475 15.2 20.175 11.1 17.575 11.25 21.125 13.7 24.325 15.45 26.375 15.75 25.325 17.15 24.625 18.5 21.975 16.5 20.825 11.25 22.475 14.35 21.075 13.55 12.225 12.95 12.075 11.9 9.825 8.85 7.475 6.4 5.425 5.55 6.725 7.65 3.875 4.95 2.775 6.95 2.825 4.75) pairsCollect: [ :a :b | a @ b ]
]

{ #category : #'examples - axis' }
GtPlotterScaleBasedElementExamples >> compositeAxis [
	<gtExample>
	<return: #BrFrame>
	^ BrFrame new
		hMatchParent;
		vExact: 50;
		addChildren: {self fineGrainedTicks.
				self rareTicks.
				self horizontalTickLabels.
				self valueProjections}
]

{ #category : #'examples - ticks' }
GtPlotterScaleBasedElementExamples >> fineGrainedTicks [
	<gtExample>
	<return: #GtPlotterHorizontalTicksElement>
	^ GtPlotterHorizontalTicksElement new
		weight: 0.4;
		padding: self padding;
		tickStyle: [ :anElement :aGtPlotterScaleContext | 
			anElement
				background: ((aGtPlotterScaleContext index % 4) isZero not
						ifTrue: [ Color gray alpha: 0.3 ]
						ifFalse: [ Color transparent ]);
				constraintsDo: [ :c | c frame vertical alignBottom ] ];
		ticks: 25
]

{ #category : #'examples - gridline' }
GtPlotterScaleBasedElementExamples >> horizontalGridlines [
	<gtExample>
	<return: #GtPlotterHorizontalTicksElement>
	^ GtPlotterHorizontalTicksElement new
		weight: 1;
		padding: self horizontalPadding;
		tickStyle: [ :anElement | anElement background: (Color gray alpha: 0.5) ];
		ticks: 4
]

{ #category : #accessing }
GtPlotterScaleBasedElementExamples >> horizontalPadding [
	^ BlInsets left: 10 right: 10
]

{ #category : #'examples - bar' }
GtPlotterScaleBasedElementExamples >> horizontalSingleBar [
	<gtExample>
	<return: #GtPlotterHorizontalValueBarsElement>
	^ GtPlotterHorizontalValueBarsElement new
		height: 30;
		valueElement: [ BlElement new ];
		valueStyle: [ :anElement :aGtScaleContext | 
			| aNumber |
			aNumber := aGtScaleContext originalValue.

			anElement
				geometry: BlStadiumGeometry new;
				background: (aNumber < 0.5
						ifTrue: [ Color red alpha: aNumber * 2 ]
						ifFalse: [ Color blue alpha: (aNumber - 0.5) * 2 ]) ];
		values: #(0.2 0.7) reversed
]

{ #category : #'examples - labels' }
GtPlotterScaleBasedElementExamples >> horizontalTickLabels [
	<gtExample>
	<return: #GtPlotterHorizontalTickLabelsElement>
	^ GtPlotterHorizontalTickLabelsElement new
		padding: self padding;
		labelFormat: [ :aValue | (aValue printShowingDecimalPlaces: 1) asRopedText foreground: Color darkGray ];
		labelStyle: [ :anElement | 
			(anElement background: Color white)
				constraintsDo: [ :c | 
					c frame vertical alignTop.
					c horizontal fitContent.
					c vertical fitContent ] ]
]

{ #category : #'examples - list' }
GtPlotterScaleBasedElementExamples >> listOfHorizontalBars [
	<gtExample>
	<return: #GtPlotterSingleScaleScrollElement>
	| theData aScrollable aHeightScale |
	theData := self listOfHorizontalBarsData.
	theData := theData collect: [ :eachArray | eachArray sorted ].
	theData := theData sorted: [ :a :b | a size > b size ].

	aHeightScale := GtPlotterLinearScale new
			domainFrom: 0 to: theData first size;
			rangeFrom: 10 to: 30.

	aScrollable := GtPlotterSingleScaleScrollElement new.
	aScrollable
		stencil: [ :eachCollectionOfItems | 
			GtPlotterHorizontalValueBarsElement new
				height: (aHeightScale map: eachCollectionOfItems size);
				valueStyle: [ :anElement :aGtScaleContext | 
					anElement
						geometry: BlStadiumGeometry new;
						background: (Color gray alpha: 0.2) ];
				values: eachCollectionOfItems ].

	aScrollable values: theData.

	^ aScrollable
]

{ #category : #'examples - list' }
GtPlotterScaleBasedElementExamples >> listOfHorizontalBarsData [
	^ #(#(0.7 0.3 0.25 0.95 0.85 0.95 0.35) #(0.7 1.0 0.15 0.95 0.6 0.75 0.1) #(0.85) #(0.4 0.25 0.4 0.7 0.25 0.95 1.0) #(0.25 0.2 0.15 0.35 1.0 0.1) #(0.05 0.1 0.05 0.25 0.65 0.6) #(0.7 0.25 0.35 0.05) #(0.65 1.0) #(0.75 0.45 0.65 0.25) #(0.3) #(0.25 0.45 0.9 0.15) #(0.9) #(0.4 1.0 0.45 0.55 0.8 0.45 0.65) #(0.7 0.5 0.45 0.85 0.3 0.4 0.05) #(0.45 0.5 0.65) #(0.3 0.45 0.35 0.25 0.05 0.1 0.65) #(0.5) #(0.5 0.4 0.6 0.55 0.2 0.3 0.25 0.35) #(0.45 0.95 0.25 0.2 0.6 0.15 0.95 0.35) #(0.8 0.55 0.35 0.2) #(1.0 0.7 0.45 0.35 0.15 0.9 0.45) #(0.15 0.7 0.95 0.1 0.6) #(1.0 0.65 0.8 0.1 0.8 0.65) #(0.2 0.4 0.85 0.5 0.55 0.7) #(0.3 0.25 0.55 0.4 0.95 0.55 0.6) #(0.75 0.25 0.7 0.4 0.2 0.55) #(0.7) #(0.6 0.15 0.05) #(0.6 0.25 0.15 0.45) #(0.1 1.0 0.75 0.3 0.4 0.3 0.9) #(0.55 0.35 0.7) #(0.1 0.4 0.5 0.1 0.65 0.85) #(0.7 0.5 0.35 0.9 1.0 0.6) #(0.3 0.2 0.3 1.0 0.75) #(0.05 0.85 0.15 0.6 0.7) #(0.3) #(0.8 1.0) #(0.55 0.15 1.0 0.2) #(0.5 0.05 0.75 0.3 0.65) #(0.7 0.25) #(0.8 0.1 0.75) #(0.4 0.8 0.85 0.05 0.75 0.4 0.3) #(0.7 0.65 0.2 0.4 0.7 0.45 0.1 0.8) #(0.95 0.65 1.0 0.6 0.1 0.9) #(0.65 0.7 0.75 0.8 0.55 0.5 0.2 0.6) #(0.5 0.85 0.05 0.65 0.4 0.65 0.35 0.9) #(0.05 0.7 0.3 0.2 0.9 0.95 0.7) #(0.05 0.5 0.55 0.6 0.9) #(0.6) #(0.75) #(0.3) #(0.15 0.05 0.5 0.15 0.65 0.7 0.5 0.25) #(0.2 0.2 0.65 0.65) #(0.65 0.25 0.55 0.95 0.9 0.05) #(0.75) #(0.9 0.75) #(0.85 0.3) #(0.45 0.95 0.5 0.5 0.15 0.6 0.3) #(0.4 0.05 0.7) #(0.25 0.7 0.85 0.9 0.3 0.65 0.55 0.3) #(0.65 0.65 0.3 0.45 0.1 0.35 0.3) #(0.65 0.05 0.95 0.95 0.45) #(0.45 0.8 0.85 0.55 0.85) #(0.5 1.0 0.6 1.0 0.05) #(0.8 0.75 0.45 0.45) #(0.75 0.85 0.9) #(0.6 0.85 0.6 0.3) #(0.25 0.65 0.1 0.1 0.05 1.0 0.05 0.7) #(0.45 1.0 0.8 0.1) #(0.05 1.0 0.8 0.25 0.95 0.55) #(0.1 0.15 0.95 0.75 0.8 0.35 0.05) #(0.95) #(0.8 0.65 0.65 1.0 0.65 0.8 0.7) #(0.8 0.2 0.85 0.65 0.9 0.45 0.15) #(0.4 0.8 0.75 0.5 0.2 0.8) #(0.25 0.2 1.0 0.7 0.65 0.8 0.15 0.65) #(0.75) #(0.85 0.3 0.05 0.1) #(0.95 0.25 0.55 0.05 0.35 0.3) #(0.6 0.2 0.3 0.45 0.9 0.9 0.75) #(0.05 0.45 0.35) #(0.7 0.85 0.15 0.8 0.75 0.7 0.7) #(0.25 0.1) #(0.95 0.05 0.45 0.05 0.95 0.8 0.45 0.2) #(0.9 0.6) #(0.8) #(0.1 0.4 0.45 0.2 0.35 0.05 0.5) #(0.6) #(0.7 0.15 0.05) #(0.65 0.2 0.45 0.85 0.4 0.2 0.5 0.55) #(0.95) #(0.55) #(0.6 0.05 0.45 0.25 0.7) #(0.3 0.3 0.55 0.25 0.5 0.45 0.05 0.15) #(0.65 0.4 0.75) #(0.05 0.55 0.35 0.6 0.65 0.2 0.6) #(0.1 0.95 0.9 0.15 0.15 0.15 0.55) #(0.8) #(0.05 0.05 1.0 0.1 0.15) #(0.25 0.15 0.1 0.1))
]

{ #category : #'examples - markers' }
GtPlotterScaleBasedElementExamples >> markers [
	<gtExample>
	<return: #GtPlotterMarkersElement>
	^ GtPlotterMarkersElement new
		x: [ :each | each x ];
		y: [ :each | each y ];
		padding: self padding;
		values: (self class normalDistribution
				with: self class normalDistribution shuffled
				collect: [ :x :y | x @ y ])
]

{ #category : #accessing }
GtPlotterScaleBasedElementExamples >> padding [
	^ BlInsets left: 10 right: 10
]

{ #category : #'examples - plot' }
GtPlotterScaleBasedElementExamples >> plot [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		matchParent;
		padding: (BlInsets all: 10);
		addChildren: {self compositeAxis.
				BrFrame new
					matchParent;
					addChildren: {self horizontalGridlines.
							self verticalGridlines.
							self markers}}
]

{ #category : #'examples - ticks' }
GtPlotterScaleBasedElementExamples >> rareTicks [
	<gtExample>
	<return: #GtPlotterHorizontalTicksElement>
	^ GtPlotterHorizontalTicksElement new
		weight: 1;
		padding: self padding;
		tickStyle: [ :anElement | 
			anElement
				background: (Color gray alpha: 0.5);
				width: 1 ];
		ticks: 4
]

{ #category : #'examples - bar' }
GtPlotterScaleBasedElementExamples >> singleBar [
	<gtExample>
	<return: #GtPlotterHorizontalValueBarsElement>
	^ GtPlotterHorizontalValueBarsElement new
		height: 30;
		valueElement: [ BlElement new ];
		valueStyle: [ :anElement :aGtScaleContext | 
			| aNumber |
			aNumber := aGtScaleContext originalValue.

			anElement
				geometry: BlStadiumGeometry new;
				background: (aNumber < 0.5
						ifTrue: [ Color red alpha: aNumber * 2 ]
						ifFalse: [ Color blue alpha: (aNumber - 0.5) * 2 ]) ];
		values: #(0.2 0.7) reversed
]

{ #category : #'examples - ticks' }
GtPlotterScaleBasedElementExamples >> valueProjections [
	<gtExample>
	<return: #GtPlotterHorizontalValueProjectionsElement>
	^ GtPlotterHorizontalValueProjectionsElement new
		weight: 0.3;
		padding: self padding;
		valueStyle: [ :anElement | 
			anElement
				background: Color gray;
				constraintsDo: [ :c | c frame vertical alignBottom ] ];
		values: GtPlotterScaleBasedElementExamples normalDistribution
]

{ #category : #'examples - gridline' }
GtPlotterScaleBasedElementExamples >> verticalGridlines [
	<gtExample>
	<return: #GtPlotterVerticalTicksElement>
	^ GtPlotterVerticalTicksElement new
		weight: 1;
		padding: self horizontalPadding;
		tickStyle: [ :anElement | anElement background: (Color gray alpha: 0.5) ];
		ticks: 4
]

{ #category : #accessing }
GtPlotterScaleBasedElementExamples >> verticalPadding [
	^ BlInsets top: 10 bottom: 10
]

{ #category : #'examples - bar' }
GtPlotterScaleBasedElementExamples >> verticalSingleBar [
	<gtExample>
	<return: #GtPlotterVerticalValueBarsElement>
	^ GtPlotterVerticalValueBarsElement new
		width: 30;
		valueElement: [ BlElement new ];
		valueStyle: [ :anElement :aGtScaleContext | 
			| aNumber |
			aNumber := aGtScaleContext originalValue.

			anElement
				geometry: (BlRoundedRectangleGeometry cornerRadius: 15);
				background: (aNumber < 0.5
						ifTrue: [ Color red alpha: aNumber * 2 ]
						ifFalse: [ Color blue alpha: (aNumber - 0.5) * 2 ]) ];
		values: #(0.2 0.7) reversed
]

{ #category : #'examples - labels' }
GtPlotterScaleBasedElementExamples >> verticalTickLabels [
	<gtExample>
	<return: #GtPlotterVerticalTickLabelsElement>
	^ GtPlotterVerticalTickLabelsElement new
		padding: self padding;
		labelFormat: [ :aValue | (aValue printShowingDecimalPlaces: 1) asRopedText foreground: Color darkGray ];
		labelStyle: [ :anElement | 
			(anElement background: Color white)
				constraintsDo: [ :c | 
					c frame horizontal alignLeft.
					c horizontal fitContent.
					c vertical fitContent ] ]
]
