computation
normalize: aDomainObject
	<return: #Number>
	| aProjection |

	aProjection := aDomainObject projectionOn: self.
	^ (aProjection - self min) / self length