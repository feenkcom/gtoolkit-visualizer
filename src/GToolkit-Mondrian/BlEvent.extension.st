Extension { #name : #BlEvent }

{ #category : #'*Gtoolkit-Mondrian' }
BlEvent >> gtTraversedLiveFor: aView [
	<gtView: 10>
	^ aView mondrian
		title: 'Traversed';
		painting: [ :mondrian | self traversedTargetsTreeWith: mondrian ]
]
