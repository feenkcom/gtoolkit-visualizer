gt-extension
gtLiveFor: aView
	^ (super gtLiveFor: aView) 
		stencil: [ self asScalableElement ]