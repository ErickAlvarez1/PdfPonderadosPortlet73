function objRecomendacion (plazo, responsable1, responsable2, responsable3, prioridad, anio, mes, orden, recomendacion, tema, pregunta){
	this.plazo = plazo;
	this.responsable1 = responsable1;
	this.responsable2 = responsable2;
	this.responsable3 = responsable3;
	this.prioridad = prioridad;
	this.anio = anio;
	this.mes = mes;
	this.orden = orden;
	this.recomendacion = recomendacion;
	this.tema = tema;
	this.pregunta = pregunta;
}

var ponderado ={
	fecha : "",
	reporte: "",
	direccion: "",
	noTelefonico:"",
	mail: "",
	contacto: "",
	objetivo: "",
	alcance: "",
	resEval: "",
	conclu2: "",
	conclu3: "",
	conclu4: "",
	
	idSolicitud : "",
	idResultado: "",
	proveedorId: "",
	idVinculoSolicitud: ""
};

var ponderadoTxt={
	reporteEvaluacion:"",
	infoLegal: "",
	contexto: "",
	gestionM: "",
	gestionRH: "",		
	restreo: "",
	capacidad: "",
	trafico: "",
	gestionR: "",
	seguridad: "",
	conclu1: "",
	conclu2: "",
	conclu3: ""
};