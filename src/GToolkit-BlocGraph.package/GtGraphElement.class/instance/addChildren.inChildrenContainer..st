*GToolkit-BlocGraph
addChildren: aCollection inChildrenContainer: aSymbol 
	^ ((self childrenContainers) at: aSymbol ifAbsent: [self element]) addChildren: aCollection