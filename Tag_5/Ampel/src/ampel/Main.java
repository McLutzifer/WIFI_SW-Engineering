package ampel;

public class Main {

    public static void main(String[] args) throws InterruptedException {

        String[] color_Ampel = {"rot", "rot-gelb", "gelb", "gruen"};

        while (true) {
            for (String color : color_Ampel) {
                System.out.println("Ampel 1 zeigt " + color);
                switch (color) {
                    case "rot" -> Thread.sleep(2000);
                    case "rot-gelb" -> Thread.sleep(2000);
                    case "gelb" -> Thread.sleep(2000);
                    case "gruen" -> Thread.sleep(2000);
                }
            }
        }
    }
}
