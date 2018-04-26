computation
normalize: aDomainObject
	<return: #Number>
	| aProjection aLength |

	aProjection := aDomainObject projectionOn: self.
	aLength := self length.
	aLength isZero
		ifTrue: [ ^ 0 ].
	
	^ (aProjection - self min) / self length