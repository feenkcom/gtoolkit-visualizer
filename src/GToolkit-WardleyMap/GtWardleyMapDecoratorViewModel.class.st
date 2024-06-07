Class {
	#name : #GtWardleyMapDecoratorViewModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorViewModel + TGtWithWardleyMapDecoratorModel + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapDecoratorViewModel classTrait + TGtWithWardleyMapDecoratorModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapDecoratorViewModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - wardley map decorator view model' }
GtWardleyMapDecoratorViewModel >> decorateEdgeElement: anEdgeElement [
	self wardleyMapDecoratorModel
		decorateEdgeElement: anEdgeElement
		decoratorViewModel: self
]

{ #category : #'api - wardley map decorator view model' }
GtWardleyMapDecoratorViewModel >> decorateNodeElement: aNodeElement [
	self wardleyMapDecoratorModel
		decorateNodeElement: aNodeElement
		decoratorViewModel: self
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapDecoratorViewModel >> onWardleyMapDecoratorModelChanged [
	"Is sent when a new wardleyMapDecorator model is assigned to the view model"

	
]
