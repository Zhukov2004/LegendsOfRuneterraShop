/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author Admin
 */
@WebServlet("/verify-reset")
public class VerifyResetOTPController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otpInput = request.getParameter("otpInput");
        HttpSession session = request.getSession();
        String otpStored = (String) session.getAttribute("resetOtp");

        if (otpStored == null || !otpStored.equals(otpInput)) {
            request.setAttribute("error", "⚠️ Mã xác thực không đúng!");
            request.getRequestDispatcher("verify-reset.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }
}
