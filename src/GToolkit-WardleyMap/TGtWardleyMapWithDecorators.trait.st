Trait {
	#name : #TGtWardleyMapWithDecorators,
	#instVars : [
		'decorators'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - decorators' }
TGtWardleyMapWithDecorators >> addDecorator: aDecorator [
	self decorators: (self decorators copyWith: aDecorator)
]

{ #category : #'api - decorators' }
TGtWardleyMapWithDecorators >> decorators [
	<return: #Collection of: #TGtWardleyMapDecorator>
	^ decorators ifNil: [ decorators := Array empty ]
]

{ #category : #'api - decorators' }
TGtWardleyMapWithDecorators >> decorators: aCollection [
	self decorators = aCollection
		ifTrue: [ ^ self ].
		
	aCollection do: [ :each | each parent: self ].
	decorators := aCollection.
	self notifyDecoratorsChanged.
]

{ #category : #'api - decorators' }
TGtWardleyMapWithDecorators >> notifyDecoratorsChanged [
	self propagateAnnouncement: (GtWardleyMapNodeModelDecoratorsChanged new nodeModel: self)
]
