!Tree layout

This layout order a graph's nodes so that they form a tree. The layout supports creation of both vertical and horizontal trees. In the first case the root node is at the top, with all of the other nodes being bellow it, as seen in the following example.

${example:name=GtGradVerticalTreeLayouttExamples>>#simpleTree|expanded=true|expandedPreview=true}$

On the other hand, a horizontal tree is formed in such way that the root node is to the left of all other nodes. An example can be seen below:

${example:name=GtGradHorizontalTreeLayouttExamples>>#simpleTree|expanded=true|expandedPreview=true}$

The layout allows customization of distances between levels of the tree, as well as the nodes. The next examples showcase horizontal and vertical trees created using firstly larger than default values of the mentioned distances, and, secondly, very small values of these parameters.

Big distances:
${example:name=GtGradVerticalTreeLayouttExamples>>#simpleTreeWithBiggerDistances|expanded=true|expandedPreview=true}$
${example:name=GtGradHorizontalTreeLayouttExamples>>#simpleTreeWithBiggerDistances|expanded=true|expandedPreview=true}$

Small distances:
${example:name=GtGradVerticalTreeLayouttExamples>>#simpleTreeWithSmallerDistances|expanded=true|expandedPreview=true}$
${example:name=GtGradHorizontalTreeLayouttExamples>>#simpleTreeWithSmallerDistances|expanded=true|expandedPreview=true}$

The layout can also handle graph which are not trees. This is done by firstly traversing the graph using DFS and forming a tree.  
An example of this feature shown bellow.

${example:name=GtGradVerticalTreeLayouttExamples>>#graphWithCycles|expanded=true|expandedPreview=true}$
${example:name=GtGradHorizontalTreeLayouttExamples>>#graphWithCycles|expanded=true|expandedPreview=true}$

Additionally, it the layout handles laying out a disconnected graph. That is, a graph that contains several disconnected componnents.
It is possible to configure the distance between trees, as demonstrated by the next examples,  with the first one having the
default distance between trees, and the second one a larger one.

${example:name=GtGradVerticalTreeLayouttExamples>>#disconnectedGraph|expanded=true|expandedPreview=true}$
${example:name=GtGradVerticalTreeLayouttExamples>>#disconnectedGraphBiggerDistance|expanded=true|expandedPreview=true}$

