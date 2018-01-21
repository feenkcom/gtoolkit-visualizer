baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Bloc'
					with: [ spec
						repository: 'github://pharo-graphics/Bloc/src';
						loads: #core ];
				package: 'GToolkit-BlocGraph' with: [ spec requires: #(#Bloc) ];
				package: 'GToolkit-Plotter' with: [ spec requires: #(#Bloc) ];
				package: 'GToolkit-Mondrian' with: [ spec requires: #(#'GToolkit-BlocGraph') ];
				package: 'GToolkit-Mondrian-Layouts' with: [ spec requires: #(#'GToolkit-Mondrian') ];
				package: 'GToolkit-Mondrian-Glamour' with: [ spec requires: #(#'GToolkit-Mondrian') ]";
				package: 'GToolkit-Diagrammer' with: [ spec requires: #(#'GToolkit-Mondrian') ]"
				 ]