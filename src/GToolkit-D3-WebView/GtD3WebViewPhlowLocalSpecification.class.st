Class {
	#name : #GtD3WebViewPhlowLocalSpecification,
	#superclass : #Object,
	#instVars : [
		'id',
		'dataProvider',
		'viewName',
		'sourceProvider'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> createPhlowWrapper [
	^ GtD3WebViewPhlowWrapper new 
		viewSpecification: self
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> dataProvider [
	^ dataProvider
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> dataProvider: aDataProvider [
	dataProvider := aDataProvider
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowLocalSpecification >> gtViewWebViewFor: aView [ 
	<gtView>
	
	^ aView forward
		title: 'Web View';
		object: [
			self createPhlowWrapper ];
		view: #gtBasicViewWebViewFor:
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> id [
	^ id
]

{ #category : #'initialization ' }
GtD3WebViewPhlowLocalSpecification >> initialize [
	super initialize.
	
	id := (UUID new) base64Encoded
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> sourceProvider [
	^ sourceProvider
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> sourceProvider: aSourceProvider [
	sourceProvider := aSourceProvider
]

{ #category : #'initialization ' }
GtD3WebViewPhlowLocalSpecification >> viewName [
	^ viewName
]

{ #category : #accessing }
GtD3WebViewPhlowLocalSpecification >> viewName: aViewName [
	viewName := aViewName
]
