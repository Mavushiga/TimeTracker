<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
        }
        .background {
            background-image: url('https://wallpapercave.com/wp/wp6056688.jpg');
            height: 100%;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .nav {
            position: absolute;
            top: 10px;
            right: 20px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-size: 18px;
        }
        .nav a:hover {
            text-decoration: underline;
        }
        .main-text {
            font-size: 70px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="background">
        <div class="overlay">
            <div class="nav">
                <a href="home.jsp">Home</a>
                <a href="login.jsp">Login</a>
                <a href="login.jsp">Reports</a>
                <a href="contact.jsp">Contact Us</a>
            </div>
            <div class="main-text">EMPLOYEE TIME TRACKER</div>
        </div>
    </div>
</body>
</html>