Class {
	#name : #GtNestedTreeBuilder,
	#superclass : #Object,
	#instVars : [
		'step',
		'stepContext'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #building }
GtNestedTreeBuilder >> build [
	<return: #GtNestedTreeNode>
	^ self step buildRoot: self stepContext
]

{ #category : #accessing }
GtNestedTreeBuilder >> data [
	^ self stepContext data
]

{ #category : #accessing }
GtNestedTreeBuilder >> data: anObject [
	self stepContext data: anObject
]

{ #category : #configuration }
GtNestedTreeBuilder >> groupBy: anObject [
	self step groupBy: anObject in: self
]

{ #category : #'gt-extension' }
GtNestedTreeBuilder >> gtStepsFor: aView [
	<gtView>
	self step ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Steps';
		object: [ self step ];
		view: #gtStepsFor:
]

{ #category : #initialization }
GtNestedTreeBuilder >> initialize [
	super initialize.
	step := GtNestedTreeBuilderStep null.
	stepContext := GtNestedTreeBuilderStepContext new.
]

{ #category : #'instance creation' }
GtNestedTreeBuilder >> newLeaf [
	^ GtNestedTreeItemLeaf new
]

{ #category : #'instance creation' }
GtNestedTreeBuilder >> newNode [
	^ GtNestedTreeNode new
]

{ #category : #configuration }
GtNestedTreeBuilder >> reject: anObject [
	self step reject: anObject in: self
]

{ #category : #accessing }
GtNestedTreeBuilder >> step [
	^ step
]

{ #category : #accessing }
GtNestedTreeBuilder >> step: anObject [
	step := anObject
]

{ #category : #accessing }
GtNestedTreeBuilder >> stepContext [
	^ stepContext
]

{ #category : #accessing }
GtNestedTreeBuilder >> stepContext: anObject [
	stepContext := anObject
]

{ #category : #configuration }
GtNestedTreeBuilder >> summarize [
	self step summarizeIn: self
]

{ #category : #accessing }
GtNestedTreeBuilder >> weight [
	^ self stepContext weight
]

{ #category : #accessing }
GtNestedTreeBuilder >> weight: anObject [
	self stepContext weight: anObject
]
