Class {
	#name : #GtD3WebViewServerConfiguration,
	#superclass : #Object,
	#instVars : [
		'debugMode'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewServerConfiguration class >> defaultPortNumber [
	^ 0
]

{ #category : #'instance creation' }
GtD3WebViewServerConfiguration class >> forCurrentEnvironment [
	| config |
	config := self new.
	config debugMode: false.
	^ config
]

{ #category : #accessing }
GtD3WebViewServerConfiguration >> debugMode [
	^ debugMode ifNil: [ false ]
]

{ #category : #accessing }
GtD3WebViewServerConfiguration >> debugMode: aBoolean [
	^ debugMode := aBoolean
]
