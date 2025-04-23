/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.ass.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();

        boolean loggedIn = session != null && session.getAttribute("user") != null;
        boolean loginRequest = path.endsWith("login.jsp") || path.endsWith("login")
                             || path.endsWith("register.jsp") || path.endsWith("register");

        if (loggedIn || loginRequest) {
            chain.doFilter(request, response);
        } else {
            ((HttpServletResponse) response).sendRedirect("login.jsp");
        }
    }
}
