private - instance creation
lineElementFrom: aFromAnchorElement to: aToAnchorElement
	| aLineElement aFromValue aToValue |
			
	aFromValue := aFromAnchorElement constraints plotter domainObject value.
	aToValue := aToAnchorElement constraints plotter domainObject value.
	
	aLineElement := lineBlock 
		ifNotNil: [ lineBlock cull: aFromValue cull: aToValue cull: self defaultLineElement ]
		ifNil: [ self defaultLineElement ].

	aLineElement
		constraintsDo: [ :c | c ignoreByLayout ];
		fromAnchor: (BlElementCenterAnchor element: aFromAnchorElement);
		toAnchor: (BlElementCenterAnchor element: aToAnchorElement).
		
	aFromAnchorElement when: BlElementRemovedEvent do: [ aLineElement removeFromParent ].
	aToAnchorElement when: BlElementRemovedEvent do: [ aLineElement removeFromParent ].
	
	^ aLineElement