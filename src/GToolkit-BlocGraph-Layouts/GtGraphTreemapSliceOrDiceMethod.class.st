"
I am a copy of class GtGraphTreemapDiceMethod. This comment is copied from there, and might not be entirely accurate

Source: *https://github.com/d3/d3-hierarchy/blob/master/src/treemap/sliceDice.js*

{{{
export default function(parent, x0, y0, x1, y1) {
  (parent.depth & 1 ? slice : dice)(parent, x0, y0, x1, y1);
}
}}}

"
Class {
	#name : #GtGraphTreemapSliceOrDiceMethod,
	#superclass : #GtGraphTreemapMethod,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'layout - computations' }
GtGraphTreemapSliceOrDiceMethod >> parent: parent x0: x0 y0: y0 x1: x1 y1: y1 [
	parent depth even 
		ifTrue: [ GtGraphTreemapSliceMethod new parent: parent x0: x0 y0: y0 x1: x1 y1: y1 ] 
		ifFalse: [ GtGraphTreemapDiceMethod new parent: parent x0: x0 y0: y0 x1: x1 y1: y1 ]
]
