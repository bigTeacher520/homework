package exercise2;

public class NewVehicle extends OldVehicle{

	public double batteryCapacity;
	public NewVehicle(int modelNum, int seatingCapacity, double tireSize, double length, double width, double height,
			engine myEngine,double batteryCapacity) {
		super(modelNum, seatingCapacity, tireSize, length, width, height, myEngine);
		// TODO Auto-generated constructor stub
		this.batteryCapacity=batteryCapacity;
	}

	
	
	public void print() {
		super.print();
		System.out.println("batteryCapacity:"+this.batteryCapacity);
	}
}
