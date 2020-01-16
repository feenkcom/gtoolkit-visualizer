Class {
	#name : #GtNestedTreeBuilderAction,
	#superclass : #Object,
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #enumerating }
GtNestedTreeBuilderAction >> allSteps [
	^ Array streamContents: [ :aStream | 
		self stepsTo: aStream ]
]

{ #category : #building }
GtNestedTreeBuilderAction >> fill: aTreeItem withContext: aStepContext [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtNestedTreeBuilderAction >> gtStepsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Steps';
		items: [ self allSteps ];
		column: 'Index' item: [ :aStep :anIndex | anIndex ] width: 80;
		column: 'Group By' item: [ :aStep :anIndex | aStep name ]
]

{ #category : #accessing }
GtNestedTreeBuilderAction >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtNestedTreeBuilderAction >> newLeaf [
	^ GtNestedTreeLeaf new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderAction >> newLeavesFrom: aStepContext [ 
	^ aStepContext data collect: [ :eachItem | 
		self newLeaf 
			item: eachItem;
			weight: aStepContext weight ]
]

{ #category : #'instance creation' }
GtNestedTreeBuilderAction >> newNode [
	^ GtNestedTreeNode new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderAction >> newRootNode [
	^ GtNestedTreeRoot new
]

{ #category : #'instance creation' }
GtNestedTreeBuilderAction >> newStep [
	^ GtNestedTreeBuilderStep new
]

{ #category : #private }
GtNestedTreeBuilderAction >> stepsTo: aStream [
	self subclassResponsibility
]
