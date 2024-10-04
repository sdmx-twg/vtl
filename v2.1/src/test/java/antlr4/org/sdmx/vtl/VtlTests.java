package antlr4.org.sdmx.vtl;

import org.junit.Test;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class VtlTests extends ParserTest {

    @Test
    public void testTheExpression() {
        String expression = "ds_1 := abs(ds_2);";
        try {
            parseVtlString(expression);
        } catch (Exception e) {
            fail("Could not parse expression: " + expression + "\n" + e);
        }
    }

    @Test
    public void testTheTree() {
        String expression = "A := B + C * D;";
        String correctTree = "(start (statement (varID A) := (expr (expr (exprAtom (ref (varID B)))) "
                + "+ (expr (expr (exprAtom (ref (varID C)))) * (expr (exprAtom (ref (varID D))))))) "
                + "; <EOF>)";
        try {
            String theTree = parseVtlString(expression);
            if (!theTree.equals(correctTree)) {
                fail("Tree not as expected!\nThe tree was: " + theTree + "\n..instead of: " + correctTree);
            }
        } catch (Exception e) {
            fail("Could not parse expression: " + expression);
        }
    }

    @Test
    public void testTheError() {
        String wrongExpression = "A := B A + C * D;";
        try {
            parseVtlString(wrongExpression);
            fail("This looks valid: ".concat(wrongExpression));
        } catch (Exception e) {
            assertTrue(true);
        }
    }

}
