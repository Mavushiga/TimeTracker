<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) userSession.getAttribute("username");

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/time_tracker";
    String dbUser = "root";
    String dbPassword = "Mav#123";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String projectName = "";
    String totalHours = "0";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL query to get project name and total hours
        String sql = "SELECT p.name AS project_name, SUM(TIME_TO_SEC(t.timeDuration) / 3600) AS total_hours " +
                     "FROM tasks t " +
                     "JOIN projects p ON t.project_id = p.id " +
                     "JOIN employees e ON t.employee_id = e.id " +
                     "JOIN users u ON e.id = u.id " +
                     "WHERE u.username = ? " +
                     "GROUP BY p.name";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            projectName = rs.getString("project_name");
            totalHours = rs.getString("total_hours");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Associate Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://wallpapercave.com/wp/wp6056688.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.7); /* Translucent background */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        .header {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .header h1 {
            margin: 0;
            color: #333;
        }
        .header p {
            margin: 0;
            font-size: 25px;
            color: #666;
            font-family: Arial, sans-serif;
            font-weight: bold;
        }
        .dashboard-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .info-box {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            flex: 1 1 30%;
            display: flex;
            align-items: center;
        }
        .info-box i {
            font-size: 40px;
            margin-right: 15px;
            color: #123a75;
        }
        .info-box div {
            text-align: left;
        }
        .info-box div h3 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .info-box div p {
            margin: 5px 0 0;
            font-size: 18px;
            color: #666;
        }
        .buttons {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .buttons button {
            background-color: #123a75c2;
            color: white;
            padding: 15px 20px;
            margin: 10px 0;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
            width: 200px;
        }
        .buttons button:hover {
            background-color: #1268eac2;
        }
     
        .graph-container {
            background-color: rgba(255, 255, 255, 0.582);
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            flex: 1 1 40%;
        }
        #line-chart {
            width: 100%;
            height: 300px; /* Updated size */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="associateDashboard.jsp">Home</a>
        <a href="logout.jsp" style="float:right;">Logout</a>
    </div>
    <div class="container">
        <div class="header">
            <h1>Associate Dashboard</h1>
            <p>Welcome, <%= username %></p>
        </div>
        <div class="dashboard-content">
            <div class="info-box">
                <i class="fas fa-project-diagram"></i>
                <div>
                    <h3>Current Project</h3>
                    <p>Project Name: <%= projectName %></p>
                </div>
            </div>
            <div class="info-box">
                <i class="fas fa-clock"></i>
                <div>
                    <h3>Total Hours</h3>
                    <p><%= totalHours %> hours</p>
                </div>
            </div>
            <div class="graph-container">
                <h3>Daily Hours Worked</h3>
                <canvas id="line-chart"></canvas>
            </div>
        </div>
        <div class="buttons">
            <button onclick="location.href='addTask.jsp'">Add Task</button>
            <button onclick="location.href='viewTasks.jsp'">View Tasks</button>
            <button onclick="location.href='viewReports.jsp'">View Reports</button>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx = document.getElementById('line-chart').getContext('2d');
        const lineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
                datasets: [{
                    label: 'Hours Worked',
                    data: [8, 7, 6, 5, 7],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: false
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
