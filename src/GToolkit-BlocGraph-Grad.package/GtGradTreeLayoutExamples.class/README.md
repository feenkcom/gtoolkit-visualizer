!Tree layout

This layout orders a graph's nodes in such a way that they form  a tree. The layout supports creation of both vertical and horizontal trees. In the first case the root node is at the top, with all of the other nodes being bellow it, as seen in the following example:

${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTree|expanded=true|expandedPreview=true|show=gtLiveFor:}$

On the other hand,  in case of a  horizontal tree , the root node is placed to the left of all other nodes. An example can be seen below:

${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTree|expanded=true|expandedPreview=true|show=gtLiveFor:}$

The layout allows customization of distances between levels of the tree, as well as the nodes. The default value of distance between nodes is 1, meaning that the nodes on the same level are very close to each other.  The default value of level distance is 10. The next examples showcase horizontal and vertical trees created using firstly larger than default values of the  distances, and, secondly, with a smaller level distance.

Big distances:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWithBiggerDistances|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeWithBiggerDistances|expanded=true|expandedPreview=true|show=gtLiveFor:}$

Small distances:
${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWithSmallerDistances|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeWithSmallerDistances|expanded=true|expandedPreview=true|show=gtLiveFor:}$

The layout can also handle graph which are not trees. This is done by firstly traversing the graph using DFS and forming a tree.  
An example of this feature shown bellow:

${example:name=GtGradVerticalTreeLayoutExamples>>#graphWithCycles|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#graphWithCycles|expanded=true|expandedPreview=true|show=gtLiveFor:}$

Additionally, if the layout handles laying out a disconnected graph. That is, a graph that contains several disconnected componnents.
It is possible to configure the distance between trees, as demonstrated by the next examples,  with the first one having the
default distance between trees, and the second one a larger value of the distance parameter. The examples also demonstrate that disconnected horizontal trees are positioned one below the other, while in case of vertical trees, these components of a graph are placed one left/right of each other.

${example:name=GtGradVerticalTreeLayoutExamples>>#disconnectedGraph|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#disconnectedGraphBiggerDistance|expanded=true|expandedPreview=true|show=gtLiveFor:}$

Another important aspect of the tree layout is that it supports alignment of nodes. More precisely, it can be specified if the nodes should have top, center or bottom alignment. In case of the horizontal layout, this actually means that nodes will have left, ceter or right alignment. Examples of different alignmets are shown in the next couple of examples:

${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeTopAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeWithNodesOfIncreasingSizeTopAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$

${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeCenterAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeWithNodesOfIncreasingSizeCenterAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$

${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeWith10NodesOfIncreasingSizeBottomAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeWithNodesOfIncreasingBottomAlignment|expanded=true|expandedPreview=true|show=gtLiveFor:}$

Finally, the trees can be reversed, so that in case of  a vertical tree, the root node is at the bottom, while in case of the horizontal tree, the root node is to the right of the all other nodes. The two examples are shown next:

${example:name=GtGradVerticalTreeLayoutExamples>>#simpleTreeReversed|expanded=true|expandedPreview=true|show=gtLiveFor:}$
${example:name=GtGradHorizontalTreeLayoutExamples>>#simpleTreeReversed|expanded=true|expandedPreview=true|show=gtLiveFor:}$



