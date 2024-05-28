Trait {
	#name : #TGtWardleyMapWithComment,
	#instVars : [
		'comment'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - comment' }
TGtWardleyMapWithComment >> comment [
	<return: #String>

	^ comment
]

{ #category : #'api - comment' }
TGtWardleyMapWithComment >> comment: aComment [
	self comment = aComment
		ifTrue: [ ^ self ].

	comment := aComment.
	self notifyCommentChanged
]

{ #category : #'api - comment' }
TGtWardleyMapWithComment >> hasComment [
	<return: #Boolean>

	^ self comment isNotNil
]

{ #category : #'api - comment' }
TGtWardleyMapWithComment >> notifyCommentChanged [
	self propagateAnnouncement: (GtWardleyMapEdgeModelCommentChanged new edgeModel: self)
]
