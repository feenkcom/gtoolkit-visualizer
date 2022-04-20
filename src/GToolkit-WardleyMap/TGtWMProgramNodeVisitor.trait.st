Trait {
	#name : #TGtWMProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitAnchor: anAnchor [
	^ self visitProgram: anAnchor
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitAnnotation: anAnnotation [
	^ self visitProgram: anAnnotation
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitAttitude: anAttitude [
	^ self visitProgram: anAttitude
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitCoords: aCoords [
	^ self visitProgram: aCoords
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitDecorator: aDecorator [
	^ self visitProgram: aDecorator
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitEcosystem: anEcosystem [
	^ self visitProgram: anEcosystem
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitElement: anElement [
	^ self visitProgram: anElement
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitEvolution: anEvolution [
	^ self visitProgram: anEvolution
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitEvolve: anEvolve [
	^ self visitProgram: anEvolve
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitFile: aFile [
	^ self visitProgram: aFile
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitFlowLink: aFlowLink [
	^ self visitLink: aFlowLink
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitLabel: aLabel [
	^ self visitProgram: aLabel
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitLink: aLink [
	^ self visitProgram: aLink
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitManyCoords: aManyCoords [
	^ self visitProgram: aManyCoords
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitMarket: aMarket [
	^ self visitProgram: aMarket
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitMethod: aMethod [
	^ self visitProgram: aMethod
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitNote: aNote [
	^ self visitProgram: aNote
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitPipeline: aPipeline [
	^ self visitProgram: aPipeline
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitPresentationAnnotation: aPresentationAnnotation [
	^ self visitProgram: aPresentationAnnotation
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitPresentationStyle: aPresentationStyle [
	^ self visitProgram: aPresentationStyle
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitPresentationYAxis: aPresentationYAxis [
	^ self visitProgram: aPresentationYAxis
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitSubmap: aSubmap [
	^ self visitProgram: aSubmap
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitTitle: aTitle [
	^ self visitProgram: aTitle
]

{ #category : #generated }
TGtWMProgramNodeVisitor >> visitUrl: anUrl [
	^ self visitProgram: anUrl
]
