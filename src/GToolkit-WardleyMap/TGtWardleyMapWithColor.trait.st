Trait {
	#name : #TGtWardleyMapWithColor,
	#instVars : [
		'color'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - color' }
TGtWardleyMapWithColor >> color [
	<return: #Color>

	^ color
]

{ #category : #'api - color' }
TGtWardleyMapWithColor >> color: aColor [
	self color = aColor
		ifTrue: [ ^ self ].

	color := aColor.
	self notifyColored
]

{ #category : #'api - color' }
TGtWardleyMapWithColor >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapEdgeModelColored new edgeModel: self)
]
