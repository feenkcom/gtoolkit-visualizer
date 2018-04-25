scripting
element
	| view |
	view := viewInitializer value.
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	shouldInstallClicksOnNodes ifTrue: [ 
		view topStep root
			allChildrenBreadthFirstDo: [ :element | 
				element graph isNode ifTrue: [ 
					element when: BlClickEvent do: [ :event | self selection: element graph model ] ] ] ].
	shouldInstallClicksOnEdges ifTrue: [ 
		view topStep root
			allChildrenBreadthFirstDo: [ :element | 
				element graph isEdge ifTrue: [ 
					element when: BlClickEvent do: [ :event | self selection: element graph model ] ] ] ].
	view topStep root 
		when: GLMBlocObjectToSelect 
		do: [:signal | self selection: signal toSelect ].
	^ view asScalableElement