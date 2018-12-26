package exercise3;

public class MovableCircle  implements Movable{
	 private MovablePoint center; 
	 private int radius;

	 // Constructor
	 public MovableCircle(int x, int y, int xSpeed, int ySpeed, int radius) {
		 center = new MovablePoint(x, y, xSpeed, ySpeed);
		 this.radius=radius; 
	 }
	 // Implement abstract methods declared in the interface Movable
	 @Override
	 public void moveUp() {
		 center.y += center.ySpeed;
	 }
	 public void moveDown() {
		 center.y -= center.ySpeed;
	 }
	 public void moveLeft() {
		 center.x -= center.xSpeed;
	 }
	 public void moveRight() {
		 center.x += center.xSpeed;
	 }
	 
}
