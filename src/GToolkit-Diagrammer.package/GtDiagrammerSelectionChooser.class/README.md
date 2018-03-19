I am a special selection on-click chooser with the support of the selection "dive in".

Initially, the selection context (or step) is the diagrammer canvas.

 - After the first click on a figure I choose the top-most parent of a clicked figure whose parent is the current selection content, in this case a canvas. Once selected, that parent becomes a new selection context.
 - Next click selects the top-parent of a click target within the selection context after the previous click.
 - If user clicks outside of the current selection context, we reset it and start all over again with the canvas as selection context.