# Manage User Attributes

User attributes refer to the information specific to a user, including nickname, avatar, age, and mobile phone number. Managing user attributes in a real-time chat session enables you to set and retrieve the information of a specified user or the specified users.

This page shows how to implement managing user attributes in your app by using the Agora Chat SDK.

> To manage user attributes, you need to store the user information in the Agora Chat server. If you are not comfortable with this, we recommend you managing user attributes yourself. 

## Understand the tech

The Agora Chat SDK uses a `UserInfo` class to set the various attributes of a specified user, including the user ID, nickname, avatar, signature, phone number, Email address, and gender.

To update the user attributes, you can use the `UserInfoManager` class, which enables you to retrieve and update the user attributes of a specified user, or a particular user attribute of many specified users.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities]().
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attributes in an app. For details, see [Known limitations]().

## Implement managing user attributes

This section shows how to set, retrieve, and update user attributes with the methods provided by the Agora Chat SDK.

## Reference