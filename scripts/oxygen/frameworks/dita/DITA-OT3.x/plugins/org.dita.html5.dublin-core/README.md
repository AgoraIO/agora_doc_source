# Dublin Core plug-in for DITA-OT HTML5

This plug-in for [DITA Open Toolkit][1] extends the default `html5` transformation to generate additional [metadata][2].

_(Up to version 3.5, DITA-OT includes the [Dublin Core™ Metadata Element Set][3] in both XHTML and HTML5 output.)_

As of DITA-OT 3.6, Dublin Core metadata is no longer generated in the default HTML5 output. 

This plug-in can be installed to add Dublin Core metadata to HTML5 if necessary.

## Compatibility

- DITA-OT 3.6

## Installation

Run the [plug-in installation command][4]:

```shell
dita install org.dita.html5.dublin-core
```

## License

The Dublin Core plug-in is licensed for use under the [Apache License 2.0][5].

[1]: https://github.com/dita-ot/dita-ot
[2]: https://www.dublincore.org/resources/metadata-basics/
[3]: https://dublincore.org/specifications/dublin-core/dcmi-terms
[4]: https://www.dita-ot.org/dev/topics/plugins-installing.html
[5]: https://www.apache.org/licenses/LICENSE-2.0
