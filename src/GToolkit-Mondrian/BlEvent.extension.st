Extension { #name : #BlEvent }

{ #category : #'*Gtoolkit-Mondrian' }
BlEvent >> gtTraversedLiveFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Traversed';
		priority: 50;
		painting: [ :mondrian | self traversedTargetsTreeWith: mondrian ]
]
