import java.util.Stack;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.IntStream;

class Worker extends Thread {
  private Lock lock;
  private Condition condition;
  private Stack<Integer> stack;

  public Worker(Lock lock, Condition condition, Stack<Integer> stack) {
    this.lock = lock;
    this.condition = condition;
    this.stack = stack;
  }

  @Override
  public void run() {
    while (true) {
      lock.lock();
      try {
        while (stack.size() == 0) {
          condition.await();
        }

        Thread.sleep(ThreadLocalRandom.current().nextInt(0, 100));
        System.out.println(this.getName() + ": " + stack.pop());
        condition.signal();
      } catch (InterruptedException e) {
        e.printStackTrace();
      } finally {
        lock.unlock();
        try {
          Thread.sleep(ThreadLocalRandom.current().nextInt(100, 500));
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    }
  }
}

public class SharedStack {
  public static void main(String[] args) {
    Stack<Integer> stack = new Stack<>();
    Lock lock = new ReentrantLock();
    Condition condition = lock.newCondition();

    IntStream.range(0, 10).forEach(
        k -> { new Worker(lock, condition, stack).start(); });

    do {
      lock.lock();
      try {
        while (stack.size() != 0) {
          condition.await();
        }

        IntStream.range(0, 5).forEach(k -> stack.push(k));
        condition.signalAll(); // signal to all threads waiting
      } catch (InterruptedException e) {
        e.printStackTrace();
      } finally {
        lock.unlock();
      }
    } while (true);
  }
}