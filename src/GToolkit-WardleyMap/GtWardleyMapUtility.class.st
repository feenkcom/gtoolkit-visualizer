Class {
	#name : #GtWardleyMapUtility,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - diffing' }
GtWardleyMapUtility class >> addModelAsPropositionsFrom: aModel to: propositionModel [
	^ self
		addModelAsPropositionsFrom: aModel
		to: propositionModel
		withPropositionBlock: #yourself
]

{ #category : #'api - diffing' }
GtWardleyMapUtility class >> addModelAsPropositionsFrom: aModel to: propositionModel withPropositionBlock: aBlock [
	| unsetNodes nodes unsetEdges |
	unsetNodes := aModel nodes copy.
	nodes := Dictionary new.

	propositionModel nodes
		do: [ :aNode | 
			| aName |
			aName := aNode label.
			unsetNodes
				detect: [ :anUnsetNode | aName = anUnsetNode label ]
				ifFound: [ :anUnsetNode | 
					nodes at: aName put: anUnsetNode.
					aNode wardleyMapDecoratorModels
						do: [ :aDecorator | anUnsetNode addWardleyMapDecoratorModel: (aDecorator copy removeParent) ].
					unsetNodes remove: anUnsetNode ]
				ifNone: [ aNode removeParent
						addWardleyMapDecoratorModel: (aBlock value: GtWardleyMapAddProposition new).
					aModel addNode: aNode.
					nodes at: aName put: aNode ] ].

	unsetNodes
		do: [ :aNode | 
			aNode
				addWardleyMapDecoratorModel: (aBlock value: GtWardleyMapRemoveProposition new) ].

	unsetEdges := aModel edges copy.

	propositionModel edges
		do: [ :anEdge | 
			| aKey |
			aKey := anEdge fromNode label -> anEdge toNode label.
			unsetEdges
				detect: [ :anUnsetEdge | aKey = (anUnsetEdge fromNode label -> anUnsetEdge toNode label) ]
				ifFound: [ :anUnsetEdge | unsetEdges remove: anUnsetEdge ]
				ifNone: [ anEdge removeParent
						addWardleyMapDecoratorModel: (aBlock value: GtWardleyMapAddProposition new);
						fromNode: (nodes at: aKey key);
						toNode: (nodes at: aKey value).
					aModel addEdge: anEdge ] ].

	unsetEdges
		do: [ :anEdge | 
			anEdge
				addWardleyMapDecoratorModel: (aBlock value: GtWardleyMapRemoveProposition new) ].
	^ aModel
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> buttonLabelFromString: aString [
	aString size <= GtWardleyMapConstants maxButtonLabelCharacters 
		ifTrue: [ ^ aString ].
		
	^ (aString copyFrom: 1 to: GtWardleyMapConstants maxButtonLabelCharacters - 3), '...'
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineModelVerticalCenterOffset: aPipelineNodeModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	Note that same offset is used for inner-nodes."

	^ self 
		computePipelineModelVerticalCenterOffset: aPipelineNodeModel 
		pipelineHeight: GtWardleyMapConstants  pipelineHeight
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineModelVerticalCenterOffset: aPipelineNodeModel pipelineHeight: aHeight [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	Note that same offset is used for inner-nodes."

	| aHalfOfNodeHeight aHalfOfPipelineHeight |
	aHalfOfNodeHeight := aPipelineNodeModel size y / 2.
	aHalfOfPipelineHeight := aHeight / 2.
	
	^ (aHalfOfNodeHeight + aHalfOfPipelineHeight) asFloat
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineModelVerticalTopOffset: aPipelineNodeModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	The offset is expected to represent top y-coordinate (bounds)."

	| aHalfOfNodeHeight |
	aHalfOfNodeHeight := aPipelineNodeModel size y / 2.
	
	^ aHalfOfNodeHeight asFloat
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineViewModelVerticalCenterOffset: aPipelineNodeViewModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	I am used as the second argument for {{gtMethod: BlFrameLayoutConstraintsVertical >> #alignCenterAt:offset:}}.
	Note that same offset is used for inner-nodes."

	^ self computePipelineModelVerticalCenterOffset: aPipelineNodeViewModel wardleyMapNodeModel
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> computePipelineViewModelVerticalTopOffset: aPipelineNodeViewModel [
	"I compute a pipeline element offset that should be used to
	place the pipeline element below its node element.
	The offset is expected to represent top y-coordinate (bounds)."

	^ self computePipelineModelVerticalTopOffset: aPipelineNodeViewModel wardleyMapNodeModel
]

{ #category : #'api - context menu' }
GtWardleyMapUtility class >> contextMenuHandlerPositionOnEvent: anEvent [
	anEvent target
		allParentsDo: [ :aParent | 
			(aParent isKindOf: BrAnchoredElement)
				ifTrue: [ aParent
						childWithId: #handle
						ifFound: [ :aHandle | ^ aHandle bounds inSpace position ]
						ifNone: [ ^ anEvent position ] ] ].

	^ anEvent position
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> convertWardleyScriptNodeModel: aNodeModel labelCoordiante: aTopLeftPoint [ 
	"Conversion is just an estimate. 
	It is not possible to get two visually identical outputs, 
	because the values are affected by variables such as the size of the Wardley area, 
	the used font, etc."

	| aCharCount aCharWidth aCharHalfHeight aCenterX aCenterY aNodeSize |
	aCharCount := aNodeModel label size.
	aCharWidth := 8.
	aCharHalfHeight := 5.
	aNodeSize := GtWardleyMapConstants nodeSize.
	
	aCenterX := aTopLeftPoint x + (aCharCount / 2 * aCharWidth).
	aCenterY := aTopLeftPoint y - aCharHalfHeight.
	
	^ ((aCenterX @ aCenterY) / aNodeSize) asFloatPoint
]

{ #category : #initialization }
GtWardleyMapUtility class >> defaultMapTitle [
	^ 'Wardley Map'
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> ensureCenterDecoratorContainerFor: anElement [
	| aQuery aContainer |
	aQuery := anElement query / GtWardleyCenterDecoratorId.
	aQuery isEmpty ifFalse: [ ^ aQuery result anyOne ].

	anElement clipChildren: false.
	aContainer := GtWardleyMapDecoratorContainerElement new
			id: GtWardleyCenterDecoratorId;
			hFitContent;
			vFitContent.
	aContainer wardley beDecorator.
	
	aContainer constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignCenter.
		c ignored vertical alignCenter ].

	anElement addChild: aContainer.
	^ aContainer
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> ensureCenterRightOuterDecoratorContainerFor: anElement [
	| aQuery aContainer |
	aQuery := anElement query / GtWardleyCenterRightOuterDecoratorId.
	aQuery isEmpty ifFalse: [ ^ aQuery result anyOne ].

	anElement clipChildren: false.
	aContainer := GtWardleyMapDecoratorContainerElement new
			id: GtWardleyCenterRightOuterDecoratorId;
			hFitContent;
			vFitContent.
	aContainer wardley beDecorator.
	
	aContainer constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignLeftAt: 1.0.
		c ignored vertical alignCenter ].

	anElement addChild: aContainer.
	^ aContainer
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> ensureTopLeftInnerDecoratorContainerFor: anElement [
	| aQuery aContainer |
	aQuery := anElement query / GtWardleyTopLeftInnerDecoratorId.
	aQuery isEmpty ifFalse: [ ^ aQuery result anyOne ].

	anElement clipChildren: false.
	aContainer := GtWardleyMapDecoratorContainerElement new
			id: GtWardleyTopLeftInnerDecoratorId;
			hFitContent;
			vFitContent.
	aContainer wardley beDecorator.
	
	aContainer constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignTop ].

	anElement addChild: aContainer.
	^ aContainer
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> ensureTopRightInnerDecoratorContainerFor: anElement [
	| aQuery aContainer |
	aQuery := anElement query / GtWardleyTopRightInnerDecoratorId.
	aQuery isEmpty ifFalse: [ ^ aQuery result anyOne ].

	anElement clipChildren: false.
	aContainer := GtWardleyMapDecoratorContainerElement new
			id: GtWardleyTopRightInnerDecoratorId;
			margin: (BlInsets top: 3 right: 3);
			hFitContent;
			vFitContent.
	aContainer wardley beDecorator.
	
	aContainer constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignTop ].

	anElement addChild: aContainer.
	^ aContainer
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> isNodeElement: aNodeElement insidePipelineElement: aPipelineElement [
	"^ aPipelineElement bounds inParent asRectangle
		containsRect: aNodeElement bounds inParent asRectangle"

	^ aPipelineElement bounds inParent asRectangle
		containsPoint: aNodeElement bounds inParent asRectangle center
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> menuItemLabelMarginInsets [
	^ self menuItemMarginInsets + (BlInsets
		top: 5
		left: 0
		bottom: 0
		right: 0)
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> menuItemMarginInsets [
	^ BlInsets
		top: 0
		left: 3
		bottom: 3
		right: 3
]

{ #category : #'api - widgets' }
GtWardleyMapUtility class >> newColorLabelElement [
	^ self newContextMenuLabel text: 'Color:'
]

{ #category : #'api - widgets' }
GtWardleyMapUtility class >> newContextMenuCheckbox [
	^ GtWardleyMapCheckbox new
		checked: false;
		whenCheckedDo: [ :anEvent |  ];
		whenUncheckedDo: [ :anEvent |  ];
		margin: GtWardleyMapUtility menuItemMarginInsets
]

{ #category : #'api - widgets' }
GtWardleyMapUtility class >> newContextMenuLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin: GtWardleyMapUtility menuItemLabelMarginInsets
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> newMenuItemButton [
	^ BrButton new
		fitContent;
		beSmallSize;
		margin: GtWardleyMapUtility menuItemMarginInsets
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> newMenuItemButtonWithIcon [
	^ self newMenuItemButton
		aptitude: BrGlamorousButtonWithIconAptitude new
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> newMenuItemButtonWithLabel [
	^ self newMenuItemButton
		aptitude: BrGlamorousButtonWithLabelAptitude new
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> newMenuItemDeleteButton [
	^ self newMenuItemButtonWithLabel label: 'Delete'
]

{ #category : #'api - model' }
GtWardleyMapUtility class >> normalizePipelineCoordinate: aPoint [ 
	"I ensure a minimum pipeline width.
	aPoint x is the left pipeline coordinate.
	aPoint y is the right pipeline coordinate."
	
	| aWidth anIncrease aLeft aRight |
	aWidth := aPoint y - aPoint x.
	aWidth >= GtWardleyMapConstants minPipelineRelativeWidth ifTrue: [ ^ aPoint ].
	
	anIncrease := GtWardleyMapConstants minPipelineRelativeWidth - aWidth.
		
	aLeft := aPoint x - (anIncrease / 2).
	aRight := aPoint y + (anIncrease / 2).
	aLeft < 0 ifTrue: [
		aRight := (aRight - aLeft) min: 1.0.
		aLeft := 0 ].
	aRight > 1 ifTrue: [ 
		aLeft := aLeft - (aRight - 1.0) max: 0.0.
		aRight := 1.0
	].
	
	^ aLeft @ aRight
]

{ #category : #'api - model' }
GtWardleyMapUtility class >> normalizePipelineWidthOfNodeModel: aPipelineModel ignoring: anInnerNodeModelOrNil [
	"I compute a pipeline relative width (in 0-1 coordinates).
	I use the pipeline model coordinate and its inner node coordinates.
	I may ignore a specific inner node to compute new pipeline coordinate.
	The new pipeline coordinate may be smaller compared to the pipeline width without inner nodes."

	| aConstant aMinInnerNodeModel aMaxInnerNodeModel |
	aConstant := GtWardleyMapConstants pipelineRelativeOffset.

	aMinInnerNodeModel := aPipelineModel.
	aMaxInnerNodeModel := aPipelineModel.
	aPipelineModel innerNodes
		do: [ :eachNodeModel | 
			eachNodeModel == anInnerNodeModelOrNil ifFalse: [
				eachNodeModel x < aMinInnerNodeModel x 
					ifTrue: [ aMinInnerNodeModel := eachNodeModel ].
				eachNodeModel x > aMaxInnerNodeModel x 
					ifTrue: [ aMaxInnerNodeModel := eachNodeModel ] ] ].
	
	^ (aMinInnerNodeModel x - aConstant max: 0) @ (aMaxInnerNodeModel x + aConstant min: 1).
]

{ #category : #'api - context menu' }
GtWardleyMapUtility class >> normalizedItemPositionOnEvent: anEvent canvas: aCanvas [
	| aGlobalPosition |
	(aCanvas width isZero or: [ aCanvas height isZero ]) ifTrue: [ ^ nil ].

	aGlobalPosition := self contextMenuHandlerPositionOnEvent: anEvent.
	^ (aCanvas globalPointToLocal: aGlobalPosition) / aCanvas extent
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updateMenuContainer: aContainerElement menuItems: aCollectionOfMenuItems usingContext: anEditorContext [
	aContainerElement removeChildren.

	aCollectionOfMenuItems
		do: [ :eachItem | 
			| anElement |
			anElement := eachItem createElementUsingContext: anEditorContext.
			anElement ifNotNil: [ 
				aContainerElement
					addChild: anElement
					as: (GtWardleyMapContextMenuItemId definingMethod: eachItem definingMethod) ] ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updateNodeElement: aNodeElement nodeViewModel: aNodeViewModel [
	"I update node element layout constraints, based on model values.
	If it is an inner node, we know that the y-cordinate is same as 
	its parent (pipeline) node. We therefore offset the y-coordinate 
	accordingly to be visually placed inside of a pipeline widget."

	aNodeElement constraintsDo: [ :c | 
		c frame horizontal alignCenterAt: aNodeViewModel coordinateX.
		
		aNodeViewModel pipelineNodeViewModel
			ifNil: [ c frame vertical alignCenterAt: aNodeViewModel coordinateY ]
			ifNotNil: [ :aPipelineNodeViewModel | 
				"Inner nodes has the same y-coordinates as their pipeline nodes.
				We add an offset to be in the middle of the pipelines widgets."
				c frame vertical 
					alignCenterAt: aNodeViewModel coordinateY 
					offset: (self computePipelineViewModelVerticalCenterOffset: aPipelineNodeViewModel) ].
		 ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updateNoteElement: aNoteElement noteViewModel: aNoteViewModel [
	"I update node element layout constraints, based on model values."

	aNoteElement constraintsDo: [ :c | 
		c frame horizontal alignCenterAt: aNoteViewModel coordinateX.
		c frame vertical alignCenterAt: aNoteViewModel coordinateY ]
]

{ #category : #'api - views' }
GtWardleyMapUtility class >> updatePipelineElement: aPipelineElement nodeViewModel: aNodeViewModel [
	"I update pipeline element layout constraints, based on model values.
	I use its node y-coordinate to place it vertically. 
	For that reason I offset the pipeline element position accordingly."

	aPipelineElement
		constraintsDo: [ :c | 
			
			"Pipeline y-coordinate."
			c frame vertical
				alignCenterAt: aNodeViewModel coordinateY
				offset: (self computePipelineViewModelVerticalCenterOffset: aNodeViewModel).

			"Pipeline x-coordinate"
			c frame horizontal alignLeftAt: aNodeViewModel pipelineCoordinateLeft.
			
			"Pipeline width"
			c frame horizontal weight: aNodeViewModel pipelineCoordinateWeight.
			c horizontal matchParent ]
]
