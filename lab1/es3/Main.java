import java.io.*;
import java.lang.*;

class Es3 {
    public static void main(String argv[]) {
        if (argv.length == 0) {
            System.out.println("Usage : java Yylex <inputfile>");
        }
        else {
            /* Header html */
            System.out.println("<HTML>");
            System.out.println("<BODY bgcolor = #FFFFFF>");

            for (int i = 0; i < argv.length; i++) {
                /* 1 - Scanner declaration */
                Yylex scanner = null;
                try {
                    /* Write the page title and open the <code> tag */
                    System.out.println("<H2>"+argv[0]+"</H2>");
                    System.out.println("<CODE>");
                    /* 2 - scanner = new Yylex() -> Scanner instantiation using the constructor Yylex()
                       3 - new java.io.FileReader(argv[i]) -> Pass to the scanner the file to be scanned */
                    scanner = new Yylex( new java.io.FileReader(argv[i]) );
                    /* 4 - Scan file until the end of file is reached: in this case
                    function yylex() returns Yylex.YYEOF
                    IMP: The function yylex returns an integer constant because in the .jflex file the directive
                    %integer was used, otherwise yylex returns a class of type YyToken */
                    while ( scanner.yylex() != Yylex.YYEOF );
                    /* Chiude il tag <code> */
                    System.out.println("</CODE>");
                }

                catch (java.io.FileNotFoundException e) {
                    System.out.println("File not found : \"" + argv[i] + "\"");
                }
                catch (java.io.IOException e) {
                    System.out.println("IO error scanning file \"" + argv[i] + "\"");
                    System.out.println(e);
                }
                catch (Exception e) {
                    System.out.println("Unexpected exception:");
                    e.printStackTrace();
                }
            }
            /* Footer Html */
            System.out.println("</BODY>");
            System.out.println("</HTML>");
        }
    }
}
