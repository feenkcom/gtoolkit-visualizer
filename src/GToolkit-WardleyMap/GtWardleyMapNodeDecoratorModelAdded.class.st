Class {
	#name : #GtWardleyMapNodeDecoratorModelAdded,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'decoratorModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeDecoratorModelAdded >> decoratorModel [
	<return: #TGtWardleyMapDecoratorModel>
	^ decoratorModel
]

{ #category : #accessing }
GtWardleyMapNodeDecoratorModelAdded >> decoratorModel: anObject [
	decoratorModel := anObject
]
