Class {
	#name : #GtWardleyMapDecoratorViewModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorViewModel + TGtWithWardleyMapDecoratorModel + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapDecoratorViewModel classTrait + TGtWithWardleyMapDecoratorModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #announcer }
GtWardleyMapDecoratorViewModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
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
