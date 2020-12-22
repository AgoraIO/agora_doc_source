## Overview

This is a trial project that uses [DITA](https://en.wikipedia.org/wiki/Darwin_Information_Typing_Architecture) and [LwDITA](http://docs.oasis-open.org/dita/LwDITA/v1.0/cnprd01/LwDITA-v1.0-cnprd01.html) to write customer-facing technical documentation.

### Purpose

The primary purpose of this project is to single-source the API documentation so that all platforms of one product line can reuse most of the content.

### Working branches

- The `master` branch has the master ditamap for RTC API reference, and sub maps for each platform.  
- The `dita-cpp` branch. This branch has some example DITA topics and maps for the C++ API Reference of the RTC SDK.

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

## Toolchain

- Editing: Oxygen XML Editor.
- Output: DITA-OT.
- Peer review: Oxygen XML Editor.
- Technical review: Agora internal doc site (under development).
- Publishing: Agora self-developed CMS (in plan).

## Project structure

The following figure shows the overall structure:
![](https://web-cdn.agora.io/docs-files/1608626365393)

Details:

- RTC APIs for Reuse: This topic contains the API syntaxes for all platforms. It is conrefed in each API topic with a platform filter.

- Windows API ditamap
  - Keys RTC C++ API: Key definitions of API names for C++.

  - windows.ditaval: Include the Windows platform only.

  - Relations

    - Method-Class relationship table: Classes need to have related methods.

    - Method-Callback relationship table: Methods and callbacks have bidirectional relationship.

    - API-feature relationship table: Group APIs by feature.

  - API topics

- Ditamaps for other platforms
