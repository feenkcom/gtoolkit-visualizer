calculating
nodeLengthCorrection: aNodeElement level: aLevel largestNodeDimByLevel: aLargestNodeDimByLevelDict
	^ ((aLargestNodeDimByLevelDict at: aLevel) - (aNodeElement measuredBounds height))/2
