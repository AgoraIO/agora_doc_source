# Markdown validation through Schematron or "How to implement quality checks for your Markdown"

## Setup {.section}

Open the **schematron-validation.xpr** project inside the **Project** view.
The project uses `ms-as-dita.sch` and `md-as-html.sch` for Markdown validation.
After opening the project you can go to `Options->Preferences...` on page `Markdown`
to see how the Schematron files are specified.

## Example: Lists {.section}

Ordered lists can be marked up with either number or number sign, followed by a period:

1. A list with just one list item and the wrong ending character;


## Example: Links {.section}

An external link example:

[http://www.example.com/test.html](http://www.example.com/test.html)


## Example: Images {.section}

An image that is missing the reference part:

![Alt]()


## Example: Code {.section}

A code section that contains very long lines:

```
<xsl:value-of select="concat(position(), ' - ', string-length(current()), ', ') "/>
```

## How to develop your own Schematron rules {.section}

The Schematron rules are applied over the Markdown content converted to either HTML or DITA.
You can inspect these formats by invoking the contextual menu inside the preview pages and by 
choosing `Export as DITA Topic` or `Export as HTML`.

After you've written the Schematron rules, go to `Options->Preferences...`, on page `Markdown`,
and add references to the Schematron files. **Note:** it is recommended to use editor variables,
like `${pdu}` to ensure that these paths are portable and will work for anyone working with Oxygen. 
