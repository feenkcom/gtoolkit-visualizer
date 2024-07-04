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
		title: 'Classes with methods';
		object: [
			GtD3WebViewPhlowWrapper new 
				viewName: #barchart;
				dataProvider: (GtD3WebViewCsvDataProvider new 
					objects: [self top20LargeClasses];
					rowLabel: [ :each | each name ];
					rowValue: [ :each | each methods size ]) ];
 		view: #gtBasicViewWebViewFor:
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
