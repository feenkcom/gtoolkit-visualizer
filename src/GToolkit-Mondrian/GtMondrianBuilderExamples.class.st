Class {
	#name : #GtMondrianBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #'as yet unclassified' }
GtMondrianBuilderExamples >> lookupNodeThatDoesNotExist [
	<gtExample>
	<return: #GtMondrian>
	| mondrian result |
	mondrian := GtMondrian new.
	mondrian nodes with: (1 to: 2).
	result := mondrian root graph
			nodeAt: 0
			ifPresent: [ self
					assert: false
					description: 'There should not be a node for 0 in the cache' ]
			ifAbsent: [ nil ].
	self assert: result isNil.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianBuilderExamples >> lookupNodeThatExistsInChild [
	<gtExample>
	<return: #GtMondrian>
	| mondrian result |
	mondrian := GtMondrian new.
	mondrian nodes
		with: (1 to: 2);
		forEach: [ :x | mondrian nodes with: {x * 10} ].
	result := mondrian root graph
			nodeAt: 10
			ifAbsent: [ self assert: false description: 'There should be a node for 10 in the cache' ].
	self assert: result graph isNode.
	self assert: result graph model = 10.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianBuilderExamples >> lookupNodeThatExistsInFirstChildButWithUMLClassShape [
	"this defines a tricky scenario in which the children are added in a sub element of the 
	parent node element"

	<gtExample>
	<return: #GtMondrian>
	| mondrian result |
	mondrian := GtMondrian new.
	mondrian nodes
		umlClassShapeWithName: [ :x | x asString ];
		with: (1 to: 2);
		forEach: [ :x | mondrian nodes with: {x * 10} ].
	result := mondrian root graph
			nodeAt: 10
			ifAbsent: [ self assert: false description: 'There should be a node for 10 in the cache' ].
	self assert: result graph isNode.
	self assert: result graph model = 10.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianBuilderExamples >> lookupNodeThatExistsInRoot [
	<gtExample>
	<return: #GtMondrian>
	| mondrian result |
	mondrian := GtMondrian new.
	mondrian nodes with: (1 to: 2).
	result := mondrian root graph
			nodeAt: 1
			ifAbsent: [ self assert: false description: 'There should be a node for 1 in the cache' ].
	self assert: result graph isNode.
	self assert: result graph model = 1.
	^ mondrian
]

{ #category : #'as yet unclassified' }
GtMondrianBuilderExamples >> lookupNodeThatExistsInSecondChildButWithUMLClassShape [
	"this defines a tricky scenario in which the children are added in a sub element of the 
	parent node element"

	<gtExample>
	<return: #GtMondrian>
	| mondrian result |
	mondrian := GtMondrian new.
	mondrian nodes
		umlClassShapeWithName: [ :x | x asString ];
		with: (1 to: 2);
		forEach: [ :x | mondrian nodes with: {x * 10} ].
	result := mondrian root graph
			nodeAt: 20
			ifAbsent: [ self assert: false description: 'There should be a node for 20 in the cache' ].
	self assert: result graph isNode.
	self assert: result graph model = 20.
	^ mondrian
]
