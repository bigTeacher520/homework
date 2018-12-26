package exercise4;

public class bank {
	public int count =0;
	public synchronized void addmoney(int money) {
		
		count +=money;
		System.out.println("save:"+money);
		
	}
	public synchronized void lookmoney() {
		System.out.println("bonus:"+count);
	}
}
