package exercise4;

public class bin2Dec {
	public int binDec(String name) {
		int sum=0;
		try {
			sum=Integer.parseInt(name);
		}
		catch(NumberFormatException e) {
			System.out.println("erro:"+e);
		}
		System.out.println(sum);
		return 1;
	}
	
	/*public static void main(String []args) {
		bin2Dec mid=new bin2Dec();
		mid.binDec("13");
		mid.binDec("13s");
		int []array=new int[100];
		System.out.println(array[1]);
		try {
			System.out.println(array[101]);
		}
		catch(ArrayIndexOutOfBoundsException e){
			System.out.println("erro:"+e);
		}
	}*/
}
