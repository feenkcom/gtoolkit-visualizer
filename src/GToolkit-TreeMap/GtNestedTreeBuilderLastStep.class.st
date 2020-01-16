Class {
	#name : #GtNestedTreeBuilderLastStep,
	#superclass : #GtNestedTreeBuilderStep,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #cleanup }
GtNestedTreeBuilderLastStep class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
GtNestedTreeBuilderLastStep class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
GtNestedTreeBuilderLastStep class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
GtNestedTreeBuilderLastStep class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #building }
GtNestedTreeBuilderLastStep >> buildRoot: aStepContext [ 
	^ self newNode
		leaves: (self newLeavesFrom: aStepContext)
]

{ #category : #building }
GtNestedTreeBuilderLastStep >> fill: aTreeItem withContext: aStepContext [ 
	aTreeItem leaves: (self newLeavesFrom: aStepContext)
]

{ #category : #configuration }
GtNestedTreeBuilderLastStep >> groupBy: aBlockClosure in: aBuilderOrStep [ 
	aBuilderOrStep step: (self newGroupByStep groupBy: aBlockClosure)
]

{ #category : #accessing }
GtNestedTreeBuilderLastStep >> name [
	^ 'Leaves'
]

{ #category : #configuration }
GtNestedTreeBuilderLastStep >> reject: aBlockClosure in: aBuilderOrStep [
	aBuilderOrStep step: (self newRejectStep reject: aBlockClosure)
]

{ #category : #private }
GtNestedTreeBuilderLastStep >> stepsTo: aStream [
	aStream nextPut: self
]
