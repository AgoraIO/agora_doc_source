## Get data for pop-up quizzes

#### Prototype

- Method: GET
- Request path: /edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/popupQuiz/sequences

#### Request parameters

**URL parameters**

Pass the following parameters in the URL:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId`    | String | (Required) Agora App ID.                                     |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. |

**Query parameters**

| Parameter | Type    | Description                                                  |
| :-------- | :------ | :----------------------------------------------------------- |
| `nextId`  | String  | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |
| `count`   | Integer | (Optional) The number of pieces of data in this batch. The default value is 100. |

#### Response parameters

The fields returned in `data` vary in different situations.

- After the teacher clicks the Start button to start a quiz, the summarized data of the Pop-up Quiz widget updates. `data` contains the following fields:

  | Field name                                 | Type     | Description                                                  |
  | :----------------------------------------- | :------- | :----------------------------------------------------------- |
  | action                                     | Integer  | The action type                                              |
  | changeProperties                           | Object   | The changed properties                                       |
  | changeProperties.extra                     | Object   | The extra information of the changed properties              |
  | changeProperties.extra.correctItems        | Object[] | The correct choice                                           |
  | changeProperties.extra.correctCount        | Integer  | The number of students who have made the correct choice      |
  | changeProperties.extra.answerState         | Integer  | The status of this quiz:<ul><li>`1` : In progress</li><li>`0`: Ended</li></ul> |
  | changeProperties.extra.receiveQuestionTime | Long     | The time when the students receive the question              |
  | changeProperties.extra.popupQuizId         | String   | The question ID                                              |
  | changeProperties.extra.averageAccuracy     | Float    | The rate at which the correct choice is made for this question |
  | changeProperties.extra.totalCount          | Integer  | The total number of students who have submitted their answers to this question |
  | changeProperties.extra.items               | Object[] | The options of this question                                 |
  | changeProperties.state                     | Integer  | The state of the Pop-up Quiz widget:<ul><li>`0`: Inactive</li></li>`1`: Active</li></ul> |
  | cause                                      | String   | The reason for the property change                           |
  | operator                                   | Object   | The operator of the property change                          |
  | operator.userUuid                          | String   | The ID of the operator                                       |
  | operator.userName                          | String   | The name of the operator                                     |
  | operator.role                              | String   | The role of the operator                                     |

- After a student submits the answer, the student's data updates. `data` contains the following fields:

  | Field name                      | Type     | Description                                            |
  | :------------------------------ | :------- | :----------------------------------------------------- |
  | action                          | Integer  | The action type                                        |
  | changeProperties                | Object   | The changed properties                                 |
  | changeProperties.lastCommitTime | Long     | The last submit time                                   |
  | changeProperties.popupQuizId    | String   | The question ID                                        |
  | changeProperties.selectedItems  | Object[] | The answer submitted by this student                   |
  | changeProperties.isCorrect      | Boolean  | Whether the answer submitted by the student is correct |
  | cause                           | String   | The reason for the property change                     |
  | operator                        | Object   | The operator of the property change                    |
  | operator.userUuid               | String   | The ID of the operator                                 |
  | operator.userName               | String   | The name of the operator                               |
  | operator.role                   | String   | The role of the operator                               |
  | fromUser                        | Object   | The user who starts this quiz                          |
  | fromUser.userUuid               | String   | The ID of the user who starts this quiz                |
  | fromUser.userName               | String   | The name of the user who starts this quiz              |
  | fromUser.role                   | String   | The role of the user who starts this quiz              |

- After a student submits the answer, the summarized data of the Pop-up Quiz widget updates. `data` contains the following fields:

  | Field name                             | Type    | Description                                                  |
  | :------------------------------------- | :------ | :----------------------------------------------------------- |
  | action                                 | Integer | The action type                                              |
  | changeProperties                       | Object  | The changed properties                                       |
  | changeProperties.extra                 | Object  | The extra information of the changed properties              |
  | changeProperties.extra.selectedCount   | Integer | The number of students who have submitted their answers      |
  | changeProperties.extra.correctCount    | Integer | The number of students who have made the correct choice      |
  | changeProperties.extra.averageAccuracy | Float   | The rate at which the correct choice is made for this question |
  | changeProperties.extra.totalCount      | Integer | The total number of students who have submitted their answers to this question |
  | cause                                  | String  | The reason for the property change                           |
  | operator                               | Object  | The operator of the property change                          |
  | operator.userUuid                      | String  | The ID of the operator                                       |
  | operator.userName                      | String  | The name of the operator                                     |
  | operator.role                          | String  | The role of the operator                                     |

- After the teacher ends the quiz, the summarized data of the Pop-up Quiz widget updates. `data` contains the following fields:

  | Field name                             | Type    | Description                                                  |
  | :------------------------------------- | :------ | :----------------------------------------------------------- |
  | action                                 | Integer | The action type                                              |
  | changeProperties                       | Object  | The changed properties                                       |
  | changeProperties.extra                 | Object  | The extra information of the changed properties              |
  | changeProperties.extra.selectedCount   | Integer | The number of students who have submitted their answers      |
  | changeProperties.extra.correctCount    | Integer | The number of students who have made the correct choice      |
  | changeProperties.extra.answerState     | Integer | The status of this quiz:<ul><li>`1` : In progress</li><li>`0`: Ended</li></ul> |
  | changeProperties.extra.averageAccuracy | Float   | The rate at which the correct choice is made for this question |
  | changeProperties.extra.totalCount      | Integer | The total number of students who have submitted their answers to this question |
  | cause                                  | String  | The reason for the property change                           |
  | operator                               | Object  | The operator of the property change                          |
  | operator.userUuid                      | String  | The ID of the operator                                       |
  | operator.userName                      | String  | The name of the operator                                     |
  | operator.role                          | String  | The role of the operator                                     |

#### Response example

- After the teacher clicks the Start button to start a quiz, the summarized data of the Pop-up Quiz widget updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "extra.correctItems": [
           "A",
           "B",
           "D"
       ],
       "extra.totalCount": NumberInt("1"),
       "extra.answerState": NumberInt("1"),
       "state": NumberInt("1"),
       "extra.popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
       "extra.averageAccuracy": 0,
       "extra.correctCount": NumberInt("0"),
       "extra.items": [
           "A",
           "C",
           "B"
       ],
       "extra.receiveQuestionTime": NumberLong("1652413962895")
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```

