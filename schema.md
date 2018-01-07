Boards

| Title | Description | ID |
|-------|-------------|----|
| Title of the board| Description of the board | ID  |

Sub-board table
Just a list of edges, basically

| ParentID | ChildID |
|----------|---------|
| ID of parent | ID of child board |

Thread table

| Description | BoardID | PostID | ThreadID |
|-------------|---------|--------|----------|
| Description of thread | The ID of the board it is in | The first post's ID | Thread ID|

Post Table

| PostID | ThreadID | Content |
|--------|----------|---------|
| This ID | The ID of thread connected to | Content of the post |
