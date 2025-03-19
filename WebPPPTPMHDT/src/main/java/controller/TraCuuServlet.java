package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GiangVien;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class TraCuuServlet
 */
@WebServlet("/TraCuuServlet")
public class TraCuuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TraCuuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            try (Connection conn = ConnectionFactory.getConnection()) {
                String gvQuery = "SELECT * FROM giang_vien WHERE ten_gv LIKE ?";
                PreparedStatement gvStmt = conn.prepareStatement(gvQuery);
                gvStmt.setString(1, "%" + keyword + "%");
                ResultSet rsGv = gvStmt.executeQuery();
                List<GiangVien> giangVienList = new ArrayList<>();
                while (rsGv.next()) {
                    GiangVien gv = new GiangVien(rsGv.getString("ma_gv"), rsGv.getString("ten_gv"));
                    giangVienList.add(gv);
                }
                request.setAttribute("giangVienList", giangVienList);
                rsGv.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("activeSection", "tra-cuu");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
