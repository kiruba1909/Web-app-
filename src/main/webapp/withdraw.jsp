<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking Operations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #2f4f4f;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: auto;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .radio-label {
            display: inline-block;
            margin-right: 10px;
        }
        input[type="radio"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <h2>Banking Operations</h2>
    <% 
        String username = (String) session.getAttribute("Username");
        System.out.println("Username retrieved from session: " + username); // Debug statement
        if (username == null) {
            out.println("<h2>Welcome, guest</h2>");
        } else {
            out.println("<h2>Welcome, " + username + "</h2>");
        }
    %>
    <form action="withdrawServlet" method="post">
        <label for="accNo">Account Number:</label>
        <input type="text" id="accNo" name="accNo" placeholder="Enter your account number" required><br>

        <label for="amount">Amount:</label>
        <input type="text" id="amount" name="amount" placeholder="Enter the amount" required><br>

        <label>Action:</label>
        <div class="radio-label">
            <input type="radio" id="withdraw" name="action" value="withdraw" checked>
            <label for="withdraw" style="display: inline;">Withdraw</label>
        </div>
        <div class="radio-label">
            <input type="radio" id="deposit" name="action" value="deposit">
            <label for="deposit" style="display: inline;">Deposit</label>
        </div><br><br>

        <input type="submit" value="Process">
    </form>
</body>
</html>
