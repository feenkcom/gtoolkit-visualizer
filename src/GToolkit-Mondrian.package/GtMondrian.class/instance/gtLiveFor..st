ui
gtLiveFor: aView
	<gtView: 0>
	^ aView 
		title: 'Live';
		stencil: [self asPannableElement]