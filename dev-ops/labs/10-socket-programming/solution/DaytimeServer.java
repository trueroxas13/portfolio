import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.time.LocalDateTime;

public class DaytimeServer {
  public static class DaytimeService implements Runnable {
    private Socket client;

    public DaytimeService(Socket client) { this.client = client; }

    public void run() {
      try {
        System.out.println("Receiving request from " + client.getInetAddress() +
                           ":" + client.getPort());
        PrintWriter output = new PrintWriter(client.getOutputStream(), true);
        output.println(LocalDateTime.now());
        output.close();
        client.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  public static void main(String[] args) {
    try {
      ServerSocket server = new ServerSocket(13);
      System.out.println("Server waiting for client on port " +
                         server.getLocalPort());
      System.out.println("Daytime service started...");
      while (true) {
        Socket client = server.accept();
        Thread service = new Thread(new DaytimeService(client));
        service.start();
      }
      // server.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}