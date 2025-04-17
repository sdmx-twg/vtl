package antlr4.org.sdmx.vtl;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.sdmx.vtl.VtlLexer;
import org.sdmx.vtl.VtlParser;

public abstract class ParserTest {

    public ParserTest() {
        super();
    }

    protected String parseVtlString(String codeToCheck) throws Exception {
        //For testing validity of expressions
        VtlErrorListener error = new VtlErrorListener();
        CharStream inputString = CharStreams.fromString(codeToCheck);
        VtlLexer lexer = new VtlLexer(inputString);
        lexer.removeErrorListeners();
        lexer.addErrorListener(error);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        VtlParser parser = new VtlParser(tokens);
        parser.removeErrorListeners();
        parser.addErrorListener(error);
        parser.start();
        if (error.flag) {
            throw new Exception(error.toString());
        }

        // Create the tree for comparison tests
        VtlTreeGenerator tree = new VtlTreeGenerator("start");
        return tree.process(codeToCheck, lexer, parser);
    }

}
