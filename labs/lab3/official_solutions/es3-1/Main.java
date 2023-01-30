// Reduced C language compiler
// Author: Stefano Scanzio
// Date: match 2011
// Mail: stefano.scanzio@polito.it

import java.io.*;

public class Main {
    static public void main(String argv[]) {    
        try {
			Yylex l = new Yylex(new FileReader(argv[0]));
			parser p = new parser(l);
			Object result;
			if(argv.length == 2)
				if(argv[1].equals("-debug"))
					result = p.debug_parse();
				else
					result = p.parse();
			else
				result = p.parse();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}


