scripting
connect: aCollection from: aFromBlock to: aToBlock
	| elements |
	elements := OrderedCollection new.
	aCollection do: [ :each | 
		| fromObject toObject fromElement toElement line |
		fromObject := aFromBlock value: each.
		toObject := aToBlock value: each.
		"fromElement := mondrian nodeAt: fromObject ifAbsent: [nil].
		toElement := mondrian nodeAt: toObject ifAbsent: [nil]."
		self topStep root
				allChildrenBreadthFirstDo: [ :child | 
					child graph isNode
						ifTrue: [ | aMondrianModel |
							aMondrianModel := child graph model.
							aMondrianModel = fromObject
								ifTrue: [ fromElement := child ].
							aMondrianModel = toObject
								ifTrue: [ toElement := child ] ] ].
		(toElement notNil and: [ fromElement notNil ])
			ifTrue: [ line := self edgeElementFor: each from: fromElement to: toElement.
				self areEdgesPassive
					ifFalse: [ self edgeConstraintsFrom: fromElement to: toElement ].
				elements add: line ]
			ifFalse: [ (GtMondrianEdgeNotCreated new fromElement: fromElement; toElement: toElement; model: each; fromModel: fromObject; toModel: toObject) emit ] ].
	self topStep root addChildren: elements.
	^ elements