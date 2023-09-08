package com.tokio.prevencion.pdfponderados73.bean;

public class RecomendacionAux {
	private int plazo;
	private boolean responsable1;
	private boolean responsable2;
	private boolean responsable3;
	private int prioridad;
	private String anio;
	private String mes;
	private int orden;
	private String recomendacion;
	private String tema;
	private String pregunta;
	
	public int getPlazo() {
		return plazo;
	}
	public void setPlazo(int plazo) {
		this.plazo = plazo;
	}
	public boolean isResponsable1() {
		return responsable1;
	}
	public void setResponsable1(boolean responsable1) {
		this.responsable1 = responsable1;
	}
	public boolean isResponsable2() {
		return responsable2;
	}
	public void setResponsable2(boolean responsable2) {
		this.responsable2 = responsable2;
	}
	public boolean isResponsable3() {
		return responsable3;
	}
	public void setResponsable3(boolean responsable3) {
		this.responsable3 = responsable3;
	}
	public int getPrioridad() {
		return prioridad;
	}
	public void setPrioridad(int prioridad) {
		this.prioridad = prioridad;
	}
	public String getAnio() {
		return anio;
	}
	public void setAnio(String anio) {
		this.anio = anio;
	}
	public String getMes() {
		return mes;
	}
	public void setMes(String mes) {
		this.mes = mes;
	}
	public int getOrden() {
		return orden;
	}
	public void setOrden(int orden) {
		this.orden = orden;
	}
	public String getRecomendacion() {
		return recomendacion;
	}
	public void setRecomendacion(String recomendacion) {
		this.recomendacion = recomendacion;
	}
	public String getTema() {
		return tema;
	}
	public void setTema(String tema) {
		this.tema = tema;
	}
	public String getPregunta() {
		return pregunta;
	}
	public void setPregunta(String pregunta) {
		this.pregunta = pregunta;
	}
	
	@Override
	public String toString() {
		return "RecomendacionAux [plazo=" + plazo + ", responsable1=" + responsable1 + ", responsable2=" + responsable2
				+ ", responsable3=" + responsable3 + ", prioridad=" + prioridad + ", anio=" + anio + ", mes=" + mes
				+ ", orden=" + orden + ", recomendacion=" + recomendacion + ", tema=" + tema + ", pregunta=" + pregunta
				+ "]";
	}
	
}
