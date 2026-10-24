"
Raw Graphviz libcgraph calls.
"
Class {
	#name : #GtGraphvizCgraphLibrary,
	#superclass : #GtGraphvizLibrary,
	#category : #'GToolkit-Graphviz-FFI'
}

{ #category : #accessing }
GtGraphvizCgraphLibrary >> baseName [
	^ 'cgraph'
]

{ #category : #ffi }
GtGraphvizCgraphLibrary >> close: graph [
	^ self ffiCall: #(int agclose(void * graph))
]

{ #category : #ffi }
GtGraphvizCgraphLibrary >> read: text [
	^ self ffiCall: #(void * agmemread(void * text))
]
