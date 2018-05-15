*Gtoolkit-Mondrian
gtTraversedLiveFor: aView
	<gtView: 10>
	^ aView 
		title: 'Traversed';
		stencil: [ 
			| mondrian |
			mondrian := GtMondrian new.
			self traversedTargetsTreeWith: mondrian.
			mondrian asPannableElement ]