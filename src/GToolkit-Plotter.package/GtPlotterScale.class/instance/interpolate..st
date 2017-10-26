operators-mapping
interpolate: aValue
	| domainValue mappedValue |
	
	domainValue := self domain interpolate: aValue.
	
	^ domainValue
	
	"mappedValue := self map: domainValue.
	
	^ self range interpolate: mappedValue"