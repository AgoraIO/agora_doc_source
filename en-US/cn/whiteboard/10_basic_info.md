This article provides basic information about the   interactive whiteboard RESTful API.

## Domain

All requests are sent to the domain named `api.netless.link`.

## Data format

The Content-Type in all HTTP request headers is `application/json`. All request and responses are in JSON format. All the request URLs and request bodies are case-sensitive.

<div class="alert note">Agora's server for the whiteboard service will allow more data formats but cannot guarantee full compatibility. If all request parameters are filled in correctly but the request still fails, please check the data format of the request.</div>

## Core features

The interactive whiteboard RESTful API provides the following features:

- [Token generation](/cn/whiteboard/generate_whiteboard_token?platform=RESTful)
- [Room Management](/cn/whiteboard/whiteboard_room_management)
- [Screenshot Management](/cn/whiteboard/whiteboard_screenshot)
- [Scene Management](/cn/whiteboard/whiteboard_scene_management)
- [File conversion](/cn/whiteboard/whiteboard_file_conversion)

## Status code

All possible response status codes are listed in the table below:

- If the status code is `200` or `201`, the request is successful.

- If the status code is not `200` or `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

| Response status code | Status | Description |
| :-------------- | :-------------------- | :--------------------------------------------------------- |
| `200` | OK | The request is successful and the server returns the requested data. |
| `201` | Created | The request is successful and the server creates or modifies data. |
| `400` | Invalid request | The user's request has an error, and the server does not create or modify data. |
| `401` | 401 Unauthorized | The user does not have permission (the Token is incorrect). |
| `403` | Forbidden | The user is authorized (contrary to 401), but is denied access. |
| `404` | Not found | The server can not find the requested resource. |
| `500` | Internal server error | The server encounters an error and cannot process the request. |