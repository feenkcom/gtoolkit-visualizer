!Circle layout 

This layout orders a graph's nodes in a circular formation. A very basic example of this layout is shown below. The example demonstrates how 10 nodes belonging to the same container are laid out using this algorithm.

${example:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10SimpleNodes|expanded=true|expandedPreview=true}$

The next example show nodes of varying sizes .

${example:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAndNodesOfIncreasingSize|expanded=true|expandedPreview=true}$

It can be noticed that it is not necessary to specify the circle's radius - it is automatically calculated so that the nodes do not overlap.  The following example shows this feature in action by laying out 10 nodes, much bigger than those used in the preivous example.

${example:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10BigeNodes|expanded=true|expandedPreview=true}$


Optionally, a threshold value can be provided. If that is not the case, the radius will be calculated so that the nodes are close to each other in the resulting layout. If more space is required, the threshold can be manually specified. The larged that value is, the more space there will be between the nodes. The next example shows the same 10 nodes as in the first example, but with the distance parameter (threshold) set to  a value which is twice as big as the default one.

${example:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10SimpleNodesWithDistance|expanded=true|expandedPreview=true}$

The nodes don't have to be plain geometric shapes - they can be complex elements, like textual editors, as demostrated in the following example.

${example:name=GtGradCircleLayoutExamples>>#containerWithCircleLayoutAnd10EditorNodes|expanded=true|expandedPreview=true}$