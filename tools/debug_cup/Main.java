import java.io.*;

public class Main {
    static public void main(String argv[]) {
        Yylex l = new Yylex(new FileReader(file));
        parser p = new parser(l);
        Object result = p.debug_parse();Yylex l = new Yylex(new FileReader(file));
        parser p = new parser(l);
        Object result = p.debug_parse();
    }
}
