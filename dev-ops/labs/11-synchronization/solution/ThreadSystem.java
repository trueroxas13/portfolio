public class ThreadSystem {
  public static void main(String[] args) {
    ReentrantLockWrapper r = new ReentrantLockWrapper();
    A a = new A(r);
    B b = new B(r);

    Thread t1 = new Thread(a);
    Thread t2 = new Thread(b);
    t1.start();
    t2.start();
  }
}