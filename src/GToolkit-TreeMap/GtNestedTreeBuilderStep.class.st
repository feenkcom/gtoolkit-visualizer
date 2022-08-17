Class {
	#name : #GtNestedTreeBuilderStep,
	#superclass : #Object,
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : #factory }
GtNestedTreeBuilderStep class >> null [
	^ GtNestedTreeBuilderLastStep default
]

{ #category : #adding }
GtNestedTreeBuilderStep >> addItems: anArray to: aTreeItem [
	self subclassResponsibility
]

{ #category : #enumerating }
GtNestedTreeBuilderStep >> allSteps [
	^ Array streamContents: [ :aStream | 
		self stepsTo: aStream ]
]

{ #category : #building }
GtNestedTreeBuilderStep >> buildRoot: aStepContext [
	<return: #GtNestedTreeNode>
	^ self subclassResponsibility
]

{ #category : #configuration }
GtNestedTreeBuilderStep >> collectNodes: aNodesBlock leaves: aLeavesBlock in: aBuilderOrStep [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> description [
	<return: #String>
	^ ''
]

{ #category : #configuration }
GtNestedTreeBuilderStep >> groupBy: aBlockClosure in: aBuilderOrStep [
	self subclassResponsibility
]

{ #category : #'gt-extension' }
GtNestedTreeBuilderStep >> gtStepsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Steps';
		items: [ self allSteps ];
		column: 'Index' text: [ :aStep :anIndex | anIndex ] width: 80;
		column: 'Name' text: [ :aStep :anIndex | aStep name ] width: 80;
		column: 'Details' text: [ :aStep :anIndex | aStep description ]
]

{ #category : #accessing }
GtNestedTreeBuilderStep >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newCollectStep [
	^ GtNestedTreeBuilderCollectStep new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newGroupByStep [
	^ GtNestedTreeBuilderGroupByStep new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newItemNamed: aName withContext: aStepContext [ 
	<return: #GtNestedTreeItem>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newLeaf [
	^ GtNestedTreeItemLeaf new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newLeavesFrom: aStepContext [ 
	^ aStepContext data collect: [ :eachItem | 
		self newLeaf 
			item: eachItem;
			weight: aStepContext weight ]
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newNode [
	^ GtNestedTreeNode new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newNodesFrom: aStepContext [ 
	^ aStepContext data collect: [ :eachItem | 
		self newNode 
			name: eachItem ]
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newRejectStep [
	^ GtNestedTreeBuilderRejectStep new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newSummarizeStep [
	^ GtNestedTreeBuilderSummaryStep new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderStep >> newSummaryLeaf [
	^ GtNestedTreeSummaryLeaf new
]

{ #category : #configuration }
GtNestedTreeBuilderStep >> reject: aBlockClosure in: aBuilderOrStep [
	self subclassResponsibility
]

{ #category : #private }
GtNestedTreeBuilderStep >> stepsTo: aStream [
	self subclassResponsibility
]

{ #category : #configuration }
GtNestedTreeBuilderStep >> summarizeIn: aBuilderOrStep [
	self subclassResponsibility
]
