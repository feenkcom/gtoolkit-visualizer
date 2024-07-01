Class {
	#name : #GtD3WebViewServer,
	#superclass : #Object,
	#traits : 'TLeBasicServer',
	#classTraits : 'TLeBasicServer classTrait',
	#instVars : [
		'configuration'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewServer class >> configurationClass [
	^ GtD3WebViewServerConfiguration
]

{ #category : #accessing }
GtD3WebViewServer >> configuration [
	^ configuration
]

{ #category : #accessing }
GtD3WebViewServer >> configuration: aSyncServerConfiguration [
	configuration := aSyncServerConfiguration.
	self updateAuthenticator.
]

{ #category : #initialization }
GtD3WebViewServer >> defaultDelegate [
	^ (ZnDispatcherDelegate new
		map: '/view' to: [ :request :response | 
			response entity: (ZnStringEntity html: (self viewCodeForRequest: request)) ];
		map: '/data' to: [ :request :response | 
			response entity: (ZnStringEntity text: (self viewDataForRequest: request)) ])
]

{ #category : #'gt-extensions' }
GtD3WebViewServer >> gtViewRestEndpointsFor: aView [
	<gtView>
	^ self zincServer
		ifNil: [ aView empty ]
		ifNotNil: [ self zincServer delegate gtMapFor: aView ]
]

{ #category : #initialization }
GtD3WebViewServer >> initialize [
	super initialize.
	zincServer ifNil: [ 
		"The Zinc server might be set before #initialize if the server is created 
		using #basicInitialize for testing purposes."
		zincServer := self defaultZincServer ].
	 
	zincServer delegate: self defaultDelegate.
	zincServer debugMode: true.
]

{ #category : #private }
GtD3WebViewServer >> updateAuthenticator [
	
]

{ #category : #requests }
GtD3WebViewServer >> viewCodeForRequest: aRequest [
	^ './d3-barchart.html' asFileReference contents
]

{ #category : #requests }
GtD3WebViewServer >> viewDataForRequest: aRequest [
	^ String streamContents: [ :aStream |
	aStream << 'Label,Value'.
	aStream crlf.
	((Smalltalk allClasses 
		sorted: [ :each | each methods size ] descending)
			first: 20) 
				do: [ :each | 
					aStream << each name.
					aStream << ','.
					aStream << each methods size asString ] 
				separatedBy: [ aStream crlf ] ]
]
