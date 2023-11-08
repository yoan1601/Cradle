<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="outil.Reader" %>
<%@ page import="java.util.ArrayList" %>

<%
    ArrayList<String []> allIp = Reader.getAllIp("/etc/haproxy/haproxy.cfg");
    String ipAddress = "192.168.69.69"; // Remplacez par l'adresse IP que vous souhaitez pinguer.
    
    ArrayList<String> listeStatus = new ArrayList<>();
//    String status = "`<i class='bx bx-no-entry me-1'></i>`";
    String status = "false";

    for(int i = 0; i < allIp.size(); i++) { 
        status = "false";
        ipAddress = allIp.get(i)[2].split(":")[0];
        try {
            InetAddress address = InetAddress.getByName(ipAddress);
            if (address.isReachable(5000)) {
//                status = "`<i class='bx bx-check-circle me-1'></i>`";
                status = "true";
            }
            listeStatus.add(status);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

//    out.print(status);
    out.print(listeStatus);
%>
