Class {
	#name : #GtWardleyMapEdgeDecoratorModelRemoved,
	#superclass : #GtWardleyMapEdgeModelAnnouncement,
	#instVars : [
		'decoratorModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeDecoratorModelRemoved >> decoratorModel [
	^ decoratorModel
]

{ #category : #accessing }
GtWardleyMapEdgeDecoratorModelRemoved >> decoratorModel: anObject [
	decoratorModel := anObject
]
