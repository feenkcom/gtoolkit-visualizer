"
Source: *https://github.com/d3/d3-hierarchy/blob/master/src/treemap/slice.js*

{{{
export default function(parent, x0, y0, x1, y1) {
  var nodes = parent.children,
      node,
      i = -1,
      n = nodes.length,
      k = parent.value && (y1 - y0) / parent.value;

  while (++i < n) {
    node = nodes[i], node.x0 = x0, node.x1 = x1;
    node.y0 = y0, node.y1 = y0 += node.value * k;
  }
}
}}}
"
Class {
	#name : #GtGraphTreemapSliceMethod,
	#superclass : #GtGraphTreemapMethod,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'layout - computations' }
GtGraphTreemapSliceMethod >> parent: parent x0: x0 y0: y0 x1: x1 y1: y1 [
	| k y0m |
	y0m := y0.
	k := (parent value isZero or: [ (y1 - y0) isZero ])
		ifTrue: [ 0 ] ifFalse: [ 1 / parent value ].
	parent children do: [ :node |
		node x0: x0.
		node x1: x1.
		node y0: y0m.
		y0m := y0m + (node value * k).
		node y1: y0m.
	 ]
]
