calculating
nodeBreadthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: aLargestNodeDimByLevelDict
	^ ((aLargestNodeDimByLevelDict at: aLevel) - (aNodeElement measuredBounds width))/2.
