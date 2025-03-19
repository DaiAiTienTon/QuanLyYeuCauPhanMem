<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.GiangVien" %>
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