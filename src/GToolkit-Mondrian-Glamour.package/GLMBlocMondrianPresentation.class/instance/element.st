scripting
element
	| view |
	view := GtMondrian new. 
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	view topStep root 
		when: GLMBlocObjectToSelect 
		do: [:signal | self selection: signal toSelect ].
	^ view asScalableElement