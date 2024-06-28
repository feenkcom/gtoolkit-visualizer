Trait {
	#name : #TGtWardleyMapWithParent,
	#instVars : [
		'parent'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> hasParent [
	<return: #Boolean>

	^ parent notNil
]

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> notifyParentChanged [
	self explicitRequirement
]

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> parent [
	<return: #Object>

	^ parent
]

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> parent: aNewParent [
	(self parent = aNewParent)
		ifTrue: [ ^ self ].

	parent := aNewParent.
	self notifyParentChanged.
]

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> propagateAnnouncement: anAnnouncement [
	"Send anAnnouncement to myself and to all of my parents in the ascending order"
	| aCurrentParent |

	aCurrentParent := self.
	[ aCurrentParent notNil ]
		whileTrue: [
			"aCurrentParent may or may not actually handle the announcement. it may just propagate it further"
			aCurrentParent announce: anAnnouncement.
			aCurrentParent := aCurrentParent hasParent
				ifTrue: [ aCurrentParent parent ]
				ifFalse: [ nil ] ]
]

{ #category : #'api - parent' }
TGtWardleyMapWithParent >> removeParent [
	"Use this method after the removal of this object from its parent.
	In other words, it must (and can only) be called by its parent, after its removal."

	parent := nil
]
