package model;

public class LopHocPhan {
    private String maLhp;
    private String tenHocPhan;
    private int soTinChi;
    private String trangThai;
    private String thoiGian;
    private String diaDiem;
    private String giangVien;
    private int siSo;
    private int daDk;

    public LopHocPhan(String maLhp, String tenHocPhan, int soTinChi, String trangThai) {
        this(maLhp, tenHocPhan, soTinChi, trangThai, "", "", "", 0, 0);
    }

    public LopHocPhan(String maLhp, String tenHocPhan, int soTinChi, String trangThai, String thoiGian, 
                      String diaDiem, String giangVien, int siSo, int daDk) {
        this.maLhp = maLhp;
        this.tenHocPhan = tenHocPhan;
        this.soTinChi = soTinChi;
        this.trangThai = trangThai;
        this.thoiGian = thoiGian;
        this.diaDiem = diaDiem;
        this.giangVien = giangVien;
        this.siSo = siSo;
        this.daDk = daDk;
    }

    public String getMaLhp() { return maLhp; }
    public String getTenHocPhan() { return tenHocPhan; }
    public int getSoTinChi() { return soTinChi; }
    public String getTrangThai() { return trangThai; }
    public String getThoiGian() { return thoiGian; }
    public String getDiaDiem() { return diaDiem; }
    public String getGiangVien() { return giangVien; }
    public int getSiSo() { return siSo; }
    public int getDaDk() { return daDk; }
}