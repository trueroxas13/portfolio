public class B implements Runnable {
  ReentrantLockWrapper lock;

  public B(ReentrantLockWrapper lock) { this.lock = lock; }

  @Override
  public void run() {
    lock.print(2);
  }
}