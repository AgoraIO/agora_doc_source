## Overview

This is a trial project that uses [DITA](https://en.wikipedia.org/wiki/Darwin_Information_Typing_Architecture) and [LwDITA](http://docs.oasis-open.org/dita/LwDITA/v1.0/cnprd01/LwDITA-v1.0-cnprd01.html) to write customer-facing technical documentation.

### Purpose

The primary purpose of this project is to single-source the API documentation so that all platforms of one product line can reuse most of the content.

### Working branches

Currently, we are working on the `dita-cpp` branch. This branch has some example DITA topics and maps for the C++ API Reference of the RTC SDK.
> The `master` branch has the LwDITA files for the Android API Reference.  

### Build output

1. Install [DITA-OT](https://www.dita-ot.org/dev/index.html).
    ```bash
    brew install dita-ot
    ```
    > See [Installing DITA Open Toolkit](https://www.dita-ot.org/dev/topics/installing-client.html) for more information.  
2. Build the documents using the DITA-OT project file.
    ```bash
    dita --project=<path-to-the-project-file>
    ```
    > If you are running the command from the root directory of this project, the path is `config/html-windows.xml` for the C++ API Reference.  

See [Building output](https://www.dita-ot.org/dev/topics/building-output.html) for other building options.

## Tool chain

- Editing: Oxygen XML Editor.
- Output: DITA-OT.
- Peer review: Oxygen XML Editor.
- Technical review: Agora internal doc site (under development).
- Publishing: Agora self-developed CMS (in plan).

## Project structure

The following lists the major folders and files on the `dita-cpp` branch:

- `RTC_API.ditamap`: The DITA map for the C++ API Reference of the RTC SDK.
- `API`: The DITA topics for the API documentation. Each API or class will be a topic.
- `conref`: The DITA topics for conref.
	- `conref_rtc_api.dita`:  The API syntaxes for all the platforms with filtering properties.
- `config`: Configurations for the output.
	- `windows.ditaval`: The filter for Windows.
	- `html-windows.xml`:  The DITA-OT project file to generate HTML output.
	- `keys-rtc-cpp-api.ditamap:` Keys for C++ APIs.
- `out`: The output files.
