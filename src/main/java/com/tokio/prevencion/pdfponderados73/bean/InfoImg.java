package com.tokio.prevencion.pdfponderados73.bean;

public class InfoImg {
	private String nombre;
	private String url;
	private long idImg;
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public long getIdImg() {
		return idImg;
	}
	public void setIdImg(long idImg) {
		this.idImg = idImg;
	}
	
	@Override
	public String toString() {
		return "InfoImg [nombre=" + nombre + ", url=" + url + ", idImg=" + idImg + "]";
	}
	
}
