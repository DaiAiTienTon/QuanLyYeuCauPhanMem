package model;

public class LichHoc {
    private String maKh;
    private String phongHoc;
    private String thu;
    private String tietHoc;

    public LichHoc(String maKh, String phongHoc, String thu, String tietHoc) {
        this.maKh = maKh;
        this.phongHoc = phongHoc;
        this.thu = thu;
        this.tietHoc = tietHoc;
    }

    public String getMaKh() { return maKh; }
    public String getPhongHoc() { return phongHoc; }
    public String getThu() { return thu; }
    public String getTietHoc() { return tietHoc; }
}