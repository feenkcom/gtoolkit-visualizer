"
I exemplify {{gtClass:GtPlotterLineChart}}.
"
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
GtPlotterLineChartExamples >> commitsAndUserData [
	<gtExample>
	^ GtPlotterDataGroup new values: self commitsAndUserValues
]

{ #category : #'example - data' }
GtPlotterLineChartExamples >> commitsAndUserDataGroupedByMonth [
	<gtExample>
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
	| aData colors |

	colors := { 
		'jessica' -> Color green.
		'bill' -> Color blue.
		'joe' -> Color red } asOrderedDictionary.
	
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
	| aData |

	aData := self commitsAndUserDataGroupedByUser.
	aData := aData 
		groupedBy: [ :eachData | (eachData at: #date) asMonth ].
	^ aData
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsAndUserRawValues [
	<gtExample>

	^ {
		{ Date year: 2015 month: 10 day: 5. 'bill'. 16 }.
		{ Date year: 2015 month: 10 day: 5. 'jessica'. 28 }.
		{ Date year: 2015 month: 10 day: 6. 'joe'. 36 }.
		{ Date year: 2015 month: 10 day: 7. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 7. 'jessica'. 28 }.
		{ Date year: 2015 month: 10 day: 8. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 9. 'joe'. 34 }.
		{ Date year: 2015 month: 10 day: 9. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 9. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 10. 'joe'. 33 }.
		{ Date year: 2015 month: 10 day: 10. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 11. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 12. 'bill'. 15 }.
		{ Date year: 2015 month: 10 day: 12. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 14. 'joe'. 42 }.
		{ Date year: 2015 month: 10 day: 14. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 14. 'jessica'. 25 }.
		{ Date year: 2015 month: 10 day: 15. 'joe'. 31 }.
		{ Date year: 2015 month: 10 day: 15. 'bill'. 16 }.
		{ Date year: 2015 month: 10 day: 15. 'jessica'. 28 }.
		{ Date year: 2015 month: 10 day: 16. 'joe'. 42 }.
		{ Date year: 2015 month: 10 day: 16. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 16. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 17. 'joe'. 32 }.
		{ Date year: 2015 month: 10 day: 18. 'joe'. 37 }.
		{ Date year: 2015 month: 10 day: 18. 'bill'. 16 }.
		{ Date year: 2015 month: 10 day: 18. 'jessica'. 27 }.
		{ Date year: 2015 month: 10 day: 19. 'joe'. 32 }.
		{ Date year: 2015 month: 10 day: 19. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 19. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 20. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 20. 'jessica'. 28 }.
		{ Date year: 2015 month: 10 day: 21. 'joe'. 30 }.
		{ Date year: 2015 month: 10 day: 21. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 21. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 22. 'joe'. 31 }.
		{ Date year: 2015 month: 10 day: 22. 'jessica'. 29 }.
		{ Date year: 2015 month: 10 day: 23. 'joe'. 39 }.
		{ Date year: 2015 month: 10 day: 23. 'bill'. 17 }.
		{ Date year: 2015 month: 10 day: 23. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 24. 'joe'. 35 }.
		{ Date year: 2015 month: 10 day: 24. 'jessica'. 26 }.
		{ Date year: 2015 month: 10 day: 25. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 26. 'joe'. 31 }.
		{ Date year: 2015 month: 10 day: 26. 'bill'. 15 }.
		{ Date year: 2015 month: 10 day: 26. 'jessica'. 27 }.
		{ Date year: 2015 month: 10 day: 27. 'joe'. 31 }.
		{ Date year: 2015 month: 10 day: 27. 'jessica'. 27 }.
		{ Date year: 2015 month: 10 day: 28. 'jessica'. 27 }.
		{ Date year: 2015 month: 10 day: 29. 'jessica'. 27 }.
		{ Date year: 2015 month: 10 day: 30. 'joe'. 37 }.
		{ Date year: 2015 month: 10 day: 30. 'bill'. 18 }.
		{ Date year: 2015 month: 10 day: 31. 'joe'. 32 }.
		{ Date year: 2015 month: 10 day: 31. 'bill'. 19 }.
		{ Date year: 2015 month: 10 day: 31. 'jessica'. 25 }.
		{ Date year: 2015 month: 11 day: 1. 'joe'. 32 }.
		{ Date year: 2015 month: 11 day: 1. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 1. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 2. 'joe'. 36 }.
		{ Date year: 2015 month: 11 day: 2. 'bill'. 18 }.
		{ Date year: 2015 month: 11 day: 2. 'jessica'. 29 }.
		{ Date year: 2015 month: 11 day: 3. 'joe'. 36 }.
		{ Date year: 2015 month: 11 day: 3. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 3. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 4. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 4. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 5. 'joe'. 34 }.
		{ Date year: 2015 month: 11 day: 5. 'bill'. 18 }.
		{ Date year: 2015 month: 11 day: 5. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 6. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 6. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 7. 'joe'. 30 }.
		{ Date year: 2015 month: 11 day: 7. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 8. 'joe'. 31 }.
		{ Date year: 2015 month: 11 day: 8. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 9. 'joe'. 39 }.
		{ Date year: 2015 month: 11 day: 9. 'jessica'. 29 }.
		{ Date year: 2015 month: 11 day: 10. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 10. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 11. 'joe'. 30 }.
		{ Date year: 2015 month: 11 day: 11. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 11. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 12. 'joe'. 35 }.
		{ Date year: 2015 month: 11 day: 12. 'jessica'. 29 }.
		{ Date year: 2015 month: 11 day: 13. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 13. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 14. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 15. 'joe'. 30 }.
		{ Date year: 2015 month: 11 day: 15. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 16. 'joe'. 38 }.
		{ Date year: 2015 month: 11 day: 16. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 17. 'joe'. 36 }.
		{ Date year: 2015 month: 11 day: 17. 'bill'. 15 }.
		{ Date year: 2015 month: 11 day: 17. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 18. 'joe'. 31 }.
		{ Date year: 2015 month: 11 day: 19. 'joe'. 41 }.
		{ Date year: 2015 month: 11 day: 20. 'joe'. 38 }.
		{ Date year: 2015 month: 11 day: 20. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 21. 'joe'. 37 }.
		{ Date year: 2015 month: 11 day: 21. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 21. 'jessica'. 26 }.
		{ Date year: 2015 month: 11 day: 22. 'joe'. 39 }.
		{ Date year: 2015 month: 11 day: 22. 'bill'. 16 }.
		{ Date year: 2015 month: 11 day: 22. 'jessica'. 25 }.
		{ Date year: 2015 month: 11 day: 23. 'joe'. 33 }.
		{ Date year: 2015 month: 11 day: 23. 'bill'. 17 }.
		{ Date year: 2015 month: 11 day: 23. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 24. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 24. 'jessica'. 28 }.
		{ Date year: 2015 month: 11 day: 25. 'joe'. 39 }.
		{ Date year: 2015 month: 11 day: 25. 'bill'. 17 }.
		{ Date year: 2015 month: 11 day: 25. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 26. 'jessica'. 27 }.
		{ Date year: 2015 month: 11 day: 27. 'bill'. 18 }.
		{ Date year: 2015 month: 11 day: 28. 'joe'. 35 }.
		{ Date year: 2015 month: 11 day: 28. 'bill'. 17 }.
		{ Date year: 2015 month: 11 day: 29. 'joe'. 32 }.
		{ Date year: 2015 month: 11 day: 29. 'jessica'. 25 }.
		{ Date year: 2015 month: 11 day: 30. 'joe'. 36 }.
		{ Date year: 2015 month: 11 day: 30. 'bill'. 19 }.
		{ Date year: 2015 month: 11 day: 30. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 1. 'joe'. 41 }.
		{ Date year: 2015 month: 12 day: 1. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 1. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 2. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 2. 'jessica'. 28 }.
		{ Date year: 2015 month: 12 day: 3. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 4. 'joe'. 34 }.
		{ Date year: 2015 month: 12 day: 4. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 4. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 5. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 5. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 5. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 6. 'joe'. 33 }.
		{ Date year: 2015 month: 12 day: 6. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 7. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 8. 'joe'. 32 }.
		{ Date year: 2015 month: 12 day: 8. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 9. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 9. 'bill'. 17 }.
		{ Date year: 2015 month: 12 day: 9. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 10. 'joe'. 31 }.
		{ Date year: 2015 month: 12 day: 10. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 10. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 11. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 11. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 12. 'joe'. 42 }.
		{ Date year: 2015 month: 12 day: 12. 'jessica'. 28 }.
		{ Date year: 2015 month: 12 day: 13. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 14. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 14. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 15. 'joe'. 39 }.
		{ Date year: 2015 month: 12 day: 16. 'joe'. 40 }.
		{ Date year: 2015 month: 12 day: 16. 'jessica'. 28 }.
		{ Date year: 2015 month: 12 day: 17. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 17. 'jessica'. 28 }.
		{ Date year: 2015 month: 12 day: 18. 'joe'. 37 }.
		{ Date year: 2015 month: 12 day: 18. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 18. 'jessica'. 26 }.
		{ Date year: 2015 month: 12 day: 19. 'joe'. 37 }.
		{ Date year: 2015 month: 12 day: 20. 'joe'. 34 }.
		{ Date year: 2015 month: 12 day: 20. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 20. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 21. 'joe'. 32 }.
		{ Date year: 2015 month: 12 day: 21. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 21. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 22. 'joe'. 34 }.
		{ Date year: 2015 month: 12 day: 22. 'bill'. 15 }.
		{ Date year: 2015 month: 12 day: 22. 'jessica'. 27 }.
		{ Date year: 2015 month: 12 day: 23. 'joe'. 38 }.
		{ Date year: 2015 month: 12 day: 23. 'bill'. 17 }.
		{ Date year: 2015 month: 12 day: 23. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 24. 'joe'. 33 }.
		{ Date year: 2015 month: 12 day: 24. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 24. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 25. 'joe'. 41 }.
		{ Date year: 2015 month: 12 day: 25. 'jessica'. 29 }.
		{ Date year: 2015 month: 12 day: 26. 'jessica'. 28 }.
		{ Date year: 2015 month: 12 day: 27. 'joe'. 36 }.
		{ Date year: 2015 month: 12 day: 27. 'bill'. 19 }.
		{ Date year: 2015 month: 12 day: 27. 'jessica'. 25 }.
		{ Date year: 2015 month: 12 day: 28. 'joe'. 33 }.
		{ Date year: 2015 month: 12 day: 29. 'joe'. 36 }.
		{ Date year: 2015 month: 12 day: 29. 'bill'. 18 }.
		{ Date year: 2015 month: 12 day: 30. 'joe'. 41 }.
		{ Date year: 2015 month: 12 day: 30. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 31. 'joe'. 40 }.
		{ Date year: 2015 month: 12 day: 31. 'bill'. 16 }.
		{ Date year: 2015 month: 12 day: 31. 'jessica'. 25 }.
		{ Date year: 2016 month: 1 day: 1. 'bill'. 16 }.
		{ Date year: 2016 month: 1 day: 1. 'jessica'. 28 }.
		{ Date year: 2016 month: 1 day: 2. 'joe'. 34 }.
		{ Date year: 2016 month: 1 day: 2. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 3. 'joe'. 35 }.
		{ Date year: 2016 month: 1 day: 3. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 3. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 4. 'joe'. 36 }.
		{ Date year: 2016 month: 1 day: 4. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 4. 'jessica'. 28 }.
		{ Date year: 2016 month: 1 day: 5. 'joe'. 39 }.
		{ Date year: 2016 month: 1 day: 6. 'bill'. 19 }.
		{ Date year: 2016 month: 1 day: 6. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 7. 'joe'. 32 }.
		{ Date year: 2016 month: 1 day: 7. 'jessica'. 25 }.
		{ Date year: 2016 month: 1 day: 8. 'joe'. 30 }.
		{ Date year: 2016 month: 1 day: 8. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 9. 'joe'. 38 }.
		{ Date year: 2016 month: 1 day: 9. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 9. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 10. 'joe'. 41 }.
		{ Date year: 2016 month: 1 day: 10. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 11. 'joe'. 30 }.
		{ Date year: 2016 month: 1 day: 11. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 11. 'jessica'. 29 }.
		{ Date year: 2016 month: 1 day: 12. 'joe'. 38 }.
		{ Date year: 2016 month: 1 day: 12. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 12. 'jessica'. 29 }.
		{ Date year: 2016 month: 1 day: 13. 'joe'. 36 }.
		{ Date year: 2016 month: 1 day: 13. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 14. 'joe'. 42 }.
		{ Date year: 2016 month: 1 day: 14. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 14. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 15. 'joe'. 36 }.
		{ Date year: 2016 month: 1 day: 16. 'joe'. 30 }.
		{ Date year: 2016 month: 1 day: 16. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 16. 'jessica'. 25 }.
		{ Date year: 2016 month: 1 day: 17. 'joe'. 37 }.
		{ Date year: 2016 month: 1 day: 17. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 18. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 18. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 19. 'joe'. 34 }.
		{ Date year: 2016 month: 1 day: 19. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 19. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 21. 'jessica'. 25 }.
		{ Date year: 2016 month: 1 day: 23. 'joe'. 30 }.
		{ Date year: 2016 month: 1 day: 23. 'bill'. 19 }.
		{ Date year: 2016 month: 1 day: 23. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 24. 'joe'. 42 }.
		{ Date year: 2016 month: 1 day: 24. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 25. 'joe'. 38 }.
		{ Date year: 2016 month: 1 day: 25. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 26. 'joe'. 39 }.
		{ Date year: 2016 month: 1 day: 26. 'bill'. 17 }.
		{ Date year: 2016 month: 1 day: 26. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 27. 'joe'. 40 }.
		{ Date year: 2016 month: 1 day: 27. 'jessica'. 27 }.
		{ Date year: 2016 month: 1 day: 28. 'joe'. 35 }.
		{ Date year: 2016 month: 1 day: 28. 'jessica'. 28 }.
		{ Date year: 2016 month: 1 day: 29. 'joe'. 38 }.
		{ Date year: 2016 month: 1 day: 29. 'jessica'. 26 }.
		{ Date year: 2016 month: 1 day: 30. 'joe'. 30 }.
		{ Date year: 2016 month: 1 day: 30. 'bill'. 15 }.
		{ Date year: 2016 month: 1 day: 31. 'joe'. 40 }.
		{ Date year: 2016 month: 1 day: 31. 'bill'. 18 }.
		{ Date year: 2016 month: 1 day: 31. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 1. 'jessica'. 26 }.
		{ Date year: 2016 month: 2 day: 2. 'joe'. 36 }.
		{ Date year: 2016 month: 2 day: 2. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 3. 'joe'. 31 }.
		{ Date year: 2016 month: 2 day: 3. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 3. 'jessica'. 25 }.
		{ Date year: 2016 month: 2 day: 4. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 5. 'joe'. 42 }.
		{ Date year: 2016 month: 2 day: 5. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 5. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 6. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 6. 'jessica'. 29 }.
		{ Date year: 2016 month: 2 day: 7. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 7. 'jessica'. 29 }.
		{ Date year: 2016 month: 2 day: 8. 'joe'. 32 }.
		{ Date year: 2016 month: 2 day: 8. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 8. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 9. 'joe'. 35 }.
		{ Date year: 2016 month: 2 day: 9. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 10. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 10. 'jessica'. 26 }.
		{ Date year: 2016 month: 2 day: 11. 'joe'. 40 }.
		{ Date year: 2016 month: 2 day: 11. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 12. 'joe'. 42 }.
		{ Date year: 2016 month: 2 day: 12. 'jessica'. 25 }.
		{ Date year: 2016 month: 2 day: 13. 'joe'. 38 }.
		{ Date year: 2016 month: 2 day: 13. 'jessica'. 28 }.
		{ Date year: 2016 month: 2 day: 14. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 15. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 15. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 16. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 16. 'jessica'. 28 }.
		{ Date year: 2016 month: 2 day: 17. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 17. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 18. 'joe'. 37 }.
		{ Date year: 2016 month: 2 day: 18. 'jessica'. 25 }.
		{ Date year: 2016 month: 2 day: 19. 'joe'. 38 }.
		{ Date year: 2016 month: 2 day: 19. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 20. 'joe'. 37 }.
		{ Date year: 2016 month: 2 day: 20. 'jessica'. 27 }.
		{ Date year: 2016 month: 2 day: 21. 'bill'. 17 }.
		{ Date year: 2016 month: 2 day: 22. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 22. 'jessica'. 26 }.
		{ Date year: 2016 month: 2 day: 23. 'joe'. 34 }.
		{ Date year: 2016 month: 2 day: 23. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 23. 'jessica'. 29 }.
		{ Date year: 2016 month: 2 day: 24. 'bill'. 18 }.
		{ Date year: 2016 month: 2 day: 24. 'jessica'. 26 }.
		{ Date year: 2016 month: 2 day: 25. 'joe'. 40 }.
		{ Date year: 2016 month: 2 day: 25. 'bill'. 16 }.
		{ Date year: 2016 month: 2 day: 25. 'jessica'. 28 }.
		{ Date year: 2016 month: 2 day: 26. 'jessica'. 28 }.
		{ Date year: 2016 month: 2 day: 27. 'bill'. 19 }.
		{ Date year: 2016 month: 2 day: 28. 'joe'. 40 }.
		{ Date year: 2016 month: 2 day: 28. 'bill'. 15 }.
		{ Date year: 2016 month: 2 day: 28. 'jessica'. 28 }.
		{ Date year: 2016 month: 3 day: 1. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 2. 'joe'. 40 }.
		{ Date year: 2016 month: 3 day: 3. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 4. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 4. 'jessica'. 25 }.
		{ Date year: 2016 month: 3 day: 5. 'bill'. 16 }.
		{ Date year: 2016 month: 3 day: 6. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 7. 'joe'. 39 }.
		{ Date year: 2016 month: 3 day: 7. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 7. 'jessica'. 29 }.
		{ Date year: 2016 month: 3 day: 8. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 8. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 9. 'joe'. 30 }.
		{ Date year: 2016 month: 3 day: 9. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 9. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 10. 'joe'. 38 }.
		{ Date year: 2016 month: 3 day: 10. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 10. 'jessica'. 28 }.
		{ Date year: 2016 month: 3 day: 11. 'joe'. 30 }.
		{ Date year: 2016 month: 3 day: 11. 'jessica'. 29 }.
		{ Date year: 2016 month: 3 day: 12. 'joe'. 30 }.
		{ Date year: 2016 month: 3 day: 12. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 13. 'jessica'. 28 }.
		{ Date year: 2016 month: 3 day: 14. 'joe'. 36 }.
		{ Date year: 2016 month: 3 day: 15. 'joe'. 37 }.
		{ Date year: 2016 month: 3 day: 15. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 15. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 16. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 16. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 17. 'joe'. 41 }.
		{ Date year: 2016 month: 3 day: 17. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 18. 'joe'. 38 }.
		{ Date year: 2016 month: 3 day: 18. 'bill'. 16 }.
		{ Date year: 2016 month: 3 day: 20. 'joe'. 39 }.
		{ Date year: 2016 month: 3 day: 20. 'bill'. 17 }.
		{ Date year: 2016 month: 3 day: 20. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 21. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 22. 'joe'. 39 }.
		{ Date year: 2016 month: 3 day: 22. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 23. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 23. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 24. 'bill'. 15 }.
		{ Date year: 2016 month: 3 day: 24. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 25. 'joe'. 32 }.
		{ Date year: 2016 month: 3 day: 25. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 25. 'jessica'. 27 }.
		{ Date year: 2016 month: 3 day: 26. 'joe'. 41 }.
		{ Date year: 2016 month: 3 day: 26. 'jessica'. 29 }.
		{ Date year: 2016 month: 3 day: 27. 'joe'. 37 }.
		{ Date year: 2016 month: 3 day: 27. 'bill'. 19 }.
		{ Date year: 2016 month: 3 day: 28. 'joe'. 33 }.
		{ Date year: 2016 month: 3 day: 28. 'jessica'. 29 }.
		{ Date year: 2016 month: 3 day: 29. 'joe'. 36 }.
		{ Date year: 2016 month: 3 day: 29. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 29. 'jessica'. 28 }.
		{ Date year: 2016 month: 3 day: 30. 'joe'. 35 }.
		{ Date year: 2016 month: 3 day: 30. 'bill'. 18 }.
		{ Date year: 2016 month: 3 day: 30. 'jessica'. 26 }.
		{ Date year: 2016 month: 3 day: 31. 'joe'. 33 }.
		{ Date year: 2016 month: 4 day: 1. 'bill'. 17 }.
		{ Date year: 2016 month: 4 day: 1. 'jessica'. 28 }.
		{ Date year: 2016 month: 4 day: 2. 'bill'. 19 }.
	}
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsAndUserValues [
	<gtExample>
	^ self commitsAndUserRawValues collect: [ :e | 
		OrderedDictionary new
			at: #date put: e first;
			at: #user put: e second;
			at: #commits put: e third;
			yourself ]
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
GtPlotterLineChartExamples >> commitsPerDayOfAllUsersData [
	<gtExample>
	^ GtPlotterDataGroup new values: self commitsPerDayOfAllUsersValues
]

{ #category : #'example - value' }
GtPlotterLineChartExamples >> commitsPerDayOfAllUsersValues [
	<gtExample>
	| theValues aGroup perDay |

	theValues := self commitsAndUserValues.
	aGroup := theValues groupedBy: [ :eachData | (eachData at: #date) ].
	perDay := aGroup 
		collect: [ :eachArray | 
			OrderedDictionary new
				at: #date put: (eachArray first at: #date);
				at: #commits put: (eachArray sum: [ :e | e at: #commits]);
				at: #users put: (eachArray collect: [ :e | e at: #user ]);
				yourself. ]
		as: Array.
	perDay sort: [ :a :b | (a at: #date) < (b at: #date) ].
	^ perDay
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> definedLineColor [
	<gtExample>
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

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plot [
	<gtExample>
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
	| lineChart |
	
	lineChart := self plot.
	lineChart
		projectionXValues: [ :aData | aData values select: [ :e | e value > 20 ] ].

	^ lineChart
]

{ #category : #'example - chart' }
GtPlotterLineChartExamples >> plotWithProjections [
	<gtExample>
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
