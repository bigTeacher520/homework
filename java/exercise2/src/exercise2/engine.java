package exercise2;

public class engine {
	public double dischargeCapacity, power, torque ,cylinder;
	public engine(double dischargeCapacity,double  power,double  torque ,double cylinder) {
		this.dischargeCapacity=dischargeCapacity;
		this.power=power;
		this.torque=torque;
		this.cylinder=cylinder;
	}
	public void print() {
		System.out.println("engine:");
		System.out.println("dischargeCapacity:"+this.dischargeCapacity);
		System.out.println("power:"+this.power);
		System.out.println("torque:"+this.torque);
		System.out.println("cylinder:"+this.cylinder);
	}
}
