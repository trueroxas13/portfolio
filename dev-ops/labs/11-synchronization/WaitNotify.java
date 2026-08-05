class CustomThread extends Thread {
  int total;

  @Override
  public void run() {
    synchronized (this) {
      for (int i = 0; i < 10; i++) {
        total += i;
      }
      this.notify();
    }
  }
}

public class WaitNotify {
  public static void main(String[] args) {
    CustomThread b = new CustomThread();
    b.start();

    synchronized (b) {
      try {
        System.out.println("Waiting for the second thread to complete...");
        b.wait();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      System.out.println("Total is: " + b.total);
    }
  }
}