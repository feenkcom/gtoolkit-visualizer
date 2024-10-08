Class {
	#name : #GtWardleyMapDecoratorViewModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorViewModel + TGtWithWardleyMapDecoratorModel + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapDecoratorViewModel classTrait + TGtWithWardleyMapDecoratorModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'parentViewModel'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #announcer }
GtWardleyMapDecoratorViewModel >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #printing }
GtWardleyMapDecoratorViewModel >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Decorator view model: '. 
	wardleyMapDecoratorModel gtDisplayOn: aStream
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapDecoratorViewModel >> isActionableProposition [
	^ self wardleyMapDecoratorModel isActionableProposition
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapDecoratorViewModel >> onWardleyMapDecoratorModelChanged [
	"Is sent when a new wardleyMapDecorator model is assigned to the view model"

	
]

{ #category : #initialization }
GtWardleyMapDecoratorViewModel >> parentViewModel: aParentViewModel [
	parentViewModel := aParentViewModel
]

{ #category : #initialization }
GtWardleyMapDecoratorViewModel >> removeParentViewModel [
	parentViewModel := nil
]
