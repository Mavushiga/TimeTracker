<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Invalidate the session if it exists
    HttpSession userSession = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }

    // Redirect to login page
    response.sendRedirect("login.jsp");
%>