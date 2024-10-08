Class {
	#name : #GtD3WebViewServer,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'zincServer',
		'phlowRegistry'
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

{ #category : #'instance creation' }
GtD3WebViewServer class >> createDefaultWithNewZnServer [
	| zincServer |
	self assert: [ defaultInstance isNil ].
	zincServer := ZnServer 
		on: self configurationClass defaultPortNumber.
	^ self createDefaultWithZnServer: zincServer.
]

{ #category : #'instance creation' }
GtD3WebViewServer class >> createDefaultWithZnServer: aZnServer [
	self assert: [ defaultInstance isNil ].
	^ defaultInstance := self createWithZnServer: aZnServer
]

{ #category : #'instance creation' }
GtD3WebViewServer class >> createWithZnServer: aZnServer [
	"Create a server instance that does not use a default Zinc server and neither is set as default.
	Useful for testing purposes."

	^ self basicNew
		basicInitializeZincServerWith: aZnServer;
		initialize;
		yourself
]

{ #category : #accessing }
GtD3WebViewServer class >> defaultInstance [
	^ defaultInstance ifNil: [
		defaultInstance := self new ]
]

{ #category : #testing }
GtD3WebViewServer class >> isDefaultRunning [
	^ defaultInstance notNil and: [ 
		defaultInstance isRunning ]
]

{ #category : #actions }
GtD3WebViewServer class >> resetDefault [
	self stopDefault.
	defaultInstance := nil
]

{ #category : #actions }
GtD3WebViewServer class >> startDefault [
	self defaultInstance
		configuration: self configurationClass forCurrentEnvironment;
		start
]

{ #category : #actions }
GtD3WebViewServer class >> startLogging [
	NonInteractiveTranscriptLogger startFor: LeZincSignal.
]

{ #category : #actions }
GtD3WebViewServer class >> stopDefault [
	defaultInstance ifNil: [ ^ self ].
	self defaultInstance stop
]

{ #category : #initialization }
GtD3WebViewServer >> basicInitializeZincServerWith: aZnServer [
	zincServer := aZnServer
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
	^ ZnDispatcherDelegate new
		map: '/view' to: [ :request :response | 
			response entity: (ZnStringEntity html: (self viewCodeForRequest: request)) ];
		map: '/data' to: [ :request :response | 
			response entity: (ZnStringEntity text: (self viewDataForRequest: request)) ];
		map: '/send' to: [ :request :response | 
			response entity: (ZnStringEntity text: (self navigateForRequest: request)) ]
]

{ #category : #initialization }
GtD3WebViewServer >> defaultZincServer [
	^ ZnServer default ifNil: [ 
		ZnServer defaultOn: self class configurationClass defaultPortNumber ]
]

{ #category : #'local actions' }
GtD3WebViewServer >> ensureWrapperIsRegisteredFor: aPhlowWrapper [
	phlowRegistry ensureWrapperIsRegisteredFor: aPhlowWrapper
]

{ #category : #'gt-extensions' }
GtD3WebViewServer >> gtOverviewFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Overview';
		object: [ self zincServer ];
		view: #gtOverviewFor:
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
	
	phlowRegistry := GtD3WebViewPhlowRegistry new.
	
	zincServer delegate: self defaultDelegate.
	zincServer debugMode: true.
]

{ #category : #testing }
GtD3WebViewServer >> isRunning [
	^ self zincServer isRunning
]

{ #category : #accessing }
GtD3WebViewServer >> localhostUrl [
	^ ('http://localhost:{1}' format: {self port}) asZnUrl
]

{ #category : #requests }
GtD3WebViewServer >> navigateForRequest: aRequest [
	| phlowId objectId |

	phlowId := aRequest url queryAt: 'phlowId'.
	objectId := aRequest url queryAt: 'objectId'.
	
	phlowRegistry 
		phlowWrapperWithId: phlowId
		ifPresent: [ :aPhlowWrapper | 
			aPhlowWrapper navigateToObjectWithId: objectId ]
		ifAbsent: [  ].
	
	^ ''
]

{ #category : #accessing }
GtD3WebViewServer >> port [
	^ self zincServer port
]

{ #category : #accessing }
GtD3WebViewServer >> port: aNumber [
	^ self zincServer port: aNumber
]

{ #category : #accessing }
GtD3WebViewServer >> selectionUrlForProviderId: aProviderId [
	^ self localhostUrl 	
		addPathSegment: 'send';
		queryAt: 'phlowId' put: aProviderId;
		yourself
]

{ #category : #actions }
GtD3WebViewServer >> start [
	self zincServer start
]

{ #category : #actions }
GtD3WebViewServer >> stop [
	self zincServer stop
]

{ #category : #requests }
GtD3WebViewServer >> viewCodeForRequest: aRequest [

	^ phlowRegistry 
		phlowWrapperWithId: (aRequest url queryAt: 'phlowId')
		ifPresent: [ :aPhlowWrapper | 
			aPhlowWrapper viewSource ]
		ifAbsent: [ '' ]
]

{ #category : #accessing }
GtD3WebViewServer >> viewCodeUrlForViewNamed: aViewName withProviderId: anId [
	^ self localhostUrl 	
		addPathSegment: 'view';
		queryAt: 'viewName' put: aViewName;
		queryAt: 'phlowId' put: anId;
		yourself
]

{ #category : #requests }
GtD3WebViewServer >> viewDataForRequest: aRequest [
	^ phlowRegistry 
		phlowWrapperWithId: (aRequest url queryAt: 'phlowId')
		ifPresent: [ :aPhlowWrapper | 
			aPhlowWrapper viewData ]
		ifAbsent: [ 'Label,Value' ]
]

{ #category : #accessing }
GtD3WebViewServer >> viewDataUrlForProviderId: aProviderId [
	^ self localhostUrl 	
		addPathSegment: 'data';
		queryAt: 'phlowId' put: aProviderId;
		yourself
]

{ #category : #accessing }
GtD3WebViewServer >> zincServer [
	^ zincServer
]
