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
TGtWardleyMapDecoratorViewModel >> decorateNodeElement: aNodeElement [
]

{ #category : #initialization }
TGtWardleyMapDecoratorViewModel >> parent: aParent [
	
]

{ #category : #initialization }
TGtWardleyMapDecoratorViewModel >> removeParent [
	
]

{ #category : #'api - wardley map decorator view model' }
TGtWardleyMapDecoratorViewModel >> wardleyMapDecoratorModel [
	<return: #TGtWardleyMapDecoratorModel>
	^ self explicitRequirement
]
