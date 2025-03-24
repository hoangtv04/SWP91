package dal;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO extends DBContext {

    public List<Customer> getAllCustomers() throws Exception {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM Customer";
        try (Connection connection = getConnection(); Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setPhone(rs.getString("Phone"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPassword(rs.getString("Password"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                customers.add(customer);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customers;
    }

    public Customer getCustomerById(int customerId) throws Exception {
        String query = "SELECT * FROM Customer WHERE CustomerID = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setPhone(rs.getString("Phone"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPassword(rs.getString("Password"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                return customer;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Customer getCustomerByPhone(String phone) throws Exception {
        String query = "SELECT * FROM Customer WHERE Phone = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            phone = phone.trim(); // Normalize input
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.INFO, "Executing query: {0} with phone: {1}", new Object[]{query, phone});
            stmt.setString(1, phone); // Set the phone parameter
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Create and populate the Customer object
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setPhone(rs.getString("Phone"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPassword(rs.getString("Password"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                return customer; // Return the populated Customer object
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error fetching customer by phone", ex);
        }
        return null; // Return null if no customer is found or an error occurs
    }

    public Customer getCustomerByEmail(String email) throws Exception {
        String query = "SELECT * FROM Customer WHERE Email = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setPhone(rs.getString("Phone"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPassword(rs.getString("Password"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                return customer;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Customer getCustomerByName(String name) throws Exception {
        String query = "SELECT * FROM Customer WHERE CustomerName = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerID"));
                customer.setPhone(rs.getString("Phone"));
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPassword(rs.getString("Password"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                return customer;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean addCustomer(Customer customer) throws Exception {
        String query = "INSERT INTO Customer (Phone, CustomerName, Password, Email, Address) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getPhone());
            stmt.setString(2, customer.getCustomerName());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getAddress());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateCustomer(Customer customer) throws Exception {
        String query = "UPDATE Customer SET Phone = ?, CustomerName = ?, Password = ?, Email = ?, Address = ? WHERE CustomerID = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getPhone());
            stmt.setString(2, customer.getCustomerName());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getAddress());
            stmt.setInt(6, customer.getCustomerId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteCustomer(int customerId) throws Exception {
        String query = "DELETE FROM Customer WHERE CustomerID = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean isPhoneExists(String phone) throws Exception {
        String query = "SELECT COUNT(*) FROM Customer WHERE phone = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public boolean isEmailExists(String email) throws Exception {
        String query = "SELECT COUNT(*) FROM Customer WHERE Email = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO();
        try {
            String testPhone = "0987654321";
            Customer customer = dao.getCustomerByPhone(testPhone);
            if (customer != null) {
                System.out.println("Customer found: " + customer.getCustomerName() + ", " + customer.getEmail());
            } else {
                System.out.println("No customer found with phone: " + testPhone);
            }
        } catch (Exception ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error testing getCustomerByPhone", ex);
        }
    }
}
