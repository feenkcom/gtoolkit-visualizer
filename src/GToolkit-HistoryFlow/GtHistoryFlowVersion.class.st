"
One titled attributed text revision in a history flow. Each source-order line has an originating version index. Carries a link to its owning flow.
"
Class {
	#name : #GtHistoryFlowVersion,
	#superclass : #Object,
	#instVars : [
		'title',
		'text',
		'lines',
		'origins',
		'flow',
		'index',
		'underlyingModel'
	],
	#category : #'GToolkit-HistoryFlow'
}

{ #category : #accessing }
GtHistoryFlowVersion class >> title: aTitle text: aText [
	^ self new initializeTitle: aTitle text: aText
]

{ #category : #'instance creation' }
GtHistoryFlowVersion class >> title: aTitle text: aText underlyingModel: anObject [
	^ (self title: aTitle text: aText)
		underlyingModel: anObject;
		yourself
]

{ #category : #accessing }
GtHistoryFlowVersion >> flow [
	^ flow
]

{ #category : #accessing }
GtHistoryFlowVersion >> flow: aFlow index: anIndex origins: originIndices [
	flow := aFlow.
	index := anIndex.
	origins := originIndices asArray
]

{ #category : #'gt-extensions' }
GtHistoryFlowVersion >> gtTextFor: aView [
	"What text belongs to this revision?"

	<gtView>
	^ aView text
		title: 'Text';
		priority: 10;
		text: [ text ]
]

{ #category : #accessing }
GtHistoryFlowVersion >> index [
	^ index
]

{ #category : #accessing }
GtHistoryFlowVersion >> initializeTitle: aTitle text: aText [
	title := aTitle asString copy.
	text := aText asRopedText copy.
	lines := text asString lines asArray.
	origins := #().
	^ self
]

{ #category : #accessing }
GtHistoryFlowVersion >> lines [
	^ lines
]

{ #category : #accessing }
GtHistoryFlowVersion >> originRunsDo: aBlock [
	| start origin |
	lines isEmpty ifTrue: [ ^ self ].
	start := 0.
	origin := origins first.
	2
		to: origins size
		do: [ :position | 
			(origins at: position) = origin
				ifFalse: [ aBlock
						value: start
						value: position - 1
						value: origin.
					start := position - 1.
					origin := origins at: position ] ].
	aBlock
		value: start
		value: origins size
		value: origin
]

{ #category : #accessing }
GtHistoryFlowVersion >> origins [
	^ origins
]

{ #category : #accessing }
GtHistoryFlowVersion >> origins: originIndices [
	self assert: originIndices size = lines size.
	origins := originIndices asArray
]

{ #category : #accessing }
GtHistoryFlowVersion >> printOn: aStream [
	aStream nextPutAll: title
]

{ #category : #accessing }
GtHistoryFlowVersion >> text [
	^ text
]

{ #category : #accessing }
GtHistoryFlowVersion >> title [
	^ title
]

{ #category : #accessing }
GtHistoryFlowVersion >> underlyingModel [
	^ underlyingModel ifNil: [ self ]
]

{ #category : #accessing }
GtHistoryFlowVersion >> underlyingModel: anObject [
	underlyingModel := anObject
]
