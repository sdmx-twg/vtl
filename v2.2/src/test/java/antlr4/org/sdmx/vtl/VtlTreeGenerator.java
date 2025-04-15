package antlr4.org.sdmx.vtl;

import org.antlr.v4.runtime.*;
import org.sdmx.vtl.VtlLexer;
import org.sdmx.vtl.VtlParser;

import javax.print.PrintException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class VtlTreeGenerator {

    protected String startRuleName;

    public VtlTreeGenerator(String startRule) {
        startRuleName = startRule;
    }

    /**
     * For processing string expressions.
     *
     * @param input the string expression to process
     * @return the textual representation of the tree
     * @throws Exception
     */
    public String process(String input, VtlLexer lexer, VtlParser parser) throws Exception {
        CharStream charStream = CharStreams.fromString(input);
        return process(lexer, null, parser, charStream);
    }


    public String process(Lexer lexer, Class<? extends Parser> parserClass, Parser parser, CharStream input) throws IOException, IllegalAccessException, InvocationTargetException, PrintException {
        lexer.setInputStream(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();

        parser.setBuildParseTree(true);
        parser.setTokenStream(tokens);
//		parser.setTrace(false);

        try {
            Method startRule = parser.getClass().getMethod("start");
            ParserRuleContext tree = (ParserRuleContext) startRule.invoke(parser, (Object[]) null);

            return tree.toStringTree(parser);
        } catch (NoSuchMethodException nsme) {
            System.err.println("No method for rule " + startRuleName + " or it has arguments");
        }
        return null;
    }

}
