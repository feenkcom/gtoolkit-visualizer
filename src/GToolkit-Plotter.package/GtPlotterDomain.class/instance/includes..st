testing
includes: aValue
	"Return true if a given value lays within this domain"
	<return: #Boolean>
	
	^ aValue >= self interval min and: [ aValue <= self interval max ]