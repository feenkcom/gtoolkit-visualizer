Class {
	#name : #GtWardleyMapNodeDecoratorModelRemoved,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'decoratorModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeDecoratorModelRemoved >> decoratorModel [
	<return: #TGtWardleyMapDecoratorModel>
	^ decoratorModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorModelRemoved >> decoratorModel: anObject [
	decoratorModel := anObject
]
