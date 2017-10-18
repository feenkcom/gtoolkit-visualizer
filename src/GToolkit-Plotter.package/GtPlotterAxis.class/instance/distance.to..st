testing
distance: anAxisDomainObject to: anotherAxisDomainObject
	"Return a value representing an euclidian distance between domain objects.
	https://en.wikipedia.org/wiki/Euclidean_distance"
	<return: #Boolean>
	
	^ (anAxisDomainObject - anotherAxisDomainObject) abs