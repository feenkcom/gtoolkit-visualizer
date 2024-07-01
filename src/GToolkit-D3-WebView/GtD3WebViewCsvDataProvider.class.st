Class {
	#name : #GtD3WebViewCsvDataProvider,
	#superclass : #Object,
	#instVars : [
		'columnNames',
		'objects',
		'labelFormatter',
		'valueFormatter'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> columnNames [
	^ columnNames
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> columnNames: anObject [
	columnNames := anObject
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> labelFormatter [
	^ labelFormatter
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> labelFormatter: anObject [
	labelFormatter := anObject
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> objects [
	^ objects
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> objects: anObject [
	objects := anObject
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> rowLabel: aBlock [
	self labelFormatter:  aBlock
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> rowValue: aBlock [
	self valueFormatter:  aBlock
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> valueFormatter [
	^ valueFormatter
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> valueFormatter: anObject [
	valueFormatter := anObject
]
