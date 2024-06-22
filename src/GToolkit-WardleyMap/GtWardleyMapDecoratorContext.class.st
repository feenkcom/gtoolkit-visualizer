Class {
	#name : #GtWardleyMapDecoratorContext,
	#superclass : #Object,
	#instVars : [
		'mapElement',
		'canvasContainer',
		'canvasElement',
		'decoratorViewModel'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #accessing }
GtWardleyMapDecoratorContext >> canvasContainer [
	^ canvasContainer
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> canvasContainer: anObject [
	canvasContainer := anObject
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> canvasElement [
	^ canvasElement
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> canvasElement: anObject [
	canvasElement := anObject
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> decoratorViewModel [
	^ decoratorViewModel
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> decoratorViewModel: anObject [
	decoratorViewModel := anObject
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> mapElement [
	^ mapElement
]

{ #category : #accessing }
GtWardleyMapDecoratorContext >> mapElement: anObject [
	mapElement := anObject
]
