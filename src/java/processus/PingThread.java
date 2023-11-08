package processus;

import java.io.IOException;
import java.net.InetAddress;

public class PingThread extends Thread {
    private String ipAddress;

    public PingThread(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public boolean ping() {
        try {
            InetAddress address = InetAddress.getByName(ipAddress);
            if (address.isReachable(2000)) {
                System.out.println("IP atteignable : " + ipAddress);
                return true;
            } 
            System.out.println("IP non atteignable : " + ipAddress);
            return false;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void run() {
        ping();
    }
}