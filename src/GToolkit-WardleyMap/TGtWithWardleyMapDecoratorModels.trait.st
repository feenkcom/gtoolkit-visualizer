Trait {
	#name : #TGtWithWardleyMapDecoratorModels,
	#instVars : [
		'wardleyMapDecoratorModels'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> addWardleyMapDecoratorModel: aWardleyMapDecoratorModel [
	aWardleyMapDecoratorModel parent: self.
	self wardleyMapDecoratorModels add: aWardleyMapDecoratorModel.
	self notifyWardleyMapDecoratorModelAdded: aWardleyMapDecoratorModel
]

{ #category : #'gt - extensions' }
TGtWithWardleyMapDecoratorModels >> gtWardleyMapDecoratorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Decorators';
		items: [ self wardleyMapDecoratorModels copy ];
		column: 'Name' text: #yourself;
		column: 'Proposition'
			text: [ :anItem | 
				anItem isActionableProposition
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ] width: 50
]

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> notifyWardleyMapDecoratorModelAdded: aWardleyMapDecoratorModel [
	self explicitRequirement
]

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> notifyWardleyMapDecoratorModelRemoved: aWardleyMapDecoratorModel [
	self explicitRequirement
]

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> removeWardleyMapDecoratorModel: aWardleyMapDecoratorModel [
	self wardleyMapDecoratorModels remove: aWardleyMapDecoratorModel ifAbsent: [ ^ self ].
	aWardleyMapDecoratorModel removeParent.
	self notifyWardleyMapDecoratorModelRemoved: aWardleyMapDecoratorModel
]

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> wardleyMapDecoratorModels [
	<return: #Collection of: #TGtWardleyMapDecoratorModel>
	^ wardleyMapDecoratorModels ifNil: [ wardleyMapDecoratorModels := OrderedCollection new ]
]

{ #category : #'api - decorators' }
TGtWithWardleyMapDecoratorModels >> wardleyMapDecoratorModels: aCollection [
	| toAdd toRemove |
	toAdd := OrderedCollection new: aCollection size.
	toRemove := OrderedCollection new: self wardleyMapDecoratorModels size.
	aCollection do: [ :eachDecorator | 
		(self wardleyMapDecoratorModels includes: eachDecorator)
			ifFalse: [ toAdd add: eachDecorator ] ].
	self wardleyMapDecoratorModels do: [ :eachDecorator | 
		(aCollection includes: eachDecorator)
			ifFalse: [ toRemove add: eachDecorator ] ].
			
	toRemove do: [ :each | self removeWardleyMapDecoratorModel: each ].
	toAdd do: [ :each | self addWardleyMapDecoratorModel: each ].
]
