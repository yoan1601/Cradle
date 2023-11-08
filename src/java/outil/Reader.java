/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package outil;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author yoan
 */
public class Reader {
    public static ArrayList<String []> getAllIp(String filename) throws Exception {
        ArrayList<String []> serverLines = new ArrayList<>();
//        String filename = "votre_fichier.conf"; // Remplacez "votre_fichier.conf" par le chemin de votre fichier de configuration HAProxy.

        try (BufferedReader br = new BufferedReader(new FileReader(filename)) ) {
            String line;
            boolean insideBackendSection = false;

            while ((line = br.readLine()) != null) {
                line = line.trim();
//                System.out.println("line "+ line + " insideBackendSection && line.startsWith(\"server\") "+ (insideBackendSection && line.startsWith("server")));
                if (line.startsWith("backend myservers")) {
                    insideBackendSection = true;
                } else if (insideBackendSection && line.startsWith("server")) {
                    serverLines.add(line.split(" "));
                } else if (insideBackendSection && line.startsWith("backend")) {
                    break; // Sortie de la section backend
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return serverLines;
    }
}
