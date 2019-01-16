Class {
	#name : #GtPhlowMondrianView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'paintingStencilBuilder',
		'mondrianInstanceBuilder',
		'mondrianInstance',
		'mondrianElement',
		'transformation'
	],
	#category : #'GToolkit-Mondrian-Phlow'
}

{ #category : #accessing }
GtPhlowMondrianView >> asElementDo: aBlock [
	paintingStencilBuilder value: mondrianInstance.
	mondrianElement := mondrianInstance asPannableElement.
	mondrianElement
		when: BlClickEvent
		do: [ :event | 
			(event target graph isNode or: [ event target graph isEdge ])
				ifTrue: [ 
					| transformedObject |
					transformedObject := transformation cull: event target graph model.
					mondrianElement
						fireEvent:
							(GtPhlowObjectToSpawn new
								object: transformedObject;
								sourceElement: event target) ] ].
	mondrianElement phlow beView; entity: self.
	^ aBlock value: mondrianElement
]

{ #category : #initialize }
GtPhlowMondrianView >> initialize [
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ].
	transformation := [ :x | "by default there is no transformation" x ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomin asElement ;
			action: [ mondrianElement zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomout asElement ;
			action: [ mondrianElement zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons zoomtofit asElement ;
			action: [ mondrianElement zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons actualsize asElement;
			action: [ mondrianElement zoomToActualSize ] ]
	
]

{ #category : #scripting }
GtPhlowMondrianView >> initialize: aMondrian [
	mondrianInstance := aMondrian
]

{ #category : #scripting }
GtPhlowMondrianView >> painting: aBlock [
	paintingStencilBuilder := aBlock
]

{ #category : #scripting }
GtPhlowMondrianView >> send: aBlock [
	transformation := aBlock
]
