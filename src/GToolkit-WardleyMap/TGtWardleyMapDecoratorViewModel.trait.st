Trait {
	#name : #TGtWardleyMapDecoratorViewModel,
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #accessing }
TGtWardleyMapDecoratorViewModel >> announce: anAnnouncement [
	self explicitRequirement
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateEdgeElementInContext: anEdgeDecoratorContext [
	self wardleyMapDecoratorModel decorateEdgeElementInContext: anEdgeDecoratorContext
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateMapElementInContext: aGtWardleyMapDecoratorContext [
	self wardleyMapDecoratorModel decorateMapElementInContext: aGtWardleyMapDecoratorContext
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> decorateNodeElementInContext: aGtWardleyNodeDecoratorContext [
	self wardleyMapDecoratorModel decorateNodeElementInContext: aGtWardleyNodeDecoratorContext
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
