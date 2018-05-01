Bloc treats graph layouts, such as tree or force based, the same as typical widget layouts, such as grid or flow. The challenge comes from the fact that a graph layout depends on the notion of edges between elements, and we did not want to have elements know about edges in the core of Bloc.

The solution was to split the typical edge implementation in graph visualization libraries into two distinct concepts:
- Line is an element that draws the connections.
- Edge defines constraints imposed by connections between elements.

Thus, edges form constraints, and constraints are what layouts deal with. That is one reason why elements in bloc have the ability of defining layout-specific constraints. Using this, we can nicely define edges between elements as a plugin to Bloc, but still be able to connect arbitrary elements. What's more, it turns out that we need constraints for other layouts as well. For example, an element in a grid layout might specify the span.

To understand this better, let us consider the following example:

[[[example=GtGraphLayoutBasicExamples>>#elementsTreeWithEdges|expanded=true|show=gtLiveIn:]]]

With this we visualize the elements that make the chicken element demo:
- we create a label for each element
- we find the parentLabel corresponding to the parent element
- we create an edge between the parentLabel and the current label

As can be seen in the preview, the edge is a constraint. It has no visual impact. And the graph layouts take the edge constraints into account. The cool thing is the edge class is defined next to the graph layout classes, not in the core of Bloc.

To add a visual queue, we need to explicitly add a line element.

[[[example=GtGraphLayoutBasicExamples>>#elementsTreeWithEdgesAndLines|expanded=true|show=gtLiveIn:]]]

