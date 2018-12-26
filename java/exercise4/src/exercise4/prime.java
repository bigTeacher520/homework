package exercise4;

public class prime extends Thread{
		   private Thread t;
		   private int beginInt;
		   private int endInt;
		   private String my;
		   
		   public prime( String my,int begin,int end) {
		      this.my=my;
			   this.beginInt=begin;
		      this.endInt=end;
		   }
		   
		   public void run() {
		      try{
		    	  for(int i=this.beginInt;i<endInt;i++) {
		    	  boolean res=false;
		    	  for(int j=2;j<i;j++) {
		    		  if(i%j==0 && i!=1 && i!=2) {
		    			  res=true;
		    			  break;
		    		  }
		    	  }
		    	  if(res) {System.out.println(i);}
		    	  Thread.sleep(50);
		      	}
		      }
		      catch (InterruptedException e) {
		          System.out.println("Thread " +  my + " interrupted.");
		       }
		      System.out.println("Thread " +  this.my + " exiting.");
		   }
		   
		   public void start () {
		      if (t == null) {
		         t = new Thread(this,this.my);
		         t.start ();
		      }
		   }
		   /*public static void main(String []args) {
			   prime my=new prime("my",1,1000);
			   my.start();
			   prime you=new prime("you",1001,2000);
			   you.start();
			   prime he=new prime("he",2001,3000);
			   he.start();
			   
		   }*/
		}
