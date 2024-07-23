<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
            margin: 0;
        }
        .login-form {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }
        .login-form:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
        }
        .login-form h2 {
            margin-bottom: 30px;
            font-size: 30px;
            color: #333;
            position: relative;
        }
        .login-form h2::after {
            content: '';
            width: 60px;
            height: 4px;
            background-color: #ff6f61;
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
        }
        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .input-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .input-group input {
            width: calc(100% - 20px);
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        .input-group input:focus {
            border-color: #ff6f61;
        }
        .button {
            width: 100%;
            padding: 15px 0;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            color: #fff;
            background-color: #ff6f61;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
        }
        .button:hover {
            background-color: #ff3f34;
            transform: translateY(-3px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }
        .button:active {
            transform: translateY(0);
        }
        .login-form::before {
            content: '';
            width: 100%;
            height: 8px;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
            position: absolute;
            top: 0;
            left: 0;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
    </style>
</head>
<body>

    <div class="login-form">
        <h2>Customer Login</h2>
        <form action="CustomerLoginServlet" method="post">
            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="button">Login</button>
        </form>
    </div>

</body>
</html>
