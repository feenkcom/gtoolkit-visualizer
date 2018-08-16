*Gtoolkit-Mondrian
gtTraversedLiveFor: aView
	<gtView: 10>
	^ aView explicit
		title: 'Traversed';
		stencil: [ 
			| mondrian |
			mondrian := GtMondrian new.
			self traversedTargetsTreeWith: mondrian.
			mondrian asPannableElement ]