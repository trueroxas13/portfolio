import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class PiongServer {
  public static class PiongService implements Runnable {
    private Socket client;

    public PiongService(Socket client) { this.client = client; }

    public void run() {
      try {
        BufferedReader input =
            new BufferedReader(new InputStreamReader(client.getInputStream()));
        PrintWriter output = new PrintWriter(client.getOutputStream(), true);

        String request;
        do {
          request = input.readLine();
          System.out.println(request);

          if (request.equals("ping?")) {
            output.println("pong!");
          } else if (request.equals("bye")) {
            request = null;
          } else {
            output.println("again?");
          }
        } while (request != null);

        input.close();
        output.close();
        client.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  public static void main(String[] args) {
    try {
      ServerSocket server = new ServerSocket(13333);

      while (true) {
        Socket client = server.accept();
        Thread thread = new Thread(new PiongService(client));
        thread.start();
      }

      // server.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}