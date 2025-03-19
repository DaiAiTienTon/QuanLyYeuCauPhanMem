package model;

public class GiangVien {
    private String maGv;
    private String tenGv;

    public GiangVien(String maGv, String tenGv) {
        this.maGv = maGv;
        this.tenGv = tenGv;
    }

    public String getMaGv() { return maGv; }
    public String getTenGv() { return tenGv; }
}