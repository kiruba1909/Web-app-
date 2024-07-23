<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            text-align: center;
            margin: 0;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }
        .container {
            text-align: center;
            padding: 40px;
            background: rgba(0, 0, 0, 0.6);
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        h1 {
            font-size: 40px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .button {
            display: inline-block;
            padding: 15px 40px;
            margin: 10px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            color: #fff;
            background-color: #ff5722;
            border: 2px solid #ff5722;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .button:hover {
            background-color: #e64a19;
            border-color: #e64a19;
            transform: translateY(-5px);
        }
        .button i {
            margin-right: 10px;
        }
        .button-container {
            display: inline-block;
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>You're Welcome</h1>
        
        <div class="button-container">
            <a href="adminlogin.jsp" class="button"><i class="fas fa-user-shield"></i> Admin Login</a>
            <a href="customerlogin.jsp" class="button"><i class="fas fa-user"></i> Customer Login</a>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
