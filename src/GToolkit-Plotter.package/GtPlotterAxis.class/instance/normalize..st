computation
normalize: aDomainObject
	| aProjection |

	aProjection := aDomainObject projectionOn: self.
	^ (aProjection - self min) / self length