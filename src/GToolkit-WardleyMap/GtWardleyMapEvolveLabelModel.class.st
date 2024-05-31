Class {
	#name : #GtWardleyMapEvolveLabelModel,
	#superclass : #GtWardleyMapNodeLabelModel,
	#traits : 'TGtWardleyMapWithIsVisible',
	#classTraits : 'TGtWardleyMapWithIsVisible classTrait',
	#instVars : [
		'isVisible'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapEvolveLabelModel >> = anObject [
	^ super = anObject and: [ 
		self isVisible = anObject isVisible ]
]

{ #category : #visiting }
GtWardleyMapEvolveLabelModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEvolveLabel: self
]

{ #category : #comparing }
GtWardleyMapEvolveLabelModel >> hash [
	^ super hash
		bitXor: (self isVisible hash)
]

{ #category : #initialization }
GtWardleyMapEvolveLabelModel >> initialize [
	super initialize.
	
	isVisible := false.
]

{ #category : #'api - coordinate' }
GtWardleyMapEvolveLabelModel >> notifyCoordinateChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveLabelModelMoved new evolveLabelModel: self)
]

{ #category : #'api - label' }
GtWardleyMapEvolveLabelModel >> notifyLabelTextChanged [
	self
		propagateAnnouncement: (GtWardleyMapEvolveLabelModelTextChanged new evolveLabelModel: self)
]

{ #category : #'api - visibility' }
GtWardleyMapEvolveLabelModel >> notifyVisibilityChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveLabelModelVisibilityChanged new evolveLabelModel: self)
]
