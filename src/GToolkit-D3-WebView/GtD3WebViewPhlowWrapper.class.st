Class {
	#name : #GtD3WebViewPhlowWrapper,
	#superclass : #Object,
	#instVars : [
		'id',
		'webViewElement',
		'viewSpecification'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> dataProvider [
	^ viewSpecification dataProvider
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> ensureWrapperIsRegistered [
	self server
		ensureWrapperIsRegisteredFor: self
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> gtBasicViewWebViewFor: aView [ 
	"Defines the logic for rendering the view"
	
	^ aView forward
		title: 'Web View';
		object: [
			self ensureWrapperIsRegistered.
			self webViewElementForWrapper ];
 		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> gtViewWebViewFor: aView [ 
	<gtView>
	
	^ aView forward
		title: 'Web View';
		object: [
			"Whenever we show the view we createa new wrapper and web view"
			self class new 
				viewSpecification:  self viewSpecification ];
 		view: #gtBasicViewWebViewFor
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> id [
	^ id
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> initialize [
	super initialize.
	
	id := (UUID new) base64Encoded
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> navigateToObjectWithId: anId [
	webViewElement ifNil: [ ^ self ].
	
	webViewElement phlow 
		spawnObject: (self dataProvider 
			objectsByIndex at: anId asNumber)
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> selectionUrl [
	^ self server selectionUrlForProviderId: self id
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> server [
	^ GtD3WebViewServer defaultInstance
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> sourceProvider [
	^ viewSpecification sourceProvider
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewData [
	^ self dataProvider viewData
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewDataUrl [
	^ self server viewDataUrlForProviderId: self id
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewName [
	^ viewSpecification viewName
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewSource [
	^ self sourceProvider
		htmlForViewWithName: self viewName
		dataUrl: self viewDataUrl
		selectionUrl: self selectionUrl
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> viewSourceUrl [
	^ self server viewCodeUrlForViewNamed: self viewName withProviderId: self id
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewSpecification [
	^ viewSpecification
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewSpecification: aViewSpecification [
	viewSpecification := aViewSpecification
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> webViewElementForWrapper [
	^ webViewElement
		ifNil: [ 
			webViewElement := GtWebViewElement new 
				url: self viewSourceUrl asString ]
]
