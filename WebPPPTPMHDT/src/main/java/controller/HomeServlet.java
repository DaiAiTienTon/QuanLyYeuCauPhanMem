package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LichHoc;
import model.LopHocPhan;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String maSV = (String) session.getAttribute("maSV");
        try (Connection conn = ConnectionFactory.getConnection()) {
            // Lấy lịch học
            try (PreparedStatement lichHocStmt = conn.prepareStatement(
                    "SELECT lh.* FROM lich_hoc lh JOIN dang_ky dk ON lh.ma_kh = dk.ma_kh WHERE dk.ma_sv = ?")) {
                lichHocStmt.setString(1, maSV);
                try (ResultSet rsLichHoc = lichHocStmt.executeQuery()) {
                    List<LichHoc> lichHocList = new ArrayList<>();
                    while (rsLichHoc.next()) {
                        LichHoc lh = new LichHoc(rsLichHoc.getString("ma_kh"), rsLichHoc.getString("phong_hoc"),
                                rsLichHoc.getString("thu"), rsLichHoc.getString("tiet_hoc"));
                        lichHocList.add(lh);
                    }
                    request.setAttribute("lichHocList", lichHocList);
                }
            }

            // Lấy danh sách lớp học phần có thể đăng ký
            try (PreparedStatement lopHocPhanStmt = conn.prepareStatement(
                    "SELECT * FROM lop_hoc_phan WHERE id NOT IN (SELECT ma_kh FROM dang_ky WHERE ma_sv = ?)")) {
                lopHocPhanStmt.setString(1, maSV);
                try (ResultSet rsLopHocPhan = lopHocPhanStmt.executeQuery()) {
                    List<LopHocPhan> lopHocPhanList = new ArrayList<>();
                    while (rsLopHocPhan.next()) {
                        LopHocPhan lhp = new LopHocPhan(rsLopHocPhan.getString("ma_lhp"), rsLopHocPhan.getString("ten_hoc_phan"),
                                rsLopHocPhan.getInt("so_tin_chi"), rsLopHocPhan.getString("trang_thai"));
                        lopHocPhanList.add(lhp);
                    }
                    request.setAttribute("lopHocPhanList", lopHocPhanList);
                }
            }

            request.setAttribute("activeSection", "home");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}