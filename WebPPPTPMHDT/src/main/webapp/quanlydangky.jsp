<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.LopHocPhan" %>
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