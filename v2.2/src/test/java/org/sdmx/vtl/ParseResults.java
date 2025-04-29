package org.sdmx.vtl;

import java.util.List;

public record ParseResults(List<SyntaxError> errors, String parseTree) {

}
