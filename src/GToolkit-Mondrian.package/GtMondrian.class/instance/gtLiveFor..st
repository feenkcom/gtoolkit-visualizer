ui
gtLiveFor: aView
	<gtView: 0>
	^ aView "mondrian"
		title: 'Live';
		stencil: [
			| pannableElement |
			pannableElement := self asPannableElement.
			pannableElement 
				when: BlClickEvent 
				do: [ :event | 
					event target graph isNode ifTrue: [ 	
						pannableElement fireEvent: (GtInspectorObjectToSpawn new
							object: event target graph model;
							sourceElement: event target) ] ].
			pannableElement ]