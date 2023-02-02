import java.io.*;

public class Main {
	public static void main(String args[]) {
		try {
			scanner s = new scanner(new FileReader(args[0]));
			parser p = new parser(s);
			p.parse();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
