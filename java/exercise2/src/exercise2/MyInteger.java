package exercise2;

public class MyInteger {
	int value;
	MyInteger(int num){this.value=num;}
	public boolean isEven() {return this.value%2==0;}
	public boolean isOdd() {return this.value%2!=0;}
	public int getter() {return this.value;}
	public boolean isPrime() {
		double mid=Math.sqrt(this.value);
		boolean result=true;
		for(int i=2;i<=mid;i++) {
			if(this.value%i==0) {
				result=false;
				break;
			}
		}
		return result;
	}
	public static boolean isEven(int num) {return num%2==0;}
	public static boolean isOdd(int num) {return num%2!=0;}
	public static boolean isPrime(int num) {
		double mid=Math.sqrt(num);
		boolean result=true;
		for(int i=2;i<=mid;i++) {
			if(num%i==0) {
				result=false;
				break;
			}
		}
		return result;
	}
	public static boolean isEven(MyInteger mid) {return mid.getter()%2==0;}
	public static boolean isOdd(MyInteger mid) {return mid.getter()%2!=0;}
	public static boolean isPrime(MyInteger mid) {
		double sur=Math.sqrt(mid.getter());
		boolean result=false;
		for(int i=2;i<=sur;i++) {
			if(mid.getter()%i==0) {
				result=true;
				break;
			}
		}
		return result;
	}
	public boolean equals(int num) {return num==this.value;}
	public boolean equals(MyInteger mid) {return mid.getter()==this.value;}
	/*public static void main(String []args) {
		MyInteger my=new MyInteger(5);
		System.out.println(my.value);
		System.out.println(my.isEven());
		System.out.println(my.isOdd());
		System.out.println(my.isPrime());
		System.out.println(my.isPrime(8));
		
		
	}*/
}
