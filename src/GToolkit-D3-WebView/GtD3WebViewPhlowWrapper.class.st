Class {
	#name : #GtD3WebViewPhlowWrapper,
	#superclass : #Object,
	#instVars : [
		'viewId',
		'dataProvider'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> dataProvider [
	^ dataProvider
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> dataProvider: anObject [
	dataProvider := anObject
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> gtViewWebViewFor: aView [ 
	<gtView>
	
	^ aView forward
		title: 'Classes with methods';
		object: [
			GtWebViewElement new
				url:GtD3WebViewServer defaultInstance localhostUrl asString, 'view' ];
 		view: #gtLiveFor:
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewId [
	^ viewId
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewId: anObject [
	viewId := anObject
]
