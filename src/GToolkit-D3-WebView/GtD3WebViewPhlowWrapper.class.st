Class {
	#name : #GtD3WebViewPhlowWrapper,
	#superclass : #Object,
	#instVars : [
		'dataProvider',
		'id',
		'viewName',
		'webViewElement'
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
GtD3WebViewPhlowWrapper >> ensureWrapperIsRegistered [
	self server
		ensureWrapperIsRegisteredFor: self
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> gtBasicViewWebViewFor: aView [ 
	"<gtView>"
	
	^ aView forward
		title: 'Classes with methods';
		object: [
			self ensureWrapperIsRegistered.
			self webViewElementForWrapper ];
 		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> gtViewWebViewFor: aView [ 
	"<gtView>"
	
	^ aView forward
		title: 'Classes with methods';
		object: [
			self ensureWrapperIsRegistered.
			self webViewElementForWrapper ];
 		view: #gtLiveFor:
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> id [
	^ id
]

{ #category : #initialization }
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
GtD3WebViewPhlowWrapper >> server [
	^ GtD3WebViewServer defaultInstance
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewData [
	^ self dataProvider viewData
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewName [
	^ viewName
]

{ #category : #accessing }
GtD3WebViewPhlowWrapper >> viewName: aViewName [
	viewName := aViewName
]

{ #category : #'gt - extensions' }
GtD3WebViewPhlowWrapper >> webViewElementForWrapper [
	^ webViewElement ifNil: [ 
		webViewElement := GtWebViewElement new
			url: (self server 
				viewCodeUrlForViewNamed: self viewName
				withProviderId: self id) asString ]
]
