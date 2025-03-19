<%@page import="model.LichHoc"%>
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
        <!-- Trang chủ -->
        <section id="home">
            <h2>Trang chủ</h2>
            <p>Chào mừng bạn đến với hệ thống đăng ký tín chỉ.</p>
            <h3>Lịch học của bạn</h3>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã KH</th>
                        <th>Phòng học</th>
                        <th>Thứ</th>
                        <th>Tiết học</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<LichHoc> lichHocList = (List<LichHoc>) request.getAttribute("lichHocList");
                        if (lichHocList != null && !lichHocList.isEmpty()) {
                            int stt = 1;
                            for (LichHoc lh : lichHocList) {
                    %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td><%= lh.getMaKh() %></td>
                        <td><%= lh.getPhongHoc() %></td>
                        <td><%= lh.getThu() %></td>
                        <td><%= lh.getTietHoc() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr><td colspan="5">Chưa có lịch học nào.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <h3>Danh sách Lớp học phần có thể đăng ký</h3>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã LHP</th>
                        <th>Tên học phần</th>
                        <th>Số tín chỉ</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<LopHocPhan> lopHocPhanList = (List<LopHocPhan>) request.getAttribute("lopHocPhanList");
                        if (lopHocPhanList != null && !lopHocPhanList.isEmpty()) {
                            int stt = 1;
                            for (LopHocPhan lhp : lopHocPhanList) {
                    %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td><%= lhp.getMaLhp() %></td>
                        <td><%= lhp.getTenHocPhan() %></td>
                        <td><%= lhp.getSoTinChi() %></td>
                        <td><%= lhp.getTrangThai() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr><td colspan="5">Không có lớp học phần nào.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </section>

        <!-- Quản lý đăng ký tín chỉ -->
        <section id="quan-ly-dang-ky" style="background-color: #f8f9fa; padding: 15px; border-radius: 5px;">
            <h2 style="color: #0D6EFD; text-align: center;">Quản lý Đăng ký Tín chỉ</h2>
            <p style="font-weight: bold;">Trang này sẽ cho phép bạn đăng ký, hủy đăng ký, hoặc xem tình trạng các lớp học phần.</p>
            <h3 style="color: #0D6EFD; text-align: center;">Danh sách lớp học phần có thể đăng ký</h3>
            <table style="width: 100%; margin-top: 15px; border-collapse: collapse; text-align: center; border: 1px solid #0D6EFD;">
                <thead>
                    <tr style="background-color: #0D6EFD; color: white;">
                        <th>STT</th>
                        <th>Chọn</th>
                        <th>Lớp học phần</th>
                        <th>Học phần</th>
                        <th>Thời gian</th>
                        <th>Địa điểm</th>
                        <th>Giảng viên</th>
                        <th>Sĩ số</th>
                        <th>Đã ĐK</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<LopHocPhan> lopHocPhanList2 = (List<LopHocPhan>) request.getAttribute("lopHocPhanList");
                        if (lopHocPhanList2 != null && !lopHocPhanList2.isEmpty()) {
                            int stt = 1;
                            for (LopHocPhan lhp : lopHocPhanList2) {
                    %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td>
                            <form action="QuanLyDangKyServlet" method="post">
                                <input type="hidden" name="maLhp" value="<%= lhp.getMaLhp() %>">
                                <input type="hidden" name="action" value="register">
                                <button type="submit" style="background-color: #d32f2f; color: white; border: none; padding: 5px 10px; cursor: pointer;">Đăng Ký</button>
                            </form>
                        </td>
                        <td><%= lhp.getMaLhp() %></td>
                        <td><%= lhp.getTenHocPhan() %></td>
                        <td><%= lhp.getThoiGian() %></td>
                        <td><%= lhp.getDiaDiem() %></td>
                        <td><%= lhp.getGiangVien() %></td>
                        <td><%= lhp.getSiSo() %></td>
                        <td><%= lhp.getDaDk() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr><td colspan="9">Không có lớp học phần nào.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <h3 style="color: #d32f2f; text-align: center;">Danh sách lớp học phần đã đăng ký</h3>
            <table style="width: 100%; border-collapse: collapse; text-align: center; border: 1px solid #0D6EFD;">
                <thead>
                    <tr style="background-color: #0D6EFD; color: white;">
                        <th>STT</th>
                        <th>Hủy</th>
                        <th>Lớp học phần</th>
                        <th>Học phần</th>
                        <th>Thời gian</th>
                        <th>Địa điểm</th>
                        <th>Giảng viên</th>
                        <th>Sĩ số</th>
                        <th>Đã ĐK</th>
                        <th>Số TC</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<LopHocPhan> dangKyList = (List<LopHocPhan>) request.getAttribute("dangKyList");
                        if (dangKyList != null && !dangKyList.isEmpty()) {
                            int stt = 1;
                            for (LopHocPhan lhp : dangKyList) {
                    %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td>
                            <form action="QuanLyDangKyServlet" method="post">
                                <input type="hidden" name="maLhp" value="<%= lhp.getMaLhp() %>">
                                <input type="hidden" name="action" value="cancel">
                                <button type="submit" style="background-color: #d32f2f; color: white; border: none; padding: 5px 10px; cursor: pointer;">Hủy</button>
                            </form>
                        </td>
                        <td><%= lhp.getMaLhp() %></td>
                        <td><%= lhp.getTenHocPhan() %></td>
                        <td><%= lhp.getThoiGian() %></td>
                        <td><%= lhp.getDiaDiem() %></td>
                        <td><%= lhp.getGiangVien() %></td>
                        <td><%= lhp.getSiSo() %></td>
                        <td><%= lhp.getDaDk() %></td>
                        <td><%= lhp.getSoTinChi() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr><td colspan="10">Chưa đăng ký lớp học phần nào.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </section>

        <!-- Tra cứu thông tin -->
        <section id="tra-cuu">
            <h2>Tra cứu Thông tin</h2>
            <p>Tại đây bạn có thể tra cứu giảng viên hoặc các thông tin liên quan.</p>
            <form action="TraCuuServlet" method="get">
                <label for="keyword">Từ khóa:</label>
                <input type="text" id="keyword" name="keyword" placeholder="Nhập từ khóa cần tra cứu..." required>
                <button type="submit">Tìm kiếm</button>
            </form>
            <div id="ket-qua-tra-cuu">
                <h3>Kết quả</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Mã GV</th>
                            <th>Tên Giảng viên</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<GiangVien> giangVienList = (List<GiangVien>) request.getAttribute("giangVienList");
                            if (giangVienList != null && !giangVienList.isEmpty()) {
                                for (GiangVien gv : giangVienList) {
                        %>
                        <tr>
                            <td><%= gv.getMaGv() %></td>
                            <td><%= gv.getTenGv() %></td>
                        </tr>
                        <%
                                }
                            } else if (request.getParameter("keyword") != null) {
                        %>
                        <tr><td colspan="2">Không tìm thấy kết quả.</td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
    <footer>
        <p>© 2025 Trường Đại học CNTT & Truyền thông</p>
    </footer>

    <script>
	    function showTab(event, tabId) {
	        event.preventDefault();
	        const sections = document.querySelectorAll('main section');
	        sections.forEach(section => section.classList.remove('active'));
	        const activeSection = document.getElementById(tabId);
	        if (activeSection) {
	            activeSection.classList.add('active');
	            window.location.hash = tabId; // Cập nhật URL để hỗ trợ refresh
	        } else {
	            console.log("Section not found for tabId:", tabId);
	        }
	    }
	
	    document.querySelectorAll('nav a').forEach(link => {
	        link.addEventListener('click', function(e) {
	            const tabId = this.getAttribute('href').substring(this.getAttribute('href').indexOf('#') + 1 || this.getAttribute('href').lastIndexOf('/') + 1);
	            showTab(e, tabId);
	        });
	    });
	
	    window.onload = function() {
	        <% String activeSection = (String) request.getAttribute("activeSection"); %>
	        <% if (activeSection != null) { %>
	            showTab({ preventDefault: () => {} }, "<%= activeSection %>");
	        <% } else { %>
	            const hash = window.location.hash.substring(1);
	            if (hash) {
	                showTab({ preventDefault: () => {} }, hash);
	            } else {
	                showTab({ preventDefault: () => {} }, "home");
	            }
	        <% } %>
	    };
	</script>
</body>
</html>   -->