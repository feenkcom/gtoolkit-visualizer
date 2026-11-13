"
A contiguous matching run between adjacent versions. Source and target starts are zero-based line boundaries; length is the number of surviving lines. Origin index identifies the revision that introduced the run.
"
Class {
	#name : #GtHistoryFlowConnection,
	#superclass : #Object,
	#instVars : [
		'sourceVersion',
		'targetVersion',
		'sourceStart',
		'targetStart',
		'length',
		'originIndex'
	],
	#category : #'GToolkit-HistoryFlow'
}

{ #category : #accessing }
GtHistoryFlowConnection >> extend [
	length := length + 1
]

{ #category : #accessing }
GtHistoryFlowConnection >> length [
	^ length
]

{ #category : #accessing }
GtHistoryFlowConnection >> originIndex [
	^ originIndex
]

{ #category : #accessing }
GtHistoryFlowConnection >> source: aSource target: aTarget sourceStart: aStart targetStart: aTargetStart origin: anIndex [
	sourceVersion := aSource.
	targetVersion := aTarget.
	sourceStart := aStart.
	targetStart := aTargetStart.
	originIndex := anIndex.
	length := 1
]

{ #category : #accessing }
GtHistoryFlowConnection >> sourceStart [
	^ sourceStart
]

{ #category : #accessing }
GtHistoryFlowConnection >> sourceVersion [
	^ sourceVersion
]

{ #category : #accessing }
GtHistoryFlowConnection >> targetStart [
	^ targetStart
]

{ #category : #accessing }
GtHistoryFlowConnection >> targetVersion [
	^ targetVersion
]
