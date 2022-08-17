Class {
	#name : #GtNestedTreeBuilderSummaryStep,
	#superclass : #GtNestedTreeBuilderStep,
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : #adding }
GtNestedTreeBuilderSummaryStep >> addItems: anArray to: aTreeItem [
	aTreeItem leaves: anArray
]

{ #category : #building }
GtNestedTreeBuilderSummaryStep >> buildRoot: aStepContext [ 
	^ self newItemNamed: 'Summary' withContext: aStepContext
]

{ #category : #configuration }
GtNestedTreeBuilderSummaryStep >> groupBy: aBlockClosure in: aBuilderOrStep [
	aBuilderOrStep step: (self newGroupByStep groupBy: aBlockClosure; step: self)
]

{ #category : #accessing }
GtNestedTreeBuilderSummaryStep >> name [
	<return: #String>
	^ 'Summary'
]

{ #category : #'instance creation' }
GtNestedTreeBuilderSummaryStep >> newItemNamed: aName withContext: aStepContext [ 
	<return: #GtNestedTreeSummaryLeaf>
	| aTreeItem |
	aTreeItem := self newSummaryLeaf.
	aTreeItem name: aName.
	aTreeItem items: aStepContext data.
	aTreeItem weight: aStepContext weight.
	^ aTreeItem
]

{ #category : #configuration }
GtNestedTreeBuilderSummaryStep >> reject: aBlockClosure in: aBuilderOrStep [
	aBuilderOrStep step: (self newRejectStep reject: aBlockClosure; step: self)
]

{ #category : #private }
GtNestedTreeBuilderSummaryStep >> stepsTo: aStream [
	aStream nextPut: self
]

{ #category : #configuration }
GtNestedTreeBuilderSummaryStep >> summarizeIn: aBuilderOrStep [
	"do nothing, we already have one summary step"
]
