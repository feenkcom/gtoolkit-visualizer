Trait {
	#name : #TGtWardleyMapVisitor,
	#category : #'GToolkit-WardleyMap-Visitor'
}

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMap: aWardleyMap [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapEdge: aWardleyMapEdge [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapEdgeLabel: aWardleyMapEdgeLabel [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapEvolve: aWardleyMapEvolve [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapEvolveLabel: aWardleyMapEvolveLabel [
	^ self visitWardleyMapNodeLabel: aWardleyMapEvolveLabel
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapNode: aWardleyMapNode [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapNodeEvolve: aWardleyMapNodeEvolve [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapNodeLabel: aWardleyMapNodeLabel [
]

{ #category : #visiting }
TGtWardleyMapVisitor >> visitWardleyMapNote: aWardleyMapNote [
]
