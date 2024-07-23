<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            height: 100%;
            overflow: auto;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            max-width: 500px;
            width: 100%;
            margin: 20px auto;
            box-sizing: border-box;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #0066cc;
            outline: none;
        }
        .form-group input[type="submit"] {
            background-color: #0066cc;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-group input[type="submit"]:hover {
            background-color: #004d99;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px #999;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .button:active {
            background-color: #45a049;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
        .logout-button {
            background-color: #ff4d4d;
            box-shadow: 0 4px #b30000;
        }
        .logout-button:hover {
            background-color: #e60000;
        }
        .logout-button:active {
            background-color: #e60000;
            box-shadow: 0 5px #990000;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            color: #ff0000;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('DOB').addEventListener('change', function() {
                const dob = new Date(this.value);
                const ageDifMs = Date.now() - dob.getTime();
                const ageDate = new Date(ageDifMs);
                const age = Math.abs(ageDate.getUTCFullYear() - 1970);
                if (age < 18) {
                    alert('Age must be 18 or older.');
                    this.value = '';
                }
            });

            document.getElementById('username').addEventListener('blur', function() {
                const username = this.value;
                if (username) {
                    const xhr = new XMLHttpRequest();
                    xhr.open('GET', 'checkUsernameServlet?username=' + encodeURIComponent(username), true);
                    xhr.onload = function() {
                        if (xhr.status === 200) {
                            if (xhr.responseText === 'exists') {
                                document.querySelector('.message').innerText = 'Username already exists. Please choose a different username.';
                            } else {
                                document.querySelector('.message').innerText = '';
                            }
                        }
                    };
                    xhr.send();
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>Customer Registration Form</h2>
        <form action="registerCustomerServlet" method="post">
            <div class="form-group">
                <label for="fullname">Full Name:</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>
            <div class="form-group">
                <label for="phonenumber">Phone Number:</label>
                <input type="text" id="phonenumber" name="phonenumber" required pattern="\d{10}" title="Phone number should be 10 digits.">
            </div>
            <div class="form-group">
                <label for="emailid">Email ID:</label>
                <input type="email" id="emailid" name="emailid" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="DOB">Date of Birth:</label>
                <input type="date" id="DOB" name="DOB" required>
            </div>
            <div class="form-group">
                <label for="accounttype">Type of Account:</label>
                <select id="accounttype" name="accounttype" required>
                    <option value="savings">Savings</option>
                    <option value="current">Current</option>
                </select>
            </div>
            <div class="form-group">
                <label for="idproof">ID Proof:</label>
                <input type="text" id="idproof" name="idproof" required>
            </div>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="initialbalance">Initial Balance:</label>
                <input type="number" id="initialbalance" name="initialbalance" required min="0" step="0.01">
            </div>
            <div class="form-group">
                <input type="submit" value="Register">
            </div>
        </form>
        <div class="message"></div>
        <a href="adminloginsuccess.jsp" class="button logout-button">Back to Admin Dashboard</a>
    </div>
</body>
</html>