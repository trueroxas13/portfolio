import java.util.ArrayList;
import java.util.List;

class Trapezoidal implements Runnable {
  static List<Double> areas;
  static double a;
  static double b;
  static double dx;
  static int n;
  int k;

  Trapezoidal(int k) { this.k = k; }

  double f(double x) { return Math.exp(-Math.pow(x, 2.0)); }

  @Override
  public void run() {
    areas.set(k, dx * 0.5 * (f(a + k * dx) + f(a + (k + 1) * dx)));
  }

  public static void main(String[] args) {
    a = Double.parseDouble(args[0]);
    b = Double.parseDouble(args[1]);
    n = Integer.parseInt(args[2]);
    dx = (b - a) / n;

    areas = new ArrayList<>();
    List<Thread> threads = new ArrayList<>();
    for (int k = 0; k < n; ++k) {
      areas.add(0.0);
      threads.add(new Thread(new Trapezoidal(k)));
      threads.get(k).start();
    }

    try {
      for (Thread thread : threads) {
        thread.join();
      }
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    double integral = 0.0;
    for (int k = 0; k < n; ++k) {
      integral += areas.get(k);
    }

    System.out.println(integral);
    System.out.println(integral * integral); // converges to Math.PI
  }
}