Class {
	#name : #GtPlotterDataDecoratorExamples,
	#superclass : #GtPlotterDataExamples,
	#category : #'GToolkit-Plotter-Example - Data'
}

{ #category : #'examples - decorations' }
GtPlotterDataDecoratorExamples >> colorDangerDifferently [
	<gtExample>
	<return: #GtPlotterDataVirtualGroups>
	| aGroup theColors |
	theColors := {#low -> Color gray.
			#medium -> Color orange.
			#high -> Color red} asDictionary.

	aGroup := self browserDataGroupSortedByDanger
			background: [ :eachValue | theColors at: (eachValue at: #danger) ].

	self assert: aGroup isLogicalGroup not.
	self assert: aGroup isComposite.
	self assert: aGroup isVirtual.
	self assert: aGroup isDecorator not.
	self assert: aGroup size equals: 3.

	self assert: (aGroup at: 1) isDecorator.
	self assert: (aGroup at: 1) color equals: Color red.
	self assert: (aGroup at: 1) size equals: 3337.

	self assert: (aGroup at: 2) isDecorator.
	self assert: (aGroup at: 2) color equals: Color orange.
	self assert: (aGroup at: 2) size equals: 3360.

	self assert: (aGroup at: 3) isDecorator.
	self assert: (aGroup at: 3) color equals: Color gray.
	self assert: (aGroup at: 3) size equals: 3303.

	^ aGroup
]

{ #category : #'examples - decorations' }
GtPlotterDataDecoratorExamples >> colorInBlockOnAllData [
	<gtExample>
	<return: #GtPlotterDataGroupWithColor>
	| aGroup |
	aGroup := self browserDataGroup background: [ :eachValue | Color blue ].

	self assert: aGroup isLogicalGroup not.
	self assert: aGroup isDecorator.
	self assert: aGroup isComposite not.
	self assert: aGroup color equals: Color blue.
	self assert: aGroup entity isComposite not.
	self assert: aGroup entity isDecorator not.
	self assert: aGroup size equals: self browserData size.

	^ aGroup
]

{ #category : #'examples - decorations' }
GtPlotterDataDecoratorExamples >> singleColorOnAllData [
	<gtExample>
	<return: #GtPlotterDataGroupWithColor>
	| aGroup |
	aGroup := self browserDataGroup background: Color blue.

	self assert: aGroup isLogicalGroup not.
	self assert: aGroup isDecorator.
	self assert: aGroup isComposite not.
	self assert: aGroup color equals: Color blue.
	self assert: aGroup entity isComposite not.
	self assert: aGroup entity isDecorator not.
	self assert: aGroup size equals: self browserData size.

	^ aGroup
]
