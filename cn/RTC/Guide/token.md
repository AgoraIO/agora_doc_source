
# Authenticate Your Users with Tokens  

To enhance communication security, Agora uses tokens to authenticate users before they access the Agora serivce, such as joining an RTC channel or logging onto the RTM system. 

This article describes how to generate a token and use it for authentication in your client app when a user tries to access the Agora service.

##  Understand the tech   

A token is a dynamic key generated on your server. Agora provides code samples on GitHub for you to generate tokens.

When your app users tries to access the Agora service, Agora validates their token and grant access according to the following information in the token:
- The App ID of your Agora project
- The app certificate of your Agora project
- The channel name
- The user ID of the user to be authenticated
- The privilege of the user
- The expiration time of the token

Tokens expire. A token is valid for 24 hours at most. You need to regularly generate new tokens to keep users connected.

Agora supports specifying the privilege of a user in the token. For example, a user with the privilege of subscriber can only subscribe to streams, but not publish streams. See [How do I use co-host token authentication?](https://docs.agora.io/en/Interactive%20Broadcast/faq/token_cohost) for details.

The following figure shows the steps in the authentication flow:

![token authentication flow](https://web-cdn.agora.io/docs-files/1618379347094)

## Prerequisites

In order to follow this procedure you must have:

1. A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).
1. An Agora project with the [app certificate](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms#manage-your-app-certificates) enabled.

## Implement the authentication flow

This section shows you how to supply and consume a token that gives rights to specific functionality to authenticated users

### Generate a token

The documentation in this section should be an explanation on how to click https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs and have a running server. 

COMMENT: Rewrite the docs in https://heroku.com/deploy?template=https://github.com/AgoraIO-Community/TokenServer-nodejs to match what is written here. 

This code example is not production ready, to generate your own token and integrate it in your security infrastructure, follow the documentation in https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey.

COMMENT: All the docs in https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey must be rewritten. Each language must have a single page procedure like this one explaining how to implement the code. The https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey landing page has to be rewritten in to something useful with links to the implementations.

COMMENT: For https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey, the title is AgoraDynamicKey. Do you mean Agora Dynamic Key, or are you referring to an Access Token or a token. Let's use one term here. 

### Grant user rights in your app base on token credentials

COMMENT: this title is probably using incorrect terminology for tokens. 

COMMENT: may need a couple of intro sentences here. 

To implement the client side of the authentication flow in your app:

1. Do something. 
1. Do something else.

## Test the authentication flow

COMMENT: Explain how to easily test the authentication server and client the user has just implemented.

1. Do this
1. Do that
1. You get the idea
1. Get the reader to login using incorrect credentials to show that users are kept out. 

Yay, it works. 


## Reference

The parameters used in this procedure are:

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Default</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>shakespeare</td>
    <td>job</td>
    <td>playwright</td>
    <td>

Set `shakespeare` to `poet` to enable the sonnet writing functionality for this instance.

Possible values are:

* `actor` - someone who pretends to be someone else while performing in a film, play, or television or radio programme.
* `director` - a person who is in charge of a film or play and tells the actors how to play their parts.
* `impresario` - a person who arranges different types of public entertainment, such as theatre, musical, and dance events.
* `playwright` - a person who writes [plays](https://en.wikipedia.org/wiki/Play_(theatre)).
* `poet` - a person who writes [poems](https://en.wikipedia.org/wiki/Poetry). 

</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>


