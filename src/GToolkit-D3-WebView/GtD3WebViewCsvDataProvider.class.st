Class {
	#name : #GtD3WebViewCsvDataProvider,
	#superclass : #Object,
	#instVars : [
		'columnNames',
		'labelFormatter',
		'valueFormatter',
		'objectsComputation',
		'objectsByIndex'
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
GtD3WebViewCsvDataProvider >> computeObjectsWithIds [
	^ objectsComputation value asOrderedCollection
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
GtD3WebViewCsvDataProvider >> objects: aBlockClosure [
	objectsComputation := aBlockClosure
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> objectsByIndex [
	^ objectsByIndex ifNil: [
		objectsByIndex := self computeObjectsWithIds]
]

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> objectsWithIndexDo: elementBlock separatedBy: separatorBlock [
	| beforeFirst |
	
	beforeFirst := true.
	self objectsByIndex withIndexDo:
		[:each :index |
		beforeFirst
			ifTrue: [beforeFirst := false]
			ifFalse: [separatorBlock value].
		elementBlock value: each value: index]
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

{ #category : #accessing }
GtD3WebViewCsvDataProvider >> viewData [
	^ String streamContents: [ :aStream |
		aStream << 'Label,Value,Id'.
		aStream crlf.
		self 
			objectsWithIndexDo: [ :each  :index| 
				aStream << (self labelFormatter value: each) asString.
				aStream << ','.
				aStream << (self valueFormatter value: each) asString.
				aStream << ','.
				aStream << index asString ] 
			separatedBy: [ aStream crlf ] ]
]
