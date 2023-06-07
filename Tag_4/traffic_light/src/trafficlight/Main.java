package trafficlight;

public class Main {

    public static void main(String[] args) throws InterruptedException {

        String[] ampelPhasen = {"red", "red-yellow", "yellow", "green"};

        while (true) {
            for (String s : ampelPhasen) {
                System.out.println(s);
                Thread.sleep(1000);
            }
        }
    }
}


