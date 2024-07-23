<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .button-container button {
            padding: 15px;
            margin: 10px;
            width: 100%;
            max-width: 300px;
            border-radius: 4px;
            border: none;
            background-color: #008080;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        .button-container button:hover {
            background-color: #006666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <div class="button-container">
            <button onclick="window.location.href='adminAddTask.jsp'">Add Task</button>
            <button onclick="window.location.href='adminViewTasks.jsp'">View Tasks</button>
            <button onclick="window.location.href='adminViewReports.jsp'">View Reports</button>
        </div>
    </div>
</body>
</html>