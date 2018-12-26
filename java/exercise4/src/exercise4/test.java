package exercise4;

public class test {
	public static void main(String []args) {
		bank my=new bank();
		Thread Aadd = new Thread(new Runnable() {
			public synchronized void run() {
				try{for(int i=0;i<20;i++) {
		
					System.out.print('A');
					System.out.print(':');
					System.out.print(i);
					
					my.addmoney(100);
					my.lookmoney();
					
				    	Thread.sleep(50);  
					}
				      
				}
				catch (InterruptedException e) {
			         e.printStackTrace();
			       }
			}
		});
		Thread Badd = new Thread(new Runnable() {
			public synchronized void run() {
				try{for(int i=0;i<20;i++) {
					
					System.out.print('B');
					System.out.print(':');
					System.out.print(i);
					my.addmoney(100);
					my.lookmoney();
					
				    	Thread.sleep(50);  
				      }
				      
				}
				catch (InterruptedException e) {
			         e.printStackTrace();
			       }
				
			}
		});
		Aadd.start();
		Badd.start();
	}
	
}
