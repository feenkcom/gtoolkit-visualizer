Trait {
	#name : #TGtWardleyMapDecoratorViewModel,
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #accessing }
TGtWardleyMapDecoratorViewModel >> announce: anAnnouncement [
	self explicitRequirement
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateEdgeElement: anEdgeElement [
	
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateMapElement: aMapElement [
	
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateNodeElementInContext: aNodeDecoratorContext [
	
]

{ #category : #initialization }
TGtWardleyMapDecoratorViewModel >> parentViewModel: aParentViewModel [
	
]

{ #category : #initialization }
TGtWardleyMapDecoratorViewModel >> removeParentViewModel [
	
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> wardleyMapDecoratorModel [
	<return: #TGtWardleyMapDecoratorModel>
	^ self explicitRequirement
]
