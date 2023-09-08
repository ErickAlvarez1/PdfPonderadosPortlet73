package com.tokio.prevencion.pdfponderados73.bean;

import java.util.List;

public class ListRecomendacion {
	private List<RecomendacionAux> listRecomendacion;

	public List<RecomendacionAux> getListRecomendacion() {
		return listRecomendacion;
	}

	public void setListRecomendacion(List<RecomendacionAux> listRecomendacion) {
		this.listRecomendacion = listRecomendacion;
	}

	@Override
	public String toString() {
		return "ListRecomendacion [listRecomendacion=" + listRecomendacion + "]";
	}
	
}
