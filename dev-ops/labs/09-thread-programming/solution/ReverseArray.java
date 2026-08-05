import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ReverseArray {
  private static class CThread implements Runnable {
    private List<Integer> list;
    private int index;

    public CThread(List<Integer> list, int index) {
      this.list = list;
      this.index = index;
    }

    public void run() {
      System.out.printf("%s swap indices %d and %d\n",
                        Thread.currentThread().getName(), index,
                        list.size() - (this.index + 1));
      Collections.swap(list, this.index, list.size() - (this.index + 1));
    }
  }

  public static void main(String[] args) {
    final int size = Integer.parseInt(args[0]);
    List<Integer> list = new ArrayList<Integer>();
    for (int index = 0; index < size; ++index) {
      list.add(index);
    }
    Collections.shuffle(list);

    System.out.println(list);

    List<Thread> threads = new ArrayList<Thread>();
    for (int index = 0; index < size / 2; ++index) {
      Thread thread = new Thread(new CThread(list, index));
      threads.add(thread);
      thread.start();
    }

    try {
      for (Thread thread : threads) {
        thread.join();
      }
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    System.out.println(list);
  }
}