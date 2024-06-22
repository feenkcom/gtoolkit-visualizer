Class {
	#name : #GtWardleyMapEdgeDecoratorContext,
	#superclass : #GtWardleyMapDecoratorContext,
	#instVars : [
		'edgeViewModel',
		'edgeElement',
		'fromNodeElement',
		'toNodeElement'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> edgeElement [
	^ edgeElement
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> edgeElement: anObject [
	edgeElement := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> edgeViewModel [
	^ edgeViewModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> edgeViewModel: anObject [
	edgeViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> fromNodeElement [
	^ fromNodeElement
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> fromNodeElement: anObject [
	fromNodeElement := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> toNodeElement [
	^ toNodeElement
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorContext >> toNodeElement: anObject [
	toNodeElement := anObject
]
