Class {
	#name : #GtPlotterLineChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commits [
	<gtExample>
	^ GtPlotterRawLineExamples new commits
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUsers [
	<gtExample>
	^ self commitsAndUsersData collect: [ :e | 
		OrderedDictionary new
			at: #date put: e first;
			at: #user put: e second;
			at: #commits put: e third;
			yourself ]
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUsersData [
	<gtExample>

	^ {
		{ Date year: 2015 month: 10 day: 5. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 6. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 7. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 8. 'jessica'. 28 }.
		{ Date year: 2015 month: 10 day: 9. 'joe'. 36 }.
		{ Date year: 2015 month: 10 day: 10. 'bill'. 15 }.
		{ Date year: 2015 month: 10 day: 11. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 12. 'joe'. 36 }.
		{ Date year: 2015 month: 10 day: 13. 'bill'. 15 }.
		{ Date year: 2015 month: 10 day: 14. 'jessica'. 25 }.
		{ Date year: 2015 month: 10 day: 15. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 16. 'joe'. 35 }.
		{ Date year: 2015 month: 10 day: 17. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 18. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 19. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 20. 'joe'. 37 }.
		{ Date year: 2015 month: 10 day: 21. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 22. 'joe'. 42 }.
		{ Date year: 2015 month: 10 day: 23. 'bill'. 16 }.
		{ Date year: 2015 month: 10 day: 24. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 25. 'joe'. 35 }.
		{ Date year: 2015 month: 10 day: 26. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 27. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 28. 'joe'. 38 }.
		{ Date year: 2015 month: 10 day: 29. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 30. 'jessica'. 25 }.
		{ Date year: 2015 month: 10 day: 31. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 1. 'joe'. 31 }.
		{ Date year: 2015 month: 11 day: 2. 'joe'. 39 }.
		{ Date year: 2015 month: 11 day: 3. 'joe'. 35 }.
		{ Date year: 2015 month: 11 day: 4. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 5. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 6. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 7. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 8. 'joe'. 35 }.
		{ Date year: 2015 month: 11 day: 9. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 10. 'joe'. 34 }.
		{ Date year: 2015 month: 11 day: 11. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 12. 'bill'. 17 }.
		{ Date year: 2015 month: 11 day: 13. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 14. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 15. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 16. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 17. 'joe'. 31 }.
		{ Date year: 2015 month: 11 day: 18. 'bill'. 18 }.
		{ Date year: 2015 month: 11 day: 19. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 20. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 21. 'joe'. 41 }.
		{ Date year: 2015 month: 11 day: 22. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 23. 'joe'. 31 }.
		{ Date year: 2015 month: 11 day: 24. 'joe'. 41 }.
		{ Date year: 2015 month: 11 day: 25. 'joe'. 36 }.
		{ Date year: 2015 month: 11 day: 26. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 27. 'jessica'. 29 }.
		{ Date year: 2015 month: 11 day: 28. 'joe'. 41 }.
		{ Date year: 2015 month: 11 day: 29. 'bill'. 18 }.
		{ Date year: 2015 month: 11 day: 30. 'joe'. 39 }.
		{ Date year: 2015 month: 12 day: 1. 'joe'. 39 }.
		{ Date year: 2015 month: 12 day: 2. 'joe'. 34 }.
		{ Date year: 2015 month: 12 day: 3. 'joe'. 32 }.
		{ Date year: 2015 month: 12 day: 4. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 5. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 6. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 7. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 8. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 9. 'jessica'. 27 }.
		{ Date year: 2015 month: 12 day: 10. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 11. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 12. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 13. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 14. 'joe'. 42 }.
		{ Date year: 2015 month: 12 day: 15. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 16. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 17. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 18. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 19. 'bill'. 17 }.
		{ Date year: 2015 month: 12 day: 20. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 21. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 22. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 23. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 24. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 25. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 26. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 27. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 28. 'jessica'. 27 }.
		{ Date year: 2015 month: 12 day: 29. 'joe'. 42 }.
		{ Date year: 2015 month: 12 day: 30. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 31. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 1. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 2. 'joe'. 38 }.
		{ Date year: 2016 month: 1 day: 3. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 4. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 5. 'bill'. 19 }.
		{ Date year: 2016 month: 1 day: 6. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 7. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 8. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 9. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 10. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 11. 'joe'. 34 }.
		{ Date year: 2016 month: 1 day: 12. 'joe'. 36 }.
		{ Date year: 2016 month: 1 day: 13. 'jessica'. 29 }.
		{ Date year: 2016 month: 1 day: 14. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 15. 'joe'. 31 }.
		{ Date year: 2016 month: 1 day: 16. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 17. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 18. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 19. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 20. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 21. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 22. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 23. 'jessica'. 29 }.
		{ Date year: 2016 month: 1 day: 24. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 25. 'joe'. 40 }.
		{ Date year: 2016 month: 1 day: 26. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 27. 'joe'. 36 }.
		{ Date year: 2016 month: 1 day: 28. 'jessica'. 28 }.
		{ Date year: 2016 month: 1 day: 29. 'jessica'. 25 }.
		{ Date year: 2016 month: 1 day: 30. 'bill'. 16 }.
		{ Date year: 2016 month: 1 day: 31. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 1. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 2. 'jessica'. 29 }.
		{ Date year: 2016 month: 2 day: 3. 'jessica'. 25 }.
		{ Date year: 2016 month: 2 day: 4. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 5. 'joe'. 38 }.
		{ Date year: 2016 month: 2 day: 6. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 7. 'joe'. 36 }.
		{ Date year: 2016 month: 2 day: 8. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 9. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 10. 'jessica'. 25 }.
		{ Date year: 2016 month: 2 day: 11. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 12. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 13. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 14. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 15. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 16. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 17. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 18. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 19. 'joe'. 37 }.
		{ Date year: 2016 month: 2 day: 20. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 21. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 22. 'joe'. 33 }.
		{ Date year: 2016 month: 2 day: 23. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 24. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 25. 'jessica'. 29 }.
		{ Date year: 2016 month: 2 day: 26. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 27. 'joe'. 37 }.
		{ Date year: 2016 month: 2 day: 28. 'joe'. 38 }.
		{ Date year: 2016 month: 2 day: 29. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 1. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 2. 'joe'. 39 }.
		{ Date year: 2016 month: 3 day: 3. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 4. 'bill'. 15 }.
		{ Date year: 2016 month: 3 day: 5. 'joe'. 38 }.
		{ Date year: 2016 month: 3 day: 6. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 7. 'joe'. 36 }.
		{ Date year: 2016 month: 3 day: 8. 'jessica'. 25 }.
		{ Date year: 2016 month: 3 day: 9. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 10. 'joe'. 31 }.
		{ Date year: 2016 month: 3 day: 11. 'joe'. 34 }.
		{ Date year: 2016 month: 3 day: 12. 'jessica'. 25 }.
		{ Date year: 2016 month: 3 day: 13. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 14. 'jessica'. 28 }.
		{ Date year: 2016 month: 3 day: 15. 'joe'. 36 }.
		{ Date year: 2016 month: 3 day: 16. 'joe'. 30 }.
		{ Date year: 2016 month: 3 day: 17. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 18. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 19. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 20. 'bill'. 15 }.
		{ Date year: 2016 month: 3 day: 21. 'jessica'. 25 }.
		{ Date year: 2016 month: 3 day: 22. 'joe'. 39 }.
		{ Date year: 2016 month: 3 day: 23. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 24. 'bill'. 16 }.
		{ Date year: 2016 month: 3 day: 25. 'jessica'. 29 }.
		{ Date year: 2016 month: 3 day: 26. 'joe'. 33 }.
		{ Date year: 2016 month: 3 day: 27. 'bill'. 15 }.
		{ Date year: 2016 month: 3 day: 28. 'bill'. 15 }.
		{ Date year: 2016 month: 3 day: 29. 'joe'. 30 }.
		{ Date year: 2016 month: 3 day: 30. 'joe'. 36 }.
		{ Date year: 2016 month: 3 day: 31. 'joe'. 42 }.
		{ Date year: 2016 month: 4 day: 1. 'jessica'. 29 }.
		{ Date year: 2016 month: 4 day: 2. 'jessica'. 25 }.	
	}
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> commitsBasicChart [
	<gtExample>
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
	| lineChart |
	lineChart := self commitsBasicChart.
	
	lineChart
		titleX: 'Date';
		titleY: 'Number of commits per day'.
		
	^ lineChart
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> dataPerUser [
	<gtExample>
	| aData colors |

	colors := { 
		'jessica' -> Color green.
		'bill' -> Color blue.
		'joe' -> Color red } asOrderedDictionary.
	
	aData := GtPlotterDataGroup new values: self commitsAndUsers.
	aData := aData 
		groupedBy: [ :eachData | eachData at: #user ] 
		labelled: [ :user | user ] 
		colored: [ :user | colors at: user ].
	^ aData
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> definedLineColor [
	<gtExample>
	| aData lineChart |
	
	aData := GtPlotterDataGroup new values: self commits.
	aData := aData colored: Color blue.
	
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

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plot [
	<gtExample>
	| aData lineChart |
	
	aData := GtPlotterDataGroup new values: self commits.
	aData := aData colored: Color blue.
	
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
GtPlotterLineChartExamples >> plotPerUser [
	<gtExample>
	| aData aChart |

	aData := self dataPerUser.
	
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