- After a student submits the answer, the student's data updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "selectedItems": [
           "A",
           "B",
           "D"
       ],
       "isCorrect": true,
       "popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
       "lastCommitTime": NumberLong("1652413989997")
   },
   "fromUser": {
       "userName": "yerongzhe2",
       "userUuid": "yerongzhe22",
       "role": "audience"
   }
   ```

- After the teacher ends the quiz, the summarized data of the Pop-up Quiz widget updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "extra.totalCount": NumberInt("1"),
       "extra.answerState": NumberInt("0"),
       "extra.selectedCount": NumberInt("1"),
       "extra.averageAccuracy": 1,
       "extra.correctCount": NumberInt("1")
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```



## Get data for polls

#### Prototype

- Method: GET
- Request path: /edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/polls/sequences

#### Request parameters

**URL parameters**

Pass the following parameters in the URL:

| Parameter  | Type   | Description                                                  |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId`    | String | (Required) Agora App ID.                                     |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. |

**Query parameters**

| Parameter | Type    | Description                                                  |
| :-------- | :------ | :----------------------------------------------------------- |
| `nextId`  | String  | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |
| `count`   | Integer | (Optional) The number of pieces of data in this batch. The default value is 100. |

#### Response parameters

The fields returned in `data` vary in different situations.

- After the teacher clicks the Start button to start a poll, the summarized data of the Polling widget updates. `data` contains the following fields:

  | Field name                                    | Type                | Description                                                  |
  | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
  | action                                        | Integer             | The action type                                              |
  | changeProperties                              | Object              | The changed properties                                       |
  | changeProperties.extra                        | Object              | The extra information of the changed properties              |
  | changeProperties.extra.mode                   | Integer             | The polling mode:<ul><li>`1`: Single-choice</li><li>`2`: Multiple-choice</li></ul> |
  | changeProperties.extra.pollingState           | Integer             | The status of this poll:<ul><li>`1` : In progress</li><li>`0`: Ended</li></ul> |
  | changeProperties.extra.pollDetails            | Map<String, Object> | The polling results. `key` is the option index, starting from `0`. |
  | changeProperties.extra.pollDetails.num        | Integer             | The number of students who have selected this option         |
  | changeProperties.extra.pollDetails.percentage | Float               | The percentage of students who have selected this option in students who have submitted their choices |
  | changeProperties.extra.pollId                 | String              | The poll ID                                                  |
  | changeProperties.extra.pollItems              | Object[]            | The option content                                           |
  | changeProperties.state                        | Integer             | The state of the Polling widget:<ul><li>`0`: Inactive</li></li>`1`: Active</li></ul> |
  | cause                                         | String              | The reason for the property change                           |
  | operator                                      | Object              | The operator of the property change                          |
  | operator.userUuid                             | String              | The ID of the operator                                       |
  | operator.userName                             | String              | The name of the operator                                     |
  | operator.role                                 | String              | The role of the operator                                     |

- After a student submits the choice, the student's data updates. `data` contains the following fields:

  | Field name                         | Type     | Description                                      |
  | :--------------------------------- | :------- | :----------------------------------------------- |
  | action                             | Integer  | The action type                                  |
  | changeProperties                   | Object   | The changed properties                           |
  | changeProperties.extra             | Object   | The extra information of the changed properties  |
  | changeProperties.extra.pollId      | String   | The poll ID                                      |
  | changeProperties.extra.selectIndex | Object[] | The index of the option selected by this student |
  | cause                              | String   | The reason for the property change               |
  | operator                           | Object   | The operator of the property change              |
  | operator.userUuid                  | String   | The ID of the operator                           |
  | operator.userName                  | String   | The name of the operator                         |
  | operator.role                      | String   | The role of the operator                         |
  | fromUser                           | Object   | The user who starts this poll                    |
  | fromUser.userUuid                  | String   | The ID of the user who starts this poll          |
  | fromUser.userName                  | String   | The name of the user who starts this poll        |
  | fromUser.role                      | String   | The role of the user who starts this poll        |

- After a student submits the answer, the summarized data of the Polling widget updates. `data` contains the following fields:

  | Field name                                    | Type                | Description                                                  |
  | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
  | action                                        | Integer             | The action type                                              |
  | changeProperties                              | Object              | The changed properties                                       |
  | changeProperties.extra                        | Object              | The extra information of the changed properties              |
  | changeProperties.extra.pollDetails            | Map<String, Object> | The polling results. `key` is the option index, starting from `0`. |
  | changeProperties.extra.pollDetails.num        | Integer             | The number of students who have selected this option         |
  | changeProperties.extra.pollDetails.percentage | Float               | The percentage of students who have selected this option in students who have submitted their choices |
  | changeProperties.extra.pollId                 | String              | The poll ID                                                  |
  | cause                                         | String              | The reason for the property change                           |
  | operator                                      | Object              | The operator of the property change                          |
  | operator.userUuid                             | String              | The ID of the operator                                       |
  | operator.userName                             | String              | The name of the operator                                     |
  | operator.role                                 | String              | The role of the operator                                     |

- After the teacher ends the poll, the summarized data of the Polling widget updates. `data` contains the following fields:

  | Field name                                    | Type                | Description                                                  |
  | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
  | action                                        | Integer             | The action type                                              |
  | changeProperties                              | Object              | The changed properties                                       |
  | changeProperties.extra                        | Object              | The extra information of the changed properties              |
  | changeProperties.extra.pollingState           | Integer             | The status of this poll:<ul><li>`1` : In progress</li><li>`0`: Ended</li></ul> |
  | changeProperties.extra.pollDetails            | Map<String, Object> | The polling results. `key` is the option index, starting from `0`. |
  | changeProperties.extra.pollDetails.num        | Integer             | The number of students who have selected this option         |
  | changeProperties.extra.pollDetails.percentage | Float               | The percentage of students who have selected this option in students who have submitted their choices |
  | changeProperties.extra.pollId                 | String              | The poll ID                                                  |
  | cause                                         | String              | The reason for the property change                           |
  | operator                                      | Object              | The operator of the property change                          |
  | operator.userUuid                             | String              | The ID of the operator                                       |
  | operator.userName                             | String              | The name of the operator                                     |
  | operator.role                                 | String              | The role of the operator                                     |

#### Response example

- After the teacher clicks the Start button to start a poll, the summarized data of the Polling widget updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
       "extra.pollState": NumberInt("1"),
       "extra.pollItems": [
           "aaa",
           "bbb",
           "ccc",
           "ddd",
           "eee"
       ],
       "extra.mode": NumberInt("2"),
       "state": NumberInt("1"),
       "extra.pollDetails": {
           "0": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "1": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "2": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "3": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "4": {
               "num": NumberInt("0"),
               "percentage": 0
           }
       }
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```

