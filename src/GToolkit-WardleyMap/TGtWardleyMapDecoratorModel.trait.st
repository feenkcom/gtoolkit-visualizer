Trait {
	#name : #TGtWardleyMapDecoratorModel,
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
TGtWardleyMapDecoratorModel >> asDecoratorViewModel [
	<return: #TGtWardleyMapDecoratorViewModel>
	^ GtWardleyMapDecoratorViewModel new wardleyMapDecoratorModel: self
]

{ #category : #'api - wardley map decorator model' }
TGtWardleyMapDecoratorModel >> decorateEdgeElementInContext: anEdgeDecoratorContext [
	
]

{ #category : #'api - wardley map decorator model' }
TGtWardleyMapDecoratorModel >> decorateMapElementInContext: aMapDecoratorContext [
	
]

{ #category : #'api - wardley map decorator model' }
TGtWardleyMapDecoratorModel >> decorateNodeElementInContext: aNodeDecoratorContext [
	
]

{ #category : #testing }
TGtWardleyMapDecoratorModel >> isActionableProposition [
	"Return true if it can be handled by GtWardleyMapAllProposition.
	Such decorator must implement #onAcceptAction and #onRejectAction methods.
	Return false in other cases."

	<return: #Boolean>
	^ false
]

{ #category : #testing }
TGtWardleyMapDecoratorModel >> isAllProposition [
	"Return true if it is a GtWardleyMapAllProposition.
	Return false in other cases."

	<return: #Boolean>
	^ false
]

{ #category : #initialization }
TGtWardleyMapDecoratorModel >> parent: aParent [
	
]

{ #category : #initialization }
TGtWardleyMapDecoratorModel >> removeParent [
	
]
