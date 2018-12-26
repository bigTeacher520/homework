package exercise2;

public class Circle2D {
	public double x;
	public double y;
	public double radius;
	public double getter() {return this.radius;}
	public Circle2D() {
		this.x=0;
		this.y=0;
		this.radius=1;
	}
	public Circle2D(double x , double y,double radius) {
		this.x=x;
		this.y=y;
		this.radius=radius;
	}
	
	public double getArea() {
		return Math.PI*Math.pow(this.radius, 2);
	}
	public double getPerimeter() {return 2*Math.PI*this.radius;}
	public boolean contains(double x, double y) {
		return Math.sqrt(Math.pow(x-this.x, 2)+Math.pow(y-this.y, 2))<this.radius;
	}
	public boolean contains(Circle2D circle) {
		double x=circle.x;
		double y=circle.y;
		double r=circle.radius;
		if(r>this.radius) return false;
		double distance=Math.sqrt(Math.pow(x-this.x, 2)+Math.pow(y-this.y, 2));
		return distance<this.radius-r;
	}
	public boolean overlaps(Circle2D circle) {
		double x=circle.x;
		double y=circle.y;
		double r=circle.radius;
		double distance=Math.sqrt(Math.pow(x-this.x, 2)+Math.pow(y-this.y, 2));
		return (distance<r+this.radius)&&(distance>Math.abs(r-this.radius));
	}
			
}
