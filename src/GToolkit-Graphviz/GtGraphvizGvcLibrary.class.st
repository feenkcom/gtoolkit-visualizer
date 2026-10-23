"
Raw Graphviz libgvc calls. Native pointers are owned by the caller.
"
Class {
	#name : #GtGraphvizGvcLibrary,
	#superclass : #GtGraphvizLibrary,
	#category : #'GToolkit-Graphviz-FFI'
}

{ #category : #accessing }
GtGraphvizGvcLibrary >> baseName [
	^ 'gvc'
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> createContext [
	^ self ffiCall: #(void * gvContext())
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> freeContext: context [
	^ self ffiCall: #(int gvFreeContext(void * context))
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> freeLayout: graph context: context [
	^ self ffiCall: #(int gvFreeLayout(void * context, void * graph))
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> freeRenderData: data [
	^ self ffiCall: #(void gvFreeRenderData(void * data))
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> layout: graph context: context engine: engine [
	^ self ffiCall: #(int gvLayout(void * context, void * graph, char * engine))
]

{ #category : #ffi }
GtGraphvizGvcLibrary >> render: graph context: context format: format data: data length: length [
	^ self ffiCall: #(int gvRenderData(void * context, void * graph, char * format, void * data, void * length))
]
