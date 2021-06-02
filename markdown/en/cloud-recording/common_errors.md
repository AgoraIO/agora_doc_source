---
title: Common Errors
platform: All Platforms
updatedAt: 2020-10-23 17:09:34
---
This article lists the common errors you may encounter when using the Cloud Recording RESTful APIs. If you encounter other errors, contact support@agora.io.

- `2`: Invalid parameter. Possible reasons:
	- A parameter's data type is wrong.
	- A parameter is spelt wrong. All the parameters are case sensitive.
	- A parameter value is out of range.
	- A mandatory parameter is missing.
  
- `7`: The recording is already running. Do not repeat the `start` request with the same resource ID.
- `8`: Errors in the HTTP request header fields. Possible reasons:
  - Content-type is wrong. Ensure that the `Content-type` field is `application/json;charset=utf-8`.
  - `cloud_recording` is missing in the request URL.
  - The HTTP method is wrong.
  - The request is not valid JSON
- `49`: Caused by repeated `stop` requests with the same resource ID and recording ID (sid).
- `53`: The recording is already running. This error occurs when you use the same parameters to call `acquire` again and use the new resource ID in the `start` request. To start multiple recording instances, use a different UID for each instance.
- `62`: If you receive this error when calling `acquire`, the cloud recording service is not enabled. See [Enable Cloud Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_rest#enable-cloud-recording) for details.
- `65`: Usually caused by network jitter. Try again with the same resource ID.
- `432`: The parameter in the request is incorrect. Either the parameter is invalid, or the App ID, channel name, or UID does not match the resource ID.
- `433`: The resource ID has expired. You need to start recording within five minutes after getting a resource ID. Call acquire to get a new resource ID.
- `435`: No recorded files created. There is nothing to record because no user is sending any stream in the channel.
- `501`: The recording service is exiting. This error might occur when you call query after stop.
- `1001`: Fails to parse the resource ID. Call acquire to get a new resource ID.
- `1003`: The App ID or recording ID (sid) does not match the resource ID. Ensure that the App ID or recording ID matches the resource ID in each recording session.
- `1013`: The channel name is invalid. The string length must be less than 64 bytes. Supported character scopes are:
  - All lowercase English letters: a to z.        
  - All uppercase English letters: A to Z.
  - All numeric characters: 0 to 9.
  - The space character.
  - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
- `1028`: Invalid parameters in the request body of the `updateLayout` method.
- `"invalid appid"`: The App ID you entered is invalid. If the error persists after you verify the App ID, contact [support@agora.io](mailto:support@agora.io).
- `"no Route matched with those values"`: A possible reason for this message is that you entered an incorrect HTTP method in your request, such as using GET when it should have been POST. Another possible reason is that you sent your request to a wrong URL.
- `"Invalid authentication credentials"`: The following list contains possible reasons for this message. If the error persists after you correct the following issues, contact [support@agora.io](mailto:support@agora.io):
  - The Customer ID or Customer Certificate you entered is incorrect.
  - The cloud recording service is not enabled. See [Enable Cloud Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_rest#enable-cloud-recording) for details.
  - HTTP header contains incorrect information. For example, `Basic` is missing in the `Authorization` field.
  - HTTP header contains incorrectly formatted content. For example, the capitalization is wrong or there is an unnecessary space in the `Content-type` field. The correct value is `application/json;charset=utf-8`.