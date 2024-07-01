Class {
	#name : #GtD3WebViewExampleAnalysis,
	#superclass : #Object,
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> gtViewClassesWithMethodsFor: aView [ 
	<gtView>
	
	^ aView forward
		title: 'Classes with methods';
		object: [
			GtD3WebViewPhlowWrapper new 
				viewId: #barchart;
				dataProvider: (GtD3WebViewCsvDataProvider new 
					objects: self top20LargeClasses;
					rowLabel: [ :each | each name ];
					rowValue: [ :each | each methods size ]) ];
 		view: #gtViewWebViewFor:
]

{ #category : #accessing }
GtD3WebViewExampleAnalysis >> top20LargeClasses [
	^ (Smalltalk allClasses 
		sorted: [ :each | each methods size ] descending)
			first: 20
]
