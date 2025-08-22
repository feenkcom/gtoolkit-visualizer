Class {
	#name : #GtMondrianEdgesExplanation,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #'as yet unclassified' }
GtMondrianEdgesExplanation >> definingEdgesWithConnectFromBlock [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: Collection withAllSubclasses.
	m edges connectFrom: [ :aClass | aClass superclass ].
	m layout tree.
	^ m
]

{ #category : #'as yet unclassified' }
GtMondrianEdgesExplanation >> definingEdgesWithConnectFromToAllBlock [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: Collection withAllSubclasses.
	m edges
		connect: Collection withAllSubclasses
		from: [ :aClass | aClass ]
		toAll: [ :aClass | aClass subclasses ].
	m layout tree.
	^ m
]

{ #category : #'as yet unclassified' }
GtMondrianEdgesExplanation >> definingEdgesWithConnectFromToBlock [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: Collection withAllSubclasses.
	m edges
		connectFrom: [ :aClass | aClass superclass ]
		to: [ :aClass | aClass ].
	m layout tree.
	^ m
]

{ #category : #'as yet unclassified' }
GtMondrianEdgesExplanation >> definingEdgesWithConnectItemsFromToBlock [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: Collection withAllSubclasses.
	m edges
		connect: Collection withAllSubclasses
		from: [ :aClass | aClass superclass ]
		to: [ :aClass | aClass ].
	m layout tree.
	^ m
]

{ #category : #'as yet unclassified' }
GtMondrianEdgesExplanation >> loggingTheEdgesNotCreated [
	<gtExample>
	^ MemoryLogger
		reset;
		startFor: GtMondrianEdgeNotCreated;
		runDuring: [ | m |
			m := GtMondrian new.
			m nodes with: Collection withAllSubclasses.
			m edges
				connect: Collection withAllSubclasses
				from: [ :aClass | aClass ]
				to: [ :aClass | aClass subclasses ].
			m layout tree ]
]
