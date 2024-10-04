package antlr4.org.sdmx.vtl;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

@RunWith(Parameterized.class)
public class NegativeTests extends ParserTest {

    private String expression;

    public NegativeTests(String expression) {
        super();
        this.expression = expression;
    }

    @Test
    public void test() {
        try {
            parseVtlString(expression);
            fail("This looks valid: ".concat(expression));
        } catch (Exception e) {
            assertTrue(true);
        }
    }

    @Parameters
    public static Collection<String> expressions() {
        ArrayList<String> data = new ArrayList();
        try {
            // Input file that will be parsed and create VTL expressions delimited by two consecutive new lines
            LineIterator it = FileUtils.lineIterator(new File("src/test/resources/NegativeTests.vtl"), "UTF-8");
            try {
                String vtlExpr = "";
                while (it.hasNext()) {
                    String line = it.nextLine().trim();
                    if (line.equals("") && !vtlExpr.equals("")) {
                        //System.out.println("Adding expression: " + vtlExpr);
                        data.add(vtlExpr);
                        vtlExpr = "";
                    }
                    //append new lines to complete the VTL expression
                    if (!line.equals("")) {
                        vtlExpr = vtlExpr.concat(line).concat("\n");
                    }
                }
            } catch (Exception e) {
                System.err.println(e);
            } finally {
                it.close();
            }
        } catch (Exception e) {
            fail(e.getMessage());
        }
        return data;
    }

    @BeforeClass
    public static void setUpBeforeClass() {
        //System.out.println("Added all VTL expressions successfully!");
    }
}
