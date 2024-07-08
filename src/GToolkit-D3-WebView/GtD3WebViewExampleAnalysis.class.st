Class {
	#name : #GtD3WebViewExampleAnalysis,
	#superclass : #Object,
	#instVars : [
		'numberOfClasses'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> gtViewClassesWithMethodsFor: aView [ 
	<gtView>
	
	^ aView forward
		title: 'Classes with methods (d3)';
		priority: 20;
		object: [
			GtD3WebViewPhlowLocalSpecification new 
				viewName: #barchart;
				sourceProvider: (GtD3WebViewSourceProvider 
					forGToolkitVisualiserExamplesFolder);
				dataProvider: (GtD3WebViewCsvDataProvider new 
					objects: [self top20LargeClasses];
					rowLabel: [ :each | each name ];
					rowValue: [ :each | each methods size ]) ];
 		view: #gtViewWebViewFor:
]

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> gtViewClassesWithMethodsListFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Classes with methods (list)';
		priority: 5;
		items: [ self top20LargeClasses ];
		column: 'Position' text: [ :aClass :anIndex | anIndex ] width: 50;
		column: 'Class' text: [ :aClass | aClass name ];
		column: 'Number of methods' text: [ :aClass | aClass methods size  ]
]

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> numberOfClasses [
	^ numberOfClasses ifNil: [ 20 ]
]

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> numberOfClasses: anInteger [
	numberOfClasses := anInteger
]

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> top20LargeClasses [
	^ (Smalltalk allClasses 
		sorted: [ :each | each methods size ] descending)
			first: self numberOfClasses
]
