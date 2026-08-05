package current;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class Room {
    public final String name;
    public final List<User> users = Collections.synchronizedList(new ArrayList<>());
    public User moderator;


    public Room(String name, User moderator) {
        synchronized (Server.getRooms()){
            for (Room room : Server.getRooms()){
                if (room.name.equals(name)){
                    throw new IllegalArgumentException("Room already exists");
                }
            }
            this.name = name;
            Server.addRoom(this);
            synchronized (users){
                this.users.add(moderator);
            }
            synchronized (Server.getUsers()){
                moderator.setCurrentRoom(this.name);
                //update the user state on server
                Server.removeUser(moderator);
                Server.addUser(moderator);
            }
            this.moderator = moderator;
        }
    }

    public void addUser(User user) {
        synchronized (users){
            for (User u : users){
                if (u.getTicket().equals(user.getTicket())){
                    System.out.println(user.getNickname() + " is already in this room");
                    return;
                }
            }
            users.add(user);
        }
    }

    public void removeUser(User user) {
        synchronized (users){
            //delete the room if this is the last user
            if (users.size() == 1){
                System.out.println("Room is now empty, deleting it...");
                synchronized (Server.getRooms()){
                    Server.removeRoom(this);
                    users.clear();
                    return;
                }
            }
            //remove the requested user
            for (User u : users){
                if (u.getTicket().equals(user.getTicket())){
                    users.removeIf((x) -> x.getTicket().equals(u.getTicket()));
                }
            }
            //if the user was a moderator, choose a new one
            if (user.getTicket().equals(moderator.getTicket())){
                System.out.println("Moderator has left, choosing a new one...");
                Random rand = new Random();
                int nextModerator = rand.nextInt(users.size());
                moderator = users.get(nextModerator);
                System.out.println(moderator.getNickname() + " is now the new room moderator for " + name + ".");
            }
        }
    }
}
