package exercise2;

public class test {
	public static void main(String []args) {
		Circle2D my=new Circle2D(2,2,2.5);
		Circle2D you=new Circle2D(4,5,10.5);
		Circle2D he=new Circle2D(3,5,2.3);
		System.out.println(my.contains(3, 3));
		System.out.println(my.contains(you));
		System.out.println(my.overlaps(he));
		
	
		engine en =new engine(2,2,2,2);
		OldVehicle old=new OldVehicle(5,5,5,5,5,5,en);
		NewVehicle now=new NewVehicle(6,6,6,6,6,6,en,5);
		PureEnergyVehicle pure=new PureEnergyVehicle(7,7,7,7,7,7,3);
		System.out.print('\n');
		old.print();
		System.out.print('\n');
		now.print();
		System.out.print('\n');
		pure.print();
		
	}
}
