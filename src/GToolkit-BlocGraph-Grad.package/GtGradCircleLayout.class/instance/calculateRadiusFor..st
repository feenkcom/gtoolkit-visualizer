computation
calculateRadiusFor: aCollectionOfNodes
	<return: #Number>

	"vertex.getSize().getWidth() -> node measuredBounds width.
	vertex.getSize().getHeight() -> node measuredBounds height.
	"

	aCollectionOfNodes size = 2
		ifTrue: [ ^ aCollectionOfNodes first measuredBounds width + aCollectionOfNodes second measuredBounds width + self distance ].

	^ 200

"public double calculateRadius(List<V> vertices,  double treshold){

		double radius = 0D;
		
		if (vertices.size() == 2){
			return vertices.get(0).getSize().getWidth() + vertices.get(1).getSize().getWidth() + treshold;
		}

		double slice = 2 * Math.PI / vertices.size();
		V currentV = null;
		V previousV = null;
		double currentTheta = 0;
		double previousTheta = 0;

		for (int i = 1; i <= vertices.size(); i++){

			previousTheta = currentTheta;
			previousV = vertices.get(i - 1);

			if (i < vertices.size()){
				currentV = vertices.get(i);
				currentTheta = slice * i;
			}
			else{
				currentV = vertices.get(0);
				currentTheta = 0;
			}

			double r_x = 0;

			if (Math.abs(Math.cos(currentTheta) - Math.cos(previousTheta)) > 0.01) //not parallel
				r_x = (currentV.getSize().getWidth() + previousV.getSize().getWidth() + treshold) 
				/ (2 * (Math.abs(Math.cos(currentTheta) - Math.cos(previousTheta))));

			double r_y = 0;

			if (Math.abs(Math.sin(currentTheta) - Math.sin(previousTheta)) > 0.01) //not parallel
				r_y = (currentV.getSize().getHeight() + previousV.getSize().getHeight() + treshold) 
				/ (2 * (Math.abs(Math.sin(currentTheta) -  Math.sin(previousTheta))));


			double r_current = Math.min(r_x, r_y);
			
			if (radius < r_current)
				radius = r_current;
		}

		return radius;

	}"