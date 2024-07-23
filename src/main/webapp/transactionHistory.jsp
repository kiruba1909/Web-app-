<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dao.withdrawDao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
    <style>
        body {
            font-family: 'Verdana', sans-serif;
            background: #f0f8ff; /* Light Alice Blue */
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            background: #ffffff; /* White */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            border: 1px solid #ddd;
        }
        h2 {
            color: #2e8b57; /* Sea Green */
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #2e8b57;
            padding-bottom: 10px;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #87cefa; /* Light Sky Blue */
        }
        th, td {
            padding: 14px;
            text-align: left;
        }
        th {
            background-color: #87cefa; /* Light Sky Blue */
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* Very Light Gray */
        }
        tr:hover {
            background-color: #e0f7fa; /* Light Cyan */
        }
        .deposit {
            color: #4caf50; /* Green */
            font-weight: bold;
        }
        .withdraw {
            color: #f44336; /* Red */
            font-weight: bold;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background-color: #2e8b57; /* Sea Green */
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #1c6e3f; /* Darker Sea Green */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Transaction History for <%= session.getAttribute("Username") %></h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String username = (String) session.getAttribute("Username");
                    String accountNo = withdrawDao.getAccountNo(username);

                    if (accountNo != null && !accountNo.isEmpty()) {
                        String query = "SELECT * FROM transactions WHERE accno = ? ORDER BY transaction_date DESC";
                        try (Connection conn = withdrawDao.getConnection();
                             PreparedStatement pstmt = conn.prepareStatement(query)) {
                            pstmt.setString(1, accountNo);
                            try (ResultSet rs = pstmt.executeQuery()) {
                                if (rs.next()) {
                                    do {
                                        String type = rs.getString("type").toUpperCase();
                                        double amount = rs.getDouble("amount");
                                        String formattedAmount = (type.equals("CREDIT") ? "+" : "-") + String.format("%.2f", amount);
                                        String cssClass = type.equals("CREDIT") ? "deposit" : "withdraw";
                %>
                <tr>
                    <td><%= rs.getTimestamp("transaction_date") %></td>
                    <td class="<%= cssClass %>"><%= type %></td>
                    <td class="<%= cssClass %>"><%= formattedAmount %></td>
                    <td><%= rs.getString("description") %></td>
                </tr>
                <% 
                                    } while (rs.next());
                                } else {
                                    out.println("<tr><td colspan='4'>No transactions found.</td></tr>");
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='4'>Error retrieving transactions: " + e.getMessage() + "</td></tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='4'>Account number not found.</td></tr>");
                    }
                %>
            </tbody>
        </table>
        <a href="Welcome.jsp">Back to Welcome Page</a>
    </div>
</body>
</html>
