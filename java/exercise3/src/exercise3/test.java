package exercise3;
public class test {
	public static void main(String []args) {
		Cat cat1 = new Cat();
		 cat1.greeting();
		 Dog dog1 = new Dog();
		 dog1.greeting();
		 BigDog bigDog1 = new BigDog();
		 bigDog1.greeting();

		 // Using Polymorphism
		 Anima animal1 = new Cat();
		 animal1.greeting();
		 Anima animal2 = new Dog();
		 animal2.greeting();
		 Anima animal3 = new BigDog();
		 animal3.greeting();
		 //Anima animal4 = new Anima();

		 // Downcast
		 Dog dog2 = (Dog)animal2;
		 BigDog bigDog2 = (BigDog)animal3;
	//	 Dog dog3 = (Dog)animal3;
	//	 Cat cat2 = (Cat)animal2;
	//	 dog2.greeting(dog3);
	//	 dog3.greeting(dog2);
		 dog2.greeting(bigDog2);
		 bigDog2.greeting(dog2);
		 bigDog2.greeting(bigDog1);
			System.out.println('\n');
		 
		Movable m1 = new MovablePoint(5, 6, 10, 15); // upcast
		System.out.println(m1);
		m1.moveLeft();
		System.out.println(m1);

		Movable m2 = new MovableCircle(1, 2, 3, 4, 20); // upcast
		System.out.println(m2);
		m2.moveRight();
		System.out.println(m2);
	}
}
