baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitPhlow' with: [ spec repository: 'github://feenkcom/gtoolkit-phlow/src' ];
			baseline: 'GToolkitVisualizer' with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ];
			package: 'GToolkit-Mondrian-Phlow' with: [spec requires: #(GToolkitPhlow GToolkitVisualizer)]
	]
