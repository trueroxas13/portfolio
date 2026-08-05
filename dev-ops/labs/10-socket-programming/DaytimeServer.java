import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.time.LocalDateTime;

public class DaytimeServer {
  public static void main(String[] args) {
    try {
      // bind to service port so clients can access the daytime service
      ServerSocket server = new ServerSocket(13);
      System.out.println("Server waiting for client on port " +
                         server.getLocalPort());
      System.out.println("Daytime service started...");
      for (;;) {
        // get the next TCP Client
        Socket nextClient = server.accept();
        // display connection details
        System.out.println("Receiving request from " +
                           nextClient.getInetAddress() + ":" +
                           nextClient.getPort());
        // write the current time to the client socket
        PrintWriter output =
            new PrintWriter(nextClient.getOutputStream(), true);
        output.println(LocalDateTime.now());
        // close connection
        nextClient.close();
        server.close();
      }
    } catch (IOException e) {
      System.out.println("Error: " + e);
    }
  }
}