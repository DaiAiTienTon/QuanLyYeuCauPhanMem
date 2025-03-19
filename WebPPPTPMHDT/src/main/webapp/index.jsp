<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.LopHocPhan, model.GiangVien" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đăng ký tín chỉ</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        header {
            background-color: #0D6EFD;
            color: #fff;
            padding: 15px;
        }
        header h1 {
            font-size: 20px;
        }
        nav {
            background-color: #f2f2f2;
            border-bottom: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
        }
        nav ul {
            list-style-type: none;
            display: flex;
            justify-content: flex-start;
        }
        nav li {
            margin-right: 20px;
        }
        nav a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        nav a:hover {
            background-color: #ddd;
        }
        main {
            padding: 20px;
        }
        section {
            display: none;
        }
        footer {
            background-color: #0D6EFD;
            color: #fff;
            text-align: center;
            padding: 10px;
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #eee;
        }
        section.active {
            display: block;
        }
    </style>
</head>
<body>
    <header>
        <h1>Hệ thống Quản lý Đăng ký Tín chỉ</h1>
    </header>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/QuanLyDangKyServlet">Quản lý Đăng ký Tín chỉ</a></li>
            <li><a href="${pageContext.request.contextPath}/TraCuuServlet">Tra cứu Thông tin</a></li>
        </ul>
        <ul>
            <%
                if (session != null && session.getAttribute("username") != null) {
                    String username = (String) session.getAttribute("username");
            %>
                <li><a href="#"><%= username %></a></li>
                <li><a href="LogoutServlet">Đăng xuất</a></li>
            <%
                } else {
            %>
                <li><a href="login.html">Tài khoản</a></li>
            <%
                }
            %>
        </ul>
    </nav>
    <main>
        <% String activeSection = (String) request.getAttribute("activeSection"); %>
        <% if ("home".equals(activeSection)) { %>
            <section id="home" class="active">
                <%@ include file="home.jsp" %>
            </section>
        <% } else if ("quan-ly-dang-ky".equals(activeSection)) { %>
            <section id="quan-ly-dang-ky" class="active">
                <%@ include file="quanlydangky.jsp" %>
            </section>
        <% } else if ("tra-cuu".equals(activeSection)) { %>
            <section id="tra-cuu" class="active">
                <%@ include file="tracuu.jsp" %>
            </section>
        <% } else { %>
            <p>Section không tồn tại.</p>
        <% } %>
    </main>
    <footer>
        <p>© 2025 Trường Đại học CNTT & Truyền thông</p>
    </footer>
</body>
</html>