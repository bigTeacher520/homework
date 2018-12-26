package exercise2;

public class PureEnergyVehicle extends vehicle{
	public double Maximum;
	public PureEnergyVehicle(int modelNum, int seatingCapacity, double tireSize, double length, double width,
			double height,double Maximum) {
		super(modelNum, seatingCapacity, tireSize, length, width, height);
		// TODO Auto-generated constructor stub
		this.Maximum=Maximum;
	}

	
		
	public void print() {
		super.print();
		System.out.println("Maximum:"+this.Maximum);
	}
}
