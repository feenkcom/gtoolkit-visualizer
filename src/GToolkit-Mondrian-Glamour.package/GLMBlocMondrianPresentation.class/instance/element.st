scripting
element
	| view |
	view := viewInitializer value.
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	shouldInstallClicksOnNodes ifTrue: [ 
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target graph isNode
				ifTrue: [
					anEvent consumed: true.
					self selection: anEvent target graph model ] ] ].
	shouldInstallClicksOnEdges ifTrue: [ 
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target graph isEdge
				ifTrue: [
					anEvent consumed: true.
					self selection: anEvent target graph model ] ] ].
	view topStep root 
		when: GLMBlocObjectToSelect 
		do: [:signal | self selection: signal toSelect ].
	^ view asPannableElement