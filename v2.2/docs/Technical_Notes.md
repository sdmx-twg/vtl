# Contents
1. [Introduction](#introduction)
2. [Error Messages](#error-messages)
3. [Serialization of VTL artifacts](#serialization-of-vtl-artifacts)
4. [VTL web services](#vtl-web-services)

# Introduction

## Guidelines version

These technical guidelines address implementation issues for VTL standard version 2.1.

These guidelines are meant to facilitate developers of VTL tools (engines, interpreters, 
translators...) in order to make implementation of such tools easier and speedier.

For such reasons, these guidelines may frequently change in order to accomodate various
issues that implementors bring to the attention of the VTL task force.

# Error messages

VTL error messages are categorized by one or two numbers, separated by a dash. The first number
assigns the error message to one of the general categories. The second number, when indicated, 
assigns the error message to a group inside each category. VTL engine implementations may use
any number of additional levels; the meaning of additional classification levels beyond those
listed in this document is implementation dependent.

The taxonomy of categories (first level) is as follows:

1. Syntax errors
2. Semantic errors
3. Runtime errors

## Error message examples

This section provides a list of template examples for specific error messages. The templates
can be parameterized in order to include information about an actual error. The list is not
intented to be exhaustive, and additional categories may be added at a later time.

VTL engine implementations may choose to override any template definition and the textual
representation of any eventual parameter in each template.

Abbreviations are used in the template to signify specific VTL language elements, as follows:

| Placeholder | Meaning                                                                              |
|-------------|--------------------------------------------------------------------------------------|
| `%c`        | A component (represented with name, role and valuedomain)                            |
| `%r`        | The role of a component (component, identifier, measure, attribute, viral attribute) |
| `%d`        | A valuedomain or valuedomain subset                                                  |
| `%s`        | A data structure or set of unique components                                         |
| `%n`        | A name of a dataset, component, ruleset or user-defined operator                     |
| `%o`        | A VTL operator's name or operator group's name                                       |
| `%v`        | A VTL scalar or component runtime value                                              |

### Syntax errors

A syntax error happens when the VTL script does not exactly match the VTL grammar. Since the syntax check
of the VTL script is usually delegated to a generated parser tool, these errors are directly provided 
by the tool that generates the parser.

These errors prevent the VTL script from being semantically analyzed and should be not present in any one 
VTL script that is going to be committed to be used in production.

Since the grammar is written using the ANTLR4 parser generator syntax, it has become a common choice to
to use this tool to generate the parser for the target language used by a specific VTL engine implementation.
Any possible syntax error raised by the parser is documented at the official
[ANTLR4 documentation web site](https://github.com/antlr/antlr4/blob/master/doc/index.md).
    
### Semantic errors

A semantic error happens when the VTL script is incompatible with the structures or the datasets
referenced; an example is a value from a domain that is incompatible with the component it is
assigned to.

<table>
    <tr></tr>
    <tr>
        <th>Group</th>
        <th>Description</th>
        <th>Template examples</th>
    </tr>
    <tr></tr>
    <tr>
        <td>1</td>
        <td>Expected exactly one component of a given role and/or domain</td>
        <td><pre>Required&nbsp;exactly&nbsp;one&nbsp;%r&nbsp;of&nbsp;domain&nbsp;%d,&nbsp;but&nbsp;found:&nbsp;%s
Required&nbsp;exactly&nbsp;one&nbsp;%r,&nbsp;but&nbsp;found:&nbsp;%s</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>2</td>
        <td>Components of a given role and/or domain are not present in a structure</td>
        <td><pre>Required&nbsp;at&nbsp;least&nbsp;one&nbsp;%r&nbsp;of&nbsp;domain&nbsp;%d,&nbsp;but&nbsp;found:&nbsp;%s
Required&nbsp;at&nbsp;least&nbsp;one&nbsp;%r,&nbsp;but&nbsp;found:&nbsp;%s</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>3</td>
        <td>One or more components were requested but are not present</td>
        <td><pre>Component&nbsp;%n&nbsp;not&nbsp;found&nbsp;in&nbsp;%s
Components&nbsp;%n,&nbsp;%n,&nbsp;%n...&nbsp;not&nbsp;found&nbsp;in&nbsp;%s</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>4</td>
        <td>Identifiers must be invariant</td>
        <td><pre>%o&nbsp;cannot&nbsp;change&nbsp;identifiers&nbsp;%s
%o&nbsp;cannot&nbsp;change&nbsp;identifier&nbsp;%n&nbsp;to&nbsp;a&nbsp;%r
%o&nbsp;cannot&nbsp;change&nbsp;%c&nbsp;to&nbsp;an&nbsp;identifier
%o&nbsp;cannot&nbsp;change&nbsp;identifiers&nbsp;from&nbsp;%s&nbsp;to&nbsp;%s</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>5</td>
        <td>Named components are not present in a structure</td>
        <td><pre>Components&nbsp;named&nbsp;%n,&nbsp;%n,&nbsp;...&nbsp;not&nbsp;found&nbsp;in&nbsp;%s
Component&nbsp;named&nbsp;%n&nbsp;not&nbsp;found&nbsp;in&nbsp;%s
Components&nbsp;%s&nbsp;not&nbsp;found&nbsp;in&nbsp;%s
Component&nbsp;%c&nbsp;not&nbsp;found&nbsp;in&nbsp;%s</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>6</td>
        <td>An undefined name is used in an expression</td>
        <td><pre>Name&nbsp;%n&nbsp;is&nbsp;not&nbsp;bound&nbsp;to&nbsp;this&nbsp;transformation&nbsp;scheme
In&nbsp;%o,&nbsp;name&nbsp;%n&nbsp;is&nbsp;not&nbsp;defined</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>7</td>
        <td>Operator parameters or results have mismatched domains</td>
        <td><pre>Incompatible&nbsp;types&nbsp;in&nbsp;%o:&nbsp;%c&nbsp;and&nbsp;%c
Incompatible&nbsp;types&nbsp;in&nbsp;%o:&nbsp;%c&nbsp;and&nbsp;%d
Incompatible&nbsp;types&nbsp;in&nbsp;%o:&nbsp;%d&nbsp;and&nbsp;%c
Incompatible&nbsp;types&nbsp;in&nbsp;%o:&nbsp;%d&nbsp;and&nbsp;%d</pre></td>
    </tr>
</table>

### Runtime errors

A runtime error happens during the processing of invalid data or when performing an illegal
operation, i.e. division by 0 or casting errors, square root or logarithm of negative numbers.

<table>
    <tr></tr>
    <tr>
        <th>Group</th>
        <th>Description</th>
        <th>Template examples</th>
    </tr>
    <tr></tr>
    <tr>
        <td>1</td>
        <td>Casting a scalar value or component to a invalid type</td>
        <td><pre>Cannot&nbsp;cast&nbsp;%v&nbsp;of&nbsp;%d&nbsp;to&nbsp;valuedomain&nbsp;%d
Component&nbsp;%n&nbsp;cannot&nbsp;accept&nbsp;a&nbsp;value&nbsp;of&nbsp;%v</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>2</td>
        <td>Mismatching user-defined operator parameters and arguments</td>
        <td><pre>Argument&nbsp;%v&nbsp;of&nbsp;type&nbsp;%d&nbsp;does&nbsp;not&nbsp;match&nbsp;parameter&nbsp;%n</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>3</td>
        <td>Error reading data from a source</td>
        <td><pre>Error&nbsp;fetching&nbsp;data&nbsp;contents&nbsp;of&nbsp;%n</pre></td>
    </tr>
    <tr></tr>
    <tr>
        <td>4</td>
        <td>Platform-related error</td>
        <td><pre>A&nbsp;system&nbsp;error&nbsp;occurred:&nbsp;message</pre></td>
    </tr>
</table>

# Serialization of VTL artifacts

Sometimes there may be a need to exchange VTL artifacts when operating in H2M or M2M mode.
This section defines a JSON schema that aims to provide an easy implementation of this 
serialization mechanism.

The schema encompasses all VTL artifacts included in the VTL User Manual section "Generic Model
for Variables and Value domains". VTL engines may not implement this specific scheme and/or
they may provide support for alternative or extended serialization schemes. All of the four
sections of the JSON schema are optional if the implementation does not require them.

## JSON scheme for VTL metadata

```json
{
    "$schema": "https://json-schema.org/draft/2020-12/schema",
    "description": "VTL Metadata JSON serialization",
    "$defs": {
        "vtl-id": {
            "type": "string",
            "pattern": "^[a-zA-Z][a-zA-Z0-9_]*$|^'.*'$"
        },
        "set-type": {
            "type": "array",
            "uniqueItems": true,
            "oneOf": [
                { "items": { "oneOf": [ { "type": "string" }, { "type": "null" } ] } },
                { "items": { "oneOf": [ { "type": "number" }, { "type": "null" } ] } }
            ]
        },
        "identifiable": {
            "type": "object",
            "properties": {
                "name": { "$ref": "#/$defs/vtl-id" },
                "description": { "type": "string" }
            },
            "required": [ "name" ]
        }
    },
    "type": "object",
    "properties": {
        "data": {
            "type": "array",
            "items": {
                "allOf": [ { "$ref": "#/$defs/identifiable" } ],
                "properties": {
                    "source": { "type": "string" }
                    "structure": { "$ref": "#/$defs/vtl-id" },
                    "valuedomain": { "$ref": "#/$defs/vtl-id" },
                },
                "required": [ "metadata" ],
                "oneOf": [
                    { "required": [ "structure" ] },
                    { "required": [ "valuedomain" ] }
                ]
            }
        },
        "structures": {
            "type": "array",
            "items": {
                "allOf": [ { "$ref": "#/$defs/identifiable" } ],
                "properties": {
                    "components": {
                        "type": "array",
                        "items": {
                            "allOf": [ { "$ref": "#/$defs/identifiable" } ],
                            "properties": {
                                "role": {
                                    "type": "string",
                                    "enum": [ "Identifier", "Measure", "Attribute", "Viral Attribute" ]
                                },
                                "subset": { "$ref": "#/$defs/vtl-id" },
                                "nullable": { "type": "boolean" },
                                "data_type": {
                                    "type": "string",
                                    "enum": [ "String", "Number", "Integer", "Boolean", "Time", "TimePeriod", "Date", "Duration" ]
                                }
                            },
                            "required": [ "role" ]
                        }
                    }
                },
                "required": [ "components" ]
            }
        },
        "variables": {
            "type": "array",
            "items": {
                "allOf": [ { "$ref": "#/$defs/identifiable" } ],
                "properties": {
                    "domain": { "$ref": "#/$defs/vtl-id" }
                },
                "required": [ "domain" ]
            }
        },
        "domains": {
            "type": "array",
            "items": {
                "allOf": [ { "$ref": "#/$defs/identifiable" } ],
                "unevaluatedProperties": false,
                "oneOf": [
                    {
                        "properties": {
                            "externalRef": { "type": "string" }
                        },
                        "required": [ "externalRef" ]
                    }, {
                        "properties": {
                            "parent": { "$ref": "#/$defs/vtl-id" }
                        },
                        "required": [ "parent" ],
                        "oneOf": [{
                                "properties": {
                                    "restriction": { "$ref": "#/$defs/set-type" }
                                },
                                "required": [ "restriction" ]
                            }, {
                                "properties": {
                                    "enumerated": { "$ref": "#/$defs/set-type" }
                                },
                                "required": [ "enumerated" ]
                            }, {
                                "properties": {
                                    "described": { "type": "string" }
                                },
                                "required": [ "described" ]
                            }
                        ]
                    }
                ]
            }
        }
    }
}
```

# VTL web services

This chapter describes guidelines for implementors of web service applications providing access
to VTL engines, or VTL engines exposing web services.

## Architecture

A VTL engine may expose a set of web services, or an application layer may support interoperability
with a VTL engine instance located elsewhere. In the latter case, the web service may use any 
technology supported by the engine instance, such as JSON-RPC or CORBA, to transfer control between
the engine and the application layer.

A VTL web service implementation should provide ways to load VTL data, perform execution of a scheme 
and retrieve the results.

The payload and the results of calls to a VTL web service (where applicable) should be encoded in UTF-8
without the byte-order mark (BOM).

## Storage

Web services implementations may choose to rely on external storage technology in order to provide
data to the submitted request. Web services implementations may additionally support user storage of 
VTL artifacts. In this case any details regarding how to achieve this, and the list of required HTTP 
endpoints, are left to each implementation and must be documented. 

Web services implementations should be able to map VTL aliases used in the submitted program to specific
data sources, either internal or external.

## Security

Security must be implemented when the web service implementation requires an user context in order to 
process the submitted VTL program. In this case, the web application container must be configured to
forward the authentication token to the web service, or the application must support an authentication
and authorization mechanism, such as Basic or Negotiate. HTTP headers should be used to provide those
tokens.

Encryption of communication between the user and the web service should be enforced by deploying 
the implementation behind a reverse proxy or on an application server that is configured to 
provide a X509 certificate with the https:// protocol.
