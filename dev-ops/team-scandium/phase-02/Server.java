package current;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;

import java.io.*;
import java.lang.reflect.Type;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.*;

public class Server {
    private static final String STORED_TICKETS = "server/users.json";
    private static final int PORT = 13337;
    private static final Gson gson = new Gson();
    private static final List<User> USERS = Collections.synchronizedList(new ArrayList<>());
    private static final List<Room> ROOMS = Collections.synchronizedList(new ArrayList<>());
    private static List<Ticket> TICKETS = Collections.synchronizedList(new ArrayList<>());

    public static void main(String[] args) {
        try{
            ServerSocket serverSocket = new ServerSocket(PORT);
            System.out.println("Server is running...");
            System.out.println("Loading stored user tickets...");
            TICKETS = loadTickets();
            //initialize the counter
            if (TICKETS != null) {
                User.TICKET_COUNTER = TICKETS.size();
            } else {
                TICKETS = new ArrayList<>();
            }
            System.out.printf("Hosted on: %s:%d\n", serverSocket.getInetAddress(), PORT);

            while (true) {
                Socket clientSocket = serverSocket.accept();
                User newUser = new User(clientSocket);
                USERS.add(newUser);
                new Thread(newUser).start();
            }
        } catch (Exception e) {
            System.err.println("Server error: " + e.getMessage());
        }
    }

    private static List<Ticket> loadTickets() throws FileNotFoundException {
        synchronized (TICKETS) {
            Reader reader = new FileReader(STORED_TICKETS);
            JsonReader jsonReader = new JsonReader(reader);
            Type listType = new TypeToken<List<Ticket>>() {}.getType();
            List<Ticket> tickets = gson.fromJson(jsonReader, listType);

            if (tickets != null) {
                System.out.println("Loaded " + tickets.size() + " ticket(s)");
            } else {
                System.out.println("No ticket(s) loaded, none found stored locally on the server.");
            }
            return tickets;
        }
    }

    public static List<User> getUsers (){
        return USERS;
    }

    public static void addUser (User user) {
        synchronized (USERS) {
            USERS.add(user);
            System.out.println("Added user: " + user.getNickname());
            System.out.println(USERS.size() + " user(s)");
        }
    }

    public static void removeUser (User user) {
        synchronized (USERS) {
            USERS.removeIf((u) -> u.getTicket().equals(user.getTicket()));
        }
    }

    public static List<Ticket> getTickets (){
        return TICKETS;
    }

    public static void addTicket (Ticket ticket) {
        synchronized (TICKETS) {
            TICKETS.add(ticket);
        }
    }

    public static List<Room> getRooms (){
        return ROOMS;
    }

    public static void addRoom (Room room) {
        synchronized (ROOMS) {
            ROOMS.add(room);
        }
    }

    public static void removeRoom (Room room) {
        synchronized (ROOMS) {
            ROOMS.removeIf((r) -> r.name.equals(room.name));
        }
    }

    public static void SaveTicket (Ticket ticket) throws IOException {
        synchronized (TICKETS){
            for (Ticket t : TICKETS){
                //in case a duplicate ticket exists, which is near impossible to happen
                if (t.ticket.equals(ticket.ticket)){
                    System.out.println("This ticket was already generated, terminating process.");
                    return;
                }
            }
            TICKETS.add(ticket);
            Writer writer = new FileWriter(STORED_TICKETS);
            gson.toJson(TICKETS, writer);
            writer.flush();
            writer.close();
            System.out.println("Saved ticket to " + STORED_TICKETS + ".");
        }
    }
}

class Ticket {
    public String pseudonym, ticket;

    Ticket(String pseudonym, String ticket) {
        this.pseudonym = pseudonym;
        this.ticket = ticket;
    }
}
