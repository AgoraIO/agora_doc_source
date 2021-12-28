## Overview

back end

This is a trial project that uses [DITA](https://en.wikipedia.org/wiki/Darwin_Information_Typing_Architecture) and [LwDITA](http://docs.oasis-open.org/dita/LwDITA/v1.0/cnprd01/LwDITA-v1.0-cnprd01.html) to write customer-facing technical documentation.

### Purpose

The primary purpose of this project is to single-source the API documentation so that all platforms of one product line can reuse most of the content.

### Working branches

-   The `master` branch has the master ditamap for RTC API reference, and sub maps for each platform.
-   The `dita-cpp` branch. This branch has some example DITA topics and maps for the C++ API Reference of the RTC SDK.

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

-   Editing: Oxygen XML Editor.
-   Output: DITA-OT.
-   Peer review: Oxygen XML Editor.
-   Technical review: Agora internal doc site (under development).
-   Publishing: Agora self-developed CMS (in plan).

## Project structure

The following lists the major folders and files:

-   `RTC_API.ditamap`: The master DITA map for the RTC API Reference of all platforms.
-   `API`: The DITA topics for the API documentation. Each API or class will be a topic.
-   `conref`: The DITA topics for conref.
    -   `conref_rtc_api.dita`: The API syntaxes for all the platforms with filtering properties.
-   `config`: Configurations for the output.
    -   `.ditaval`: The filter files for each platform.
    -   `.xml`: The DITA-OT project file to generate output.
    -   `keys-rtc-cpp-api.ditamap:` Keys for C++ APIs.
    -   `relations.ditamap`: The DITA map that define the relationship between API topics.
-   `out`: The output files.
-   `templates`: The DITA topic templates. Copy the files to the `templates` folder in the Oxygen installation directory to use the templates.

## DITA map structure

The following figure shows the overall structure of the RTC_API.ditamap:
![DITA map structure](https://web-cdn.agora.io/docs-files/1608626365393)

Details:

-   RTC APIs for Reuse: This topic contains the API syntaxes for all platforms. It is conrefed in each API topic with a platform filter.

-   Windows API DITA map

    -   Keys RTC C++ API: Key definitions of API names for C++.

    -   windows.ditaval: Include the Windows platform only.

    -   Relations

        -   Method-Class relationship table: Classes need to have related methods.

        -   Method-Callback relationship table: Methods and callbacks have bidirectional relationship.

        -   API-feature relationship table: Group APIs by feature.

    -   API topics

-   DITA maps for other platforms

last-mile

lastmile
