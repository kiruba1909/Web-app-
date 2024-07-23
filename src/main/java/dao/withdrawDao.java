package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class withdrawDao {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/customerdetails";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Mass";

    // Method to get database connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create database connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("Database connection established successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Failed to establish database connection.");
        }
        return conn;
    }

    public static boolean withdraw(double amount, String accountNo) {
        String checkBalanceQuery = "SELECT balance FROM customerdetails WHERE accno = ?";
        String updateBalanceQuery = "UPDATE customerdetails SET balance = balance - ? WHERE accno = ?";
        try (Connection conn = getConnection();
             PreparedStatement checkBalanceStmt = conn.prepareStatement(checkBalanceQuery);
             PreparedStatement updateBalanceStmt = conn.prepareStatement(updateBalanceQuery)) {
            
            // Check balance
            checkBalanceStmt.setString(1, accountNo);
            ResultSet rs = checkBalanceStmt.executeQuery();
            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");
                if (currentBalance >= amount) {
                    // Perform withdrawal
                    updateBalanceStmt.setDouble(1, amount);
                    updateBalanceStmt.setString(2, accountNo);
                    int rowsAffected = updateBalanceStmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Record the transaction
                        recordTransaction(accountNo, amount, "debit", "Withdrawal of " + amount);
                        System.out.println("Withdrawal successful for account number: " + accountNo);
                        return true;
                    } else {
                        System.out.println("Failed to update balance for withdrawal.");
                    }
                } else {
                    System.out.println("Insufficient funds for account number: " + accountNo);
                }
            } else {
                System.out.println("Account number not found: " + accountNo);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception occurred during withdrawal.");
        }
        return false;
    }

    public static boolean deposit(double amount, String accountNo) {
        String updateBalanceQuery = "UPDATE customerdetails SET balance = balance + ? WHERE accno = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(updateBalanceQuery)) {
            
            // Perform deposit
            pstmt.setDouble(1, amount);
            pstmt.setString(2, accountNo);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Record the transaction
                recordTransaction(accountNo, amount, "credit", "Deposit of " + amount);
                System.out.println("Deposit successful for account number: " + accountNo);
                return true;
            } else {
                System.out.println("Failed to update balance for deposit.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception occurred during deposit.");
        }
        return false;
    }

    private static void recordTransaction(String accountNo, double amount, String type, String description) {
        String query = "INSERT INTO transactions (accno, amount, type, description) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, accountNo);
            pstmt.setDouble(2, amount);
            pstmt.setString(3, type);
            pstmt.setString(4, description);
            pstmt.executeUpdate();
            System.out.println("Transaction recorded successfully: " + description);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Failed to record transaction.");
        }
    }

    public static String getAccountNo(String username) {
        String accountNo = null;
        String query = "SELECT accno FROM customerdetails WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    accountNo = rs.getString("accno");
                    System.out.println("Account number retrieved: " + accountNo);
                } else {
                    System.out.println("Username not found: " + username);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Exception occurred while retrieving account number.");
        }
        return accountNo;
    }

    public static double getBalance(String accountNo) {
        double balance = 0;
        String query = "SELECT balance FROM customerdetails WHERE accno = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, accountNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    balance = rs.getDouble("balance");
                    System.out.println("Balance retrieved: " + balance);
                } else {
                    System.out.println("Account number not found: " + accountNo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Exception occurred while retrieving balance.");
        }
        return balance;
    }

    public static List<Transaction> getTransactionHistory(String accountNo) {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions WHERE accno = ? ORDER BY transaction_date DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, accountNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int transactionId = rs.getInt("transaction_id");
                    double amount = rs.getDouble("amount");
                    String type = rs.getString("type");
                    String description = rs.getString("description");
                    java.sql.Timestamp transactionDate = rs.getTimestamp("transaction_date");
                    
                    Transaction transaction = new Transaction(transactionId, accountNo, amount, type, description, transactionDate);
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Exception occurred while retrieving transaction history.");
        }
        return transactions;
    }
}
