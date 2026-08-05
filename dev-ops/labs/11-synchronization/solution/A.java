public class A implements Runnable {
  ReentrantLockWrapper lock;

  public A(ReentrantLockWrapper lock) { this.lock = lock; }

  @Override
  public void run() {
    lock.print(1);
  }
}