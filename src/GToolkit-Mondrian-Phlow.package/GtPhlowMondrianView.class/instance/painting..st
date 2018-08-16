scripting
painting: aBlock
	self originalView stencil: [
		| mondrian pannableElement | 
		mondrian := GtMondrian new.
		aBlock value: mondrian.
		pannableElement := mondrian asPannableElement.
		pannableElement 
			when: BlClickEvent 
			do: [ :event | 
				event target graph isNode ifTrue: [ 	
					pannableElement fireEvent: (GtInspectorObjectToSpawn new
						object: event target graph model;
						sourceElement: event target) ] ] ]