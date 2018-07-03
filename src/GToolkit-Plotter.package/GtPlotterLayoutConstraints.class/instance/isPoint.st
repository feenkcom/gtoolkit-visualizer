testing
isPoint
	^ self hasDomainObject and: [ self isTick not and: [ self isAxis not ] ]