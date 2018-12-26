package exercise2;

public class vehicle{
	public int modelNum;
	public int seatingCapacity;
	public double tireSize;
	public double length;
	public double width;
	public double height;
	
	public vehicle(int modelNum,int seatingCapacity,
			double tireSize,double length,double width,
			 double height) {
		this.modelNum=modelNum;
		this.seatingCapacity=seatingCapacity;
		this.tireSize=tireSize;
		this.length=length;
		this.width=width;
		this.height=height;
		
	}
	public void print() {
		System.out.println("vehicle:");
		System.out.println("seatingCapacity:"+this.seatingCapacity);
		System.out.println("tireSize:"+this.tireSize);
		System.out.println("length:"+this.length);
		System.out.println("width:"+this.width);
		System.out.println("height:"+this.height);
		
	}
}
