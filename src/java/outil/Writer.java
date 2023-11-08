/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package outil;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author yoan
 */
public class Writer {
    public static boolean removeServerLine(String designation, String ip, String filename) {
        List<String> configLines = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            String line;
            boolean insideBackendSection = false;

            while ((line = br.readLine()) != null) {
                if (line.startsWith("backend myservers")) {
                    insideBackendSection = true;
                }

                if (insideBackendSection && line.contains(designation) && line.contains(ip)) {
                    // Ne pas ajouter la ligne à la liste, c'est ainsi que nous la supprimons.
                } else {
                    configLines.add(line);
                }

//                if (insideBackendSection && line.startsWith("backend")) {
//                    break; // Sortir de la section backend
//                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // Écrire les lignes restantes dans le fichier
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filename))) {
            for (String configLine : configLines) {
                bw.write(configLine);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
    
    public static void ajouterNoeud(String filename, String designation, String ip) throws Exception {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filename, true))) {
            String configLine = "        server "+designation+" "+ip;
            bw.write(configLine);
            bw.newLine();
        }
    }
}
