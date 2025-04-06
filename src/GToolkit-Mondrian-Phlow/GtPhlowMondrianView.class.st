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
	#category : #'GToolkit-Mondrian-Phlow-View'
}

{ #category : #accessing }
GtPhlowMondrianView >> asElementDo: aBlock [
	| wrapper |
	self
		performBlock: [ paintingStencilBuilder value: mondrianInstance ]
		onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].
	wrapper := BrFrame new matchParent.
	mondrianElement := mondrianInstance asPannableElement.
	mondrianElement
		when: BlClickEvent
		do: [ :event | 
			event target withAllParents
				detect: [ :element | element graph isNode or: [ element graph isEdge ] ]
				ifFound: [ :element | 
					| transformedObject graphModel |
					graphModel := element graph isEdge
							ifFalse: [ element graph model ]
							ifTrue: [ element graph model model ].
					transformedObject := transformation cull: graphModel.
					mondrianElement phlow spawnObject: transformedObject ] ].
	wrapper addChild: mondrianElement.
	self beViewElement: wrapper.
	^ aBlock value: wrapper
]

{ #category : #initialize }
GtPhlowMondrianView >> initialize [
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ].
	transformation := [ :x | "by default there is no transformation" x ].
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomin asElement;
			label: 'Zoom in';
			action: [ mondrianElement zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomout asElement ;
			label: 'Zoom out';
			action: [ mondrianElement zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousIcons zoomtofit asElement ;
			label: 'Zoom to fit';
			action: [ mondrianElement zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			label: 'Reset to actual size';
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

{ #category : #accessing }
GtPhlowMondrianView >> updateContent: aCurrentElement [
	self initialize: GtMondrian new.
	self asElementDo: [ :aWrapper |
		| aChild |
		aChild := (aWrapper childAt: 1).
		aChild removeFromParent.
		aCurrentElement enqueueTask: (BlTaskAction new
			action: [ 
				aCurrentElement removeChildren.
				aCurrentElement addChild: aChild ]) ].
]
