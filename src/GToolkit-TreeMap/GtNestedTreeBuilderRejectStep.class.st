Class {
	#name : #GtNestedTreeBuilderRejectStep,
	#superclass : #GtNestedTreeBuilderInnerStep,
	#instVars : [
		'reject'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #building }
GtNestedTreeBuilderRejectStep >> buildRoot: aStepContext [
	| aFilteredData |
	aFilteredData := aStepContext data reject: self reject.
	^ self step buildRoot: (aStepContext copyWithData: aFilteredData)
]

{ #category : #initialization }
GtNestedTreeBuilderRejectStep >> defaultReject [
	^ [ :anItem | false ]
]

{ #category : #accessing }
GtNestedTreeBuilderRejectStep >> description [
	^ self reject printString
]

{ #category : #building }
GtNestedTreeBuilderRejectStep >> fill: aTreeItem withContext: aStepContext [
	^ self shouldNotImplement
]

{ #category : #configuration }
GtNestedTreeBuilderRejectStep >> groupBy: aBlockClosure in: aBuilderOrStep [
	self step groupBy: aBlockClosure in: self
]

{ #category : #initialization }
GtNestedTreeBuilderRejectStep >> initialize [
	super initialize.
	reject := self defaultReject.
]

{ #category : #accessing }
GtNestedTreeBuilderRejectStep >> name [
	<return: #String>
	^ 'Reject'
]

{ #category : #accessing }
GtNestedTreeBuilderRejectStep >> reject [
	^ reject
]

{ #category : #accessing }
GtNestedTreeBuilderRejectStep >> reject: anObject [
	reject := anObject
]

{ #category : #configuration }
GtNestedTreeBuilderRejectStep >> reject: aBlockClosure in: aBuilderOrStep [ 
	self step reject: aBlockClosure in: self
]
