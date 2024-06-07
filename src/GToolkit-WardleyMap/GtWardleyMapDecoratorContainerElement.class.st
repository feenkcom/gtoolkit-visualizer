Class {
	#name : #GtWardleyMapDecoratorContainerElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapDecoratorContainerElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
GtWardleyMapDecoratorContainerElement >> initialize [
	super initialize.
	self wardley beDecorator.
	self fitContent
]

{ #category : #'hooks - children' }
GtWardleyMapDecoratorContainerElement >> onChildRemoved: anElement [
	super onChildRemoved: anElement.
	
	"Ensure that I am removed if there are not other decorators left."
	self childrenCount isZero ifFalse: [ ^ self ].
	self removeFromParent
]
