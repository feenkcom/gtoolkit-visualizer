ui
gtLiveFor: aView
	<gtView: 0>
	^ aView 
		title: 'Live';
		content: [self asPannableElement]