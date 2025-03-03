package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import dal.CustomerDAO;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ViewUserController", urlPatterns = {"/user"})
public class ViewUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            
            CustomerDAO dao = new CustomerDAO();
            List<Customer> customers = dao.getAllCustomers();
            
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("viewUsers.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ViewUserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                int showtimeID = Integer.parseInt(request.getParameter("customerID"));
                String phone = request.getParameter("phone");
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                
                Customer customer = new Customer(showtimeID, phone, name, password, email, address);
                CustomerDAO dao = new CustomerDAO();
                dao.updateCustomer(customer);
            } catch (Exception ex) {
                Logger.getLogger(ViewUserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("add".equals(action)) {  try {
            // Xử lý thêm người dùng
            String phone = request.getParameter("phone");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            Customer newCustomer = new Customer(0, phone, name, password, email, address);
            CustomerDAO dao = new CustomerDAO();
            dao.addCustomer(newCustomer);
            } catch (Exception ex) {
                Logger.getLogger(ViewUserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if ("delete".equals(action)) {
            try {
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                CustomerDAO dao = new CustomerDAO();
                dao.deleteCustomer(customerID);
            } catch (Exception ex) {
                Logger.getLogger(ViewUserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        response.sendRedirect(request.getContextPath() + "/user");
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị và cập nhật danh sách người dùng";
    }
}
