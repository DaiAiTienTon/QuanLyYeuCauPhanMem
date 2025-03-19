<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.LichHoc, model.LopHocPhan" %>
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