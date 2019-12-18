"
Source: *https://github.com/d3/d3-hierarchy/blob/master/src/treemap/dice.js*

{{{
export default function(parent, x0, y0, x1, y1) {
  var nodes = parent.children,
      node,
      i = -1,
      n = nodes.length,
      k = parent.value && (x1 - x0) / parent.value;

  while (++i < n) {
    node = nodes[i], node.y0 = y0, node.y1 = y1;
    node.x0 = x0, node.x1 = x0 += node.value * k;
  }
}
}}}

"
Class {
	#name : #GtGraphTreemapDiceMethod,
	#superclass : #GtGraphTreemapMethod,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #'layout - computations' }
GtGraphTreemapDiceMethod >> parent: parent x0: x0 y0: y0 x1: x1 y1: y1 [
	| k x0m |
	x0m := x0.
	k := (parent value isZero or: [ (x1 - x0) isZero ])
		ifTrue: [ 0 ] ifFalse: [ 1 / parent value ].
	parent children do: [ :node |
		node y0: y0.
		node y1: y1.
		node x0: x0m.
		x0m := x0m + (node value * k).
		node x1: x0m.
	 ]
]
