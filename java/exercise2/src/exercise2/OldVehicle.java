package exercise2;

public class OldVehicle extends vehicle{

	public engine myEngine;
	public OldVehicle(int modelNum, int seatingCapacity, double tireSize, double length, double width,
			double height,engine myEngine) {
		super(modelNum, seatingCapacity, tireSize, length, width, height);
		// TODO Auto-generated constructor stub
		this.myEngine=myEngine;
	}
	public void print() {
		super.print();
		myEngine.print();
	}
}
