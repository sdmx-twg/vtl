package org.sdmx.vtl;

import static java.lang.System.lineSeparator;
import static java.nio.charset.StandardCharsets.UTF_8;
import static java.util.stream.Collectors.joining;
import static org.antlr.v4.runtime.CharStreams.fromString;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.junit.jupiter.params.provider.Arguments.arguments;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.sdmx.vtl.Vtl.StartContext;

public class GrammarTest
{
	public static List<Arguments> positiveTest() throws IOException, URISyntaxException
	{
		return generateTests("/PositiveTests.vtl");
	}
	
	public static List<Arguments> negativeTest() throws IOException, URISyntaxException
	{
		return generateTests("/NegativeTests.vtl");
	}

	@ParameterizedTest(name = "Line {0}")
	@MethodSource
	public void positiveTest(int lineCount, String buffer, String context) throws Throwable
	{
		ParseResults parseResult = doTest(buffer);
		assertTrue(parseResult.errors().isEmpty(), parseResult.errors()::toString);
		assertNotNull(parseResult.parseTree(), "Parse tree empty");
		if (context != null)
			assertEquals(context, parseResult.parseTree());
		else if (!"Start".equals(parseResult.parseTree()))
		{
			lineCount -= buffer.split(System.lineSeparator()).length - 1;
			fail("Missing parse tree at line " + lineCount + ". The computed parse tree is\n" + parseResult.parseTree());
		}
	}

	@ParameterizedTest(name = "Line {0}")
	@MethodSource
	public void negativeTest(int lineCount, String buffer, String context) throws Throwable
	{
		List<SyntaxError> errors = doTest(buffer).errors();
		assertFalse(errors.isEmpty(), "Expected test to fail at line " + lineCount);
	}

	private static List<Arguments> generateTests(String file) throws IOException, URISyntaxException
	{
		List<Arguments> args = new ArrayList<>();
		
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(GrammarTest.class.getResourceAsStream(file), UTF_8)))
		{
			String line;
			int lineCount = 0;
			String buffer = "";
			while ((line = reader.readLine()) != null)
			{
				if (!line.trim().isEmpty())
				{
					buffer += line + System.lineSeparator();
					lineCount++;
				}
				else if (!buffer.matches("(\r?\n| )*"))
				{
					String expectedTree = null;
					String trimmed = buffer.stripLeading();
					if (trimmed.startsWith("## "))
					{
						String[] split = trimmed.split(System.lineSeparator(), 2);
						expectedTree = split[0].substring(3);
						buffer = buffer.substring(0, buffer.length() - trimmed.length()) + lineSeparator() + split[1];
					}
					
					args.add(arguments(lineCount, buffer, expectedTree));
					
					lineCount++;
					char[] emptyLines = new char[lineCount];
					Arrays.fill(emptyLines, '\n');
					buffer = new String(emptyLines);
				}
				else
				{
					lineCount++;
					buffer += System.lineSeparator();
				}
			}

			// Check last example too
			String context = null;
			String trimmed = buffer.stripLeading();
			if (trimmed.startsWith("## "))
			{
				String[] split = trimmed.split(System.lineSeparator(), 2);
				context = split[0].substring(3);
				buffer = buffer.substring(0, buffer.length() - trimmed.length()) + lineSeparator() + split[1];
			}
			
			args.add(arguments(lineCount, buffer, context));
		}
		
		return args;
	}
	
	private static ParseResults doTest(String buffer) 
	{
		VtlTokens lexer = new VtlTokens(fromString(buffer));
		Vtl parser = new Vtl(new CommonTokenStream(lexer));
		SyntaxErrorListener listener = new SyntaxErrorListener();
		lexer.addErrorListener(listener);
		parser.addErrorListener(listener);
		StartContext start = parser.start();
		
		List<SyntaxError> errors = listener.getSyntaxErrors();
		return new ParseResults(errors, buildTree(start));
	}

	private static String buildTree(ParserRuleContext ctx)
	{
		List<ParserRuleContext> children  = ctx.getRuleContexts(ParserRuleContext.class);
		String simpleName = ctx.getClass().getSimpleName().replace("Context", "");
		
		return children.isEmpty() ? simpleName : children.stream()
			.map(GrammarTest::buildTree)
			.collect(joining(" ", simpleName + "[", "]"));
	}
}
