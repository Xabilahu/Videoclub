import java.io.*;
import java.util.StringTokenizer;

public class Cambio {

    public static void main(String[] args) {
        try {
            BufferedReader bf = new BufferedReader(new FileReader(args[0]));
            FileWriter fw = new FileWriter(new File(System.getProperty("user.dir") + File.separator + "movie-tags-updated.csv"));
            int idUser = 1;
            String tagAct, tagAnterior = "";
            while(bf.ready()) {
                String s = bf.readLine();
                StringTokenizer st = new StringTokenizer(s, ";");
                tagAct = st.nextToken();
                if (idUser == 29) idUser = 55;
                if (!tagAct.equalsIgnoreCase(tagAnterior)) {
                    s = (idUser++) + ";" + s + "\n";
                    fw.write(s);
                }
                tagAnterior = tagAct;
            }
            bf.close();
            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