- After a student submits the choice, the student's data updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
       "selectIndex": [
           NumberInt("1"),
           NumberInt("2"),
           NumberInt("4")
       ]
   },
   "fromUser": {
       "userName": "yerongzhe2",
       "userUuid": "yerongzhe22",
       "role": "audience"
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```

- After a student submits the choice, the summarized data of the Polling widget updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "extra.pollId": "2f38e6de32064713adf135de41c963df",
       "extra.pollDetails": {
           "0": {
               "num": NumberInt("1"),
               "percentage": 0.33333334
           },
           "1": {
               "num": NumberInt("3"),
               "percentage": 1
           },
           "2": {
               "num": NumberInt("3"),
               "percentage": 1
           },
           "3": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "4": {
               "num": NumberInt("2"),
               "percentage": 0.6666667
           }
       }
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```

- After the teacher ends the poll, the summarized data of the Polling widget updates:

   ```json
   "action": NumberInt("1"),
   "changeProperties": {
       "extra.pollId": "2f38e6de32064713adf135de41c963df",
       "extra.pollDetails": {
           "0": {
               "num": NumberInt("1"),
               "percentage": 0.33333334
           },
           "1": {
               "num": NumberInt("3"),
               "percentage": 1
           },
           "2": {
               "num": NumberInt("3"),
               "percentage": 1
           },
           "3": {
               "num": NumberInt("0"),
               "percentage": 0
           },
           "4": {
               "num": NumberInt("2"),
               "percentage": 0.6666667
           }
       }
   },
   "operator": {
       "userName": "server",
       "userUuid": "server",
       "role": "server"
   }
   ```
