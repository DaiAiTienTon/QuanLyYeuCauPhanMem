package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LopHocPhan;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/QuanLyDangKyServlet")
public class QuanLyDangKyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public QuanLyDangKyServlet() {
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
            // Lấy danh sách lớp học phần có thể đăng ký
            try (PreparedStatement lopHocPhanStmt = conn.prepareStatement(
                    "SELECT * FROM lop_hoc_phan WHERE id NOT IN (SELECT ma_kh FROM dang_ky WHERE ma_sv = ?)")) {
                lopHocPhanStmt.setString(1, maSV);
                try (ResultSet rsLopHocPhan = lopHocPhanStmt.executeQuery()) {
                    List<LopHocPhan> lopHocPhanList = new ArrayList<>();
                    while (rsLopHocPhan.next()) {
                        LopHocPhan lhp = new LopHocPhan(rsLopHocPhan.getString("ma_lhp"), rsLopHocPhan.getString("ten_hoc_phan"),
                                rsLopHocPhan.getInt("so_tin_chi"), rsLopHocPhan.getString("trang_thai"),
                                rsLopHocPhan.getString("thoi_gian"), rsLopHocPhan.getString("dia_diem"),
                                rsLopHocPhan.getString("giang_vien"), rsLopHocPhan.getInt("si_so"),
                                rsLopHocPhan.getInt("da_dk"));
                        lopHocPhanList.add(lhp);
                    }
                    request.setAttribute("lopHocPhanList", lopHocPhanList);
                }
            }

            // Lấy danh sách lớp học phần đã đăng ký
            try (PreparedStatement dangKyStmt = conn.prepareStatement(
                    "SELECT lhp.* FROM lop_hoc_phan lhp JOIN dang_ky dk ON lhp.ma_kh = dk.ma_kh WHERE dk.ma_sv = ?")) {
                dangKyStmt.setString(1, maSV);
                try (ResultSet rsDangKy = dangKyStmt.executeQuery()) {
                    List<LopHocPhan> dangKyList = new ArrayList<>();
                    while (rsDangKy.next()) {
                        LopHocPhan lhp = new LopHocPhan(rsDangKy.getString("ma_lhp"), rsDangKy.getString("ten_hoc_phan"),
                                rsDangKy.getInt("so_tin_chi"), rsDangKy.getString("trang_thai"),
                                rsDangKy.getString("thoi_gian"), rsDangKy.getString("dia_diem"),
                                rsDangKy.getString("giang_vien"), rsDangKy.getInt("si_so"),
                                rsDangKy.getInt("da_dk"));
                        dangKyList.add(lhp);
                    }
                    request.setAttribute("dangKyList", dangKyList);
                }
            }

            request.setAttribute("activeSection", "quan-ly-dang-ky");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String maSV = (String) session.getAttribute("maSV");
        String maLhp = request.getParameter("maLhp");
        String action = request.getParameter("action");

        try (Connection conn = ConnectionFactory.getConnection()) {
            if ("register".equals(action)) {
                // Lấy ma_kh từ lop_hoc_phan dựa trên ma_lhp
                String maKh = null;
                try (PreparedStatement stmt = conn.prepareStatement(
                        "SELECT ma_kh FROM lop_hoc_phan WHERE ma_lhp = ?")) {
                    stmt.setString(1, maLhp);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            maKh = rs.getString("ma_kh");
                        }
                    }
                }

                if (maKh != null) {
                    // Chèn vào bảng dang_ky với ma_kh hợp lệ
//                	boolean daDangKy = false;
//                	try(PreparedStatement stmt = conn.prepareStatement(
//                			"select * from dang_ky where ma_sv = ? and ma_kh = ?"
//                			);) {
//						stmt.setString(1, maSV);
//						stmt.setString(2, maKh);
//						try(ResultSet rsCheck = stmt.executeQuery();) {
//							if(rsCheck.next()) {
//								daDangKy = true;
//							}
//						} 
//					} 
//                	
//                	if(daDangKy) {
//                		response.getWriter().println("<scrip>alert('bạn đã đăng ký học phần này')</scrip>");
//                	}
//                	e
                    try (PreparedStatement stmt = conn.prepareStatement(
                            "INSERT INTO dang_ky (ma_sv, ma_kh, thoigian_dangky, trang_thai) VALUES (?, ?, CURDATE(), 'Đã đăng ký')")) {
                        stmt.setString(1, maSV);
                        stmt.setString(2, maKh); // Sử dụng ma_kh thay vì ma_lhp
                        stmt.executeUpdate();
                    }
                } else {
                    response.getWriter().println("Lỗi: Không tìm thấy mã khóa học cho lớp học phần này.");
                    return;
                }
            } else if ("cancel".equals(action)) {
                try (PreparedStatement stmt = conn.prepareStatement(
                        "DELETE FROM dang_ky WHERE ma_sv = ? AND ma_kh = (SELECT ma_kh FROM lop_hoc_phan WHERE ma_lhp = ?)")) {
                    stmt.setString(1, maSV);
                    stmt.setString(2, maLhp);
                    stmt.executeUpdate();
                }
            }
            response.sendRedirect("QuanLyDangKyServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
}