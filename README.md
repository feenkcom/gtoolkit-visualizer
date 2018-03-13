# GToolkit Visualizer
A set of visualization engines that are part of the [Glamorous Toolkit](https://github.com/feenkcom/gtoolkit) and are based on the Bloc graphical engine. Currently, the projects contains:
- GT Mondrian, an engine that offers a fluent API for scripting graph-based visualizations.
- GT Connector, an engine that offers a visual way to explore examples.
- GT Diagrammer, an engine for constructing diagrams.

## Installation

You can load Visualizer through:

```
Iceberg enableMetacelloIntegration: true.
Metacello new
   baseline: 'GToolkitVisualizer';
   repository: 'github://feenkcom/gtoolkit-visualizer/src';
   load.
```

