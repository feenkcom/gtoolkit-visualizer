initialization
initialize
	super initialize.

	self layoutDo: [ :l | l cellSpacing: 10 ].

	self display: [ GtDiagrammerStencil allSubclasses collect: #new ].
	self shape: [ :aStencil |		
		BlScalableElement new
			size: 100@100;
			contentElement: aStencil create ].
		