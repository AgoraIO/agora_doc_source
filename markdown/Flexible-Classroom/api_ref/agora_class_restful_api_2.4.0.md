## 获取答题器事件

#### 接口原型

-   方法：GET
-   请求路径：/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/popupQuiz/sequences

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                                                                                              |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------- |
| `appId`    | String | （必填）Agora App ID。                                                                                                            |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型    | 描述                                                                                      |
| :------- | :------ | :---------------------------------------------------------------------------------------- |
| `nextId` | String  | （选填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |
| `count`  | Integer | （选填）本批数据条数，默认值为 100。                                                      |

#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                       | 类型     | 说明                                                                   |
    | :----------------------------------------- | :------- | :--------------------------------------------------------------------- |
    | action                                     | Integer  | 操作类型                                                               |
    | changeProperties                           | Object   | 发生变更的属性                                                         |
    | changeProperties.extra                     | Object   | 属性补充信息                                                           |
    | changeProperties.extra.correctItems        | Object[] | 正确选项                                                               |
    | changeProperties.extra.correctCount        | Integer  | 本题答对人数                                                           |
    | changeProperties.extra.answerState         | Integer  | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.receiveQuestionTime | Long     | 收到题目时间                                                           |
    | changeProperties.extra.popupQuizId         | String   | 题目 ID                                                                |
    | changeProperties.extra.averageAccuracy     | Float    | 本题正确率                                                             |
    | changeProperties.extra.totalCount          | Integer  | 本题回答总人数                                                         |
    | changeProperties.extra.items               | Object[] | 本题的所有选项                                                         |
    | changeProperties.state                     | Integer  | 答题器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>            |
    | cause                                      | String   | 属性变更原由，答题器为 `popupQuiz`                                     |
    | operator                                   | Object   | 操作人                                                                 |
    | operator.userUuid                          | String   | 用户 ID                                                                |
    | operator.userName                          | String   | 用户名称                                                               |
    | operator.role                              | String   | 用户角色                                                               |

-   学生提交答案后，该学生的答题数据会发生变化，`data` 中包含以下字段：

    | 字段                            | 类型     | 说明                               |
    | :------------------------------ | :------- | :--------------------------------- |
    | action                          | Integer  | 操作类型                           |
    | changeProperties                | Object   | 发生变更的属性                     |
    | changeProperties.lastCommitTime | Long     | 最后一次提交时间                   |
    | changeProperties.popupQuizId    | String   | 题目 ID                            |
    | changeProperties.selectedItems  | Object[] | 该学生提交的答案                   |
    | changeProperties.isCorrect      | Boolean  | 该学生提交的答案是否正确           |
    | cause                           | String   | 属性变更原由，答题器为 `popupQuiz` |
    | operator                        | Object   | 操作人                             |
    | operator.userUuid               | String   | 用户 uuid                          |
    | operator.userName               | String   | 用户名称                           |
    | operator.role                   | String   | 用户角色                           |
    | fromUser                        | Object   | 发起本次答题的用户                 |
    | fromUser.userUuid               | String   | 用户 ID                            |
    | fromUser.userName               | String   | 用户名称                           |
    | fromUser.role                   | String   | 用户角色                           |

-   学生提交答案后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                               |
    | :------------------------------------- | :------ | :--------------------------------- |
    | action                                 | Integer | 操作类型                           |
    | changeProperties                       | Object  | 发生变更的属性                     |
    | changeProperties.extra                 | Object  | 属性补充信息                       |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                       |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                       |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                         |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                     |
    | cause                                  | String  | 属性变更原由，答题器为 `popupQuiz` |
    | operator                               | Object  | 操作人                             |
    | operator.userUuid                      | String  | 用户 ID                            |
    | operator.userName                      | String  | 用户名称                           |
    | operator.role                          | String  | 用户角色                           |

-   老师结束答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                                                                   |
    | :------------------------------------- | :------ | :--------------------------------------------------------------------- |
    | action                                 | Integer | 操作类型                                                               |
    | changeProperties                       | Object  | 发生变更的属性                                                         |
    | changeProperties.extra                 | Object  | 属性补充信息                                                           |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                                                           |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                                                           |
    | changeProperties.extra.answerState     | Integer | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                                                             |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                                                         |
    | cause                                  | String  | 属性变更原由，答题器为 `popupQuiz`                                     |
    | operator                               | Object  | 操作人                                                                 |
    | operator.userUuid                      | String  | 用户 uuid                                                              |
    | operator.userName                      | String  | 用户名称                                                               |
    | operator.role                          | String  | 用户角色                                                               |

#### 响应示例

-   老师开启答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.popupQuiz.extra.correctItems": [
            "A",
            "B",
            "D"
        ],
        "widgets.popupQuiz.extra.totalCount": NumberInt("1"),
        "widgets.popupQuiz.extra.answerState": NumberInt("1"),
        "widgets.popupQuiz.state": NumberInt("1"),
        "widgets.popupQuiz.extra.popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "widgets.popupQuiz.extra.averageAccuracy": 0,
        "widgets.popupQuiz.extra.correctCount": NumberInt("0"),
        "widgets.popupQuiz.extra.items": [
            "A",
            "C",
            "B"
        ],
        "widgets.popupQuiz.extra.receiveQuestionTime": NumberLong("1652413962895")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交答案后，该学生的答题数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.popupQuiz.selectedItems": [
            "A",
            "B",
            "D"
        ],
        "widgets.popupQuiz.isCorrect": true,
        "widgets.popupQuiz.popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "widgets.popupQuiz.lastCommitTime": NumberLong("1652413989997")
    },
    "fromUser": {
        "userName": "yerongzhe2",
        "userUuid": "yerongzhe22",
        "role": "audience"
    }
    ```

-   老师结束答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.popupQuiz.extra.totalCount": NumberInt("1"),
        "widgets.popupQuiz.extra.answerState": NumberInt("0"),
        "widgets.popupQuiz.extra.selectedCount": NumberInt("1"),
        "widgets.popupQuiz.extra.averageAccuracy": 1,
        "widgets.popupQuiz.extra.correctCount": NumberInt("1")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

## 获取投票器事件

#### 接口原型

-   方法：GET
-   请求路径：/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/polls/sequences

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                                                                                              |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------- |
| `appId`    | String | （必填）Agora App ID。                                                                                                            |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型    | 描述                                                                                      |
| :------- | :------ | :---------------------------------------------------------------------------------------- |
| `nextId` | String  | （选填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |
| `count`  | Integer | （选填）本批数据条数，默认值为 100。                                                      |

#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                                   |
    | :-------------------------------------------- | :------------------ | :--------------------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                               |
    | changeProperties                              | Object              | 发生变更的属性                                                         |
    | changeProperties.extra                        | Object              | 属性补充信息                                                           |
    | changeProperties.extra.mode                   | Integer             | 投票模式：<ul><li>`1`: 单选</li><li>`2`: 多选</li></ul>                |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                              |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                                       |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                             |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                            |
    | changeProperties.extra.pollItems              | Object[]            | 选项内容                                                               |
    | changeProperties.state                        | Integer             | 投票器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>            |
    | cause                                         | String              | 属性变更原由，投票器为 `poll`                                          |
    | operator                                      | Object              | 操作人                                                                 |
    | operator.userUuid                             | String              | 用户 ID                                                                |
    | operator.userName                             | String              | 用户名称                                                               |
    | operator.role                                 | String              | 用户角色                                                               |

-   学生提交选项后，该学生的投票数据会发生变化，`data` 中包含以下字段：

    | 字段                               | 类型     | 说明                          |
    | :--------------------------------- | :------- | :---------------------------- |
    | action                             | Integer  | 操作类型                      |
    | changeProperties                   | Object   | 发生变更的属性                |
    | changeProperties.extra             | Object   | 属性补充信息                  |
    | changeProperties.extra.pollId      | String   | 本次投票 ID                   |
    | changeProperties.extra.selectIndex | Object[] | 该学生选择的选项的索引        |
    | cause                              | String   | 属性变更原由，投票器为 `poll` |
    | operator                           | Object   | 操作人                        |
    | operator.userUuid                  | String   | 用户 ID                       |
    | operator.userName                  | String   | 用户名称                      |
    | operator.role                      | String   | 用户角色                      |
    | fromUser                           | Object   | 发起本次投票的用户            |
    | fromUser.userUuid                  | String   | 用户 ID                       |
    | fromUser.userName                  | String   | 用户名称                      |
    | fromUser.role                      | String   | 用户角色                      |

-   学生提交选项后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                      |
    | :-------------------------------------------- | :------------------ | :---------------------------------------- |
    | action                                        | Integer             | 操作类型                                  |
    | changeProperties                              | Object              | 发生变更的属性                            |
    | changeProperties.extra                        | Object              | 属性补充信息                              |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。 |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                          |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                               |
    | cause                                         | String              | 属性变更原由，投票器为 `poll`             |
    | operator                                      | Object              | 操作人                                    |
    | operator.userUuid                             | String              | 用户 ID                                   |
    | operator.userName                             | String              | 用户名称                                  |
    | operator.role                                 | String              | 用户角色                                  |

-   老师结束投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                                   |
    | :-------------------------------------------- | :------------------ | :--------------------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                               |
    | changeProperties                              | Object              | 发生变更的属性                                                         |
    | changeProperties.extra                        | Object              | 属性补充信息                                                           |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                              |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                                       |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                             |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                            |
    | cause                                         | String              | 属性变更原由，投票器为 `poll`                                          |
    | operator                                      | Object              | 操作人                                                                 |
    | operator.userUuid                             | String              | 用户 ID                                                                |
    | operator.userName                             | String              | 用户名称                                                               |
    | operator.role                                 | String              | 用户角色                                                               |

#### 响应示例

-   老师开启投票后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.poll.extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "widgets.poll.extra.pollState": NumberInt("1"),
        "widgets.poll.extra.pollItems": [
            "aaa",
            "bbb",
            "ccc",
            "ddd",
            "eee"
        ],
        "widgets.poll.extra.mode": NumberInt("2"),
        "widgets.poll.state": NumberInt("1"),
        "widgets.poll.extra.pollDetails": {
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

-   学生提交选项后，该学生的投票数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.poll.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "widgets.poll.selectIndex": [
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

-   学生提交选项后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.poll.extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "widgets.poll.extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   老师结束投票后，投票器的汇总数据会发生变化：

    ```startRenderVideoFromCdnjson
    "action": NumberInt("1"),
    "changeProperties": {
        "widgets.poll.extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "widgets.poll.extra.pollState": NumberInt("0"),
        "widgets.poll.extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```
