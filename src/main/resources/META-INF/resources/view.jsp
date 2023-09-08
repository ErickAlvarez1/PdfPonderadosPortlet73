<%@ include file="./init.jsp" %>

<portlet:resourceURL id="/prevencion/savePdf" var="postSavePdf" />
<portlet:resourceURL id="/prevencion/saveTxtPdf" var="postSaveTxtPdf" />
<portlet:resourceURL id="/prevencion/saveImg" var="postSaveImg" />
<portlet:resourceURL id="/prevencion/getTxtTema" var="getTxtTema" />
<portlet:resourceURL id="/prevencion/getListRecomendacion" var="getListRecomendacion" />

<c:set var="versionP" scope="session" value="V.1.0.7" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/print-pantalla.css?v=${versionP}" media="print"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/custom.css?v=${versionP}" media="screen"/>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">

<head>
  <meta charset="UTF-8">
</head>
<section id="sinInfo" ${auxHide1}>
	<p class="font-weight-bold h1-responsive text-center">Ponderado sin información</p>
</section>

<section id="info" ${auxHide2}>
	<p class="font-weight-bold h1-responsive text-center printHide"></p>
	<form method="post" action="#" id="printJS-form">
		<div class="container">
			<div class="row">
				<div class="col-md-2">
					<img class="img-fluid" src="<%=request.getContextPath()%>/img/iconTmx.png" alt="Sample image">
				</div>
				<div class="col-md-10 colorBack" >
					<h3 class="text-center">TOKIO MARINE COMPAÑÍA DE SEGUROS S.A DE C.V.</h3>
				</div>
			</div>
			
			<div style="position: relative;">
<%-- 				<liferay-ui:success key="consultaExitosa" message="Exito" /> --%>
				<liferay-ui:error key="errorDesconocido" message="Sin información guardada" />
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<img class="img-center" src="<%=request.getContextPath()%>/img/Imagen1.png">
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
				<fmt:formatDate pattern="dd-MM-yyyy" value="${fechaFormat}" var="fDateAux" />
				<c:set var="fDate"  value="${fDateAux}" />
                    <div class="md-form form-picker">
<%-- 						<input placeholder="Fecha" type="date" id="date_fecha" name="date_fecha" class="form-control datepicker validaTxtDate validaTxt" value="${fechaDoc}" ${auxDisabled}> --%>
						<input placeholder="Fecha" type="date" id="date_fecha" name="date_fecha" class="form-control datepicker validaTxtDate validaTxt" value="08-07-2020" ${auxDisabled}>
                    </div>
                </div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="md-form">
	                    <input type="text" id="txt_evaluacion" name="txt_evaluacion" class="form-control validaTxt datoTxt" value="${reporte}">
	                    <label for="txt_evaluacion">Reporte de evaluación:</label>
	                </div>
				</div>

				<div class="col-md-6">
					<div class="md-form">
	                    <input type="text" id="txt_direccion" name="txt_direccion" class="form-control validaTxt" value="${direccion}">
	                    <label for="txt_direccion">Dirección:</label>
	                </div>
				</div>
				<div class="col-md-4">
					<div class="md-form">
	                    <input type="text" id="txt_tel" name="txt_tel" class="form-control validaTxt" value="${telefonos}">
	                    <label for="txt_tel">Números telefónicos:</label>
	                </div>
				</div>
				<div class="col-md-4">
					<div class="md-form">
	                    <input type="text" id="txt_email" name="txt_email" class="form-control validaTxt" value="${email}">
	                    <label for="txt_email">Correo electrónico:</label>
	                </div>
				</div>
				<div class="col-md-4">
					<div class="md-form">
	                    <input type="text" id="txt_contacto" name="txt_contacto" class="form-control validaTxt" value="${contactos}">
	                    <label for="txt_contacto">Contactos:</label>
	                </div>
				</div>
			</div>
			
			<div class="row mt-5">
			
				<div class="col-md-12 mt-5">
					<p class="font-weight-bold h3-responsive text-center">Objetivo</p>
				</div>
				<div class="col-md-12">
					<p class="text-justify">
						Realizar una Evaluación de Riesgos en Transporte que nos permita conocer el porcentaje de confianza de los proveedores dedicados a la operación de distribución y transporte de mercancías de nuestro asegurado.
					</p>
				</div>
				<div class="col-md-12">
					<div class="md-form" style="margin-top: 0px;">
						<c:choose>
							<c:when test="${isCliente != 1}">
								<textarea id="txt_objetivo" name="txt_objetivo" class="txtAreaCustom" rows="3" placeholder="Texto libre" maxlength="1700">${objetivo}</textarea>
							</c:when>
							<c:otherwise>
								<div>${objetivo}</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col-md-12 mt-5">
					<p class="font-weight-bold h3-responsive text-center mt-5">Alcance</p>
				</div>
				<div class="col-md-12">
					<p class="text-justify">
						Con base en la Evaluación realizada por el área de Prevención de Riesgos en Transporte para nuestro cliente ${nombreAsegurado}; a continuación, se describe el cumplimiento de los criterios analizados para conocer el porcentaje de confianza para la operación de distribución de motocicletas propiedad de nuestro asegurado.
					</p>
				</div>
				<div class="col-md-12">
					<div class="md-form" style="margin-top: 0px;">
						<c:choose>
							<c:when test="${isCliente != 1}">
								<textarea id="txt_alcance" name="txt_alcance" class="txtAreaCustom" rows="3" placeholder="Texto libre" maxlength="1700">${alcance}</textarea>
							</c:when>
							<c:otherwise>
								<div>${alcance}</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<!-- ------------------------------------------------------------------------------------------------------------------------------ -->
				<!-- ------------------------------------------------------TEMAS------------------------------------------------------------------- -->
				<!-- ------------------------------------------------------------------------------------------------------------------------------ -->
				
				<c:forEach items="${cuestionario}" var="opc" varStatus="loop">
					<div class="col-md-12 mt-5">
						<p class="font-weight-bold h3-responsive text-center mt-5">${opc.descripcion}</p>
					</div>
					<div class="col-md-12">
						<div class="md-form" style="margin-top: 0px;">
							<c:choose>
								<c:when test="${isCliente != 1}">
									<textarea id="txt_${opc.idTema}" name="txt_${opc.idTema}" class="txtAreaCustom datoTxt txtAreaDato" data="${opc.idTema}" rows="3" placeholder="Texto libre" maxlength="850"></textarea>
								</c:when>
								<c:otherwise>
									<div class="txtAreaDato"></div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
				
				<!-- ------------------------------------------------------------------------------------------------------------------------------ -->
				<!-- --------------------------------FIN-------------------TEMAS------------------------------------------------------------------- -->
				<!-- ------------------------------------------------------------------------------------------------------------------------------ -->
				
				
				<div class="col-md-12 mt-5">
					<p class="font-weight-bold h3-responsive text-center mt-5">RESULTADO DE EVALUACIÓN.</p>
				</div>
				<div class="col-md-12">
					<p class="text-justify">
						La siguiente gráfica radial muestra el porcentaje de cumplimiento de cada uno de los criterios evaluados por TMX, así mismo se muestra el resultado general del nivel de confianza de la organización; lo que nos permite mostrar a nuestro asegurado el resultado actual de
						<span>
							<c:choose>
								<c:when test="${isCliente != 1}">
									<input type="text" id="txt_" name="txt_" class="txtInLine validaTxt" placeholder="          texto libre" value="${resultadoEva}">
								</c:when>
								<c:otherwise>
									${resultadoEva}
								</c:otherwise>
							</c:choose>
						</span>
						para el servicio de distribución de productos y mercancías propiedad de ${nombreAsegurado}.
					</p>
				</div>
				
				<div class="col-md-12 mt-5">
					<p class="font-weight-bold h3-responsive text-center mt-5">CONCLUSIONES.</p>
				</div>
				<div class="col-md-12">
					<p class="text-justify">
<%-- 						Como resultado de nuestra evaluación, se puede concluir que el nivel de riesgo del proveedor  <span><input type="text" id="txt_conclu1" name="txt_conclu1" class="txtInLine validaTxt datoTxt" placeholder="          texto libre" value="${conclu1}"></span>  es <span><input type="text" id="txt_conclu2" name="txt_conclu2" class="txtInLine validaTxt datoTxt" placeholder="          texto libre" value="${conclu2}"></span>  La administración de los factores humanos, tecnológicos y organizacionales es <span><input type="text" id="txt_conclu3" name="txt_conclu3" class="txtInLine validaTxt datoTxt" placeholder="          texto libre" value="${conclu3}"></span> para la operación de ${nombreAsegurado}.   --%>
						Como resultado de nuestra evaluación, se puede concluir que el nivel de riesgo del proveedor  ${nombreTransporte}  es 
						<span>
							<c:choose>
								<c:when test="${isCliente != 1}">
									<input type="text" id="txt_conclu2" name="txt_conclu2" class="txtInLine validaTxt datoTxt" placeholder="          texto libre" value="${conclu2}">
								</c:when>
								<c:otherwise>
									${conclu2}.
								</c:otherwise>
							</c:choose>
						</span>
						La administración de los factores humanos, tecnológicos y organizacionales es
						<span>
							<c:choose>
								<c:when test="${isCliente != 1}">
									<input type="text" id="txt_conclu3" name="txt_conclu3" class="txtInLine validaTxt datoTxt" placeholder="          texto libre" value="${conclu3}">
								</c:when>
								<c:otherwise>
									${conclu3}
								</c:otherwise>
							</c:choose>
						</span>
						para la operación de ${nombreAsegurado}.  
					</p>
				</div>
				<div class="col-md-12">
					<div class="md-form" style="margin-top: 0px;">
						<c:choose>
							<c:when test="${isCliente != 1}">
								<textarea id="txt_conclu4" name="txt_conclu4" class="txtAreaCustom" rows="3" placeholder="Texto libre" maxlength="1700">${conclu4}</textarea>
							</c:when>
							<c:otherwise>
								<div>${conclu4}</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
			</div>
			
				
				
			<div id="divRecomendaciones">
			<c:choose>
				<c:when test="${flagData == 1}">
					
					<c:forEach items="${listRecomenda}" var="opc" varStatus="loop">
						<c:set var="auxIndex" value="${loop.index}" scope="request" />
						<c:set var="curRecomendacionTxt" value="${opc.recomendacionText}" scope="request" />
						<c:choose>
							<c:when test="${opc.plazo == 1}">
								<c:set var="strPlazo1" value="checked" scope="request" />
								<c:set var="strPlazo2" value="" scope="request" />
								<c:set var="strPlazo3" value="" scope="request" />
							</c:when>
							<c:when test="${opc.plazo == 2}">
								<c:set var="strPlazo1" value="" scope="request" />
								<c:set var="strPlazo2" value="checked" scope="request" />
								<c:set var="strPlazo3" value="" scope="request" />
							</c:when>
							<c:when test="${opc.plazo == 3}">
								<c:set var="strPlazo1" value="" scope="request" />
								<c:set var="strPlazo2" value="" scope="request" />
								<c:set var="strPlazo3" value="checked" scope="request" />
							</c:when>
						</c:choose>
						<c:set var="curCheckResponsabe1" value=" ${opc.responsable1 ? 'checked' : '' } " scope="request" />
						<c:set var="curCheckResponsabe2" value=" ${opc.responsable2 ? 'checked' : '' } " scope="request" />
						<c:set var="curCheckResponsabe3" value=" ${opc.responsable3 ? 'checked' : '' } " scope="request" />
						<c:choose>
							<c:when test="${opc.prioridad == 1}">
								<c:set var="curPrioridad1" value="checked" scope="request" />
								<c:set var="curPrioridad2" value="" scope="request" />
								<c:set var="curPrioridad3" value="" scope="request" />
							</c:when>
							<c:when test="${opc.prioridad == 2}">
								<c:set var="curPrioridad1" value="" scope="request" />
								<c:set var="curPrioridad2" value="checked" scope="request" />
								<c:set var="curPrioridad3" value="" scope="request" />
							</c:when>
							<c:when test="${opc.prioridad == 3}">
								<c:set var="curPrioridad1" value="" scope="request" />
								<c:set var="curPrioridad2" value="" scope="request" />
								<c:set var="curPrioridad3" value="checked" scope="request" />
							</c:when>
						</c:choose>
						<c:set var="curAnio" value="${opc.anio}" scope="request" />
						<c:set var="curMes" value="${opc.mes}" scope="request" />
						<c:set var="temaDinamico" value="${opc.tema}" scope="request" />
						<c:set var="preguntaDinacimo" value="${opc.pregunta}" scope="request" />
						
						<c:if test="${loop.first}">
							<jsp:include page="recomendacion.jsp" />
						</c:if>
						<c:if test="${!loop.first}">
							<jsp:include page="recomendacionNoFirst.jsp" />
						</c:if>
					</c:forEach>
					
				</c:when>
				<c:otherwise>
					<c:set var="countAux" value="${0}"/>
<%-- 					<jsp:include page="recomendacionEmpty.jsp" /> --%>
					<c:forEach items="${cuestionario}" var="opc" varStatus="loop">
						<c:set var="curTemaRecomenda" value="${opc.descripcion}" scope="request" />
						<c:forEach items="${opc.listSubtema}" var="subOpc" varStatus="subLoop">
							<c:forEach items="${subOpc.listRespuesta}" var="pregOpc" varStatus="pregLoop">
								<c:if test = "${pregOpc.evidencia == false}">
									<c:set var="curPreguntaRecomenda" value="${pregOpc.descripcion}" scope="request" />
									<c:set var="auxIndex" value="${countAux}" scope="request" />
									
									<c:choose>
										<c:when test="${countAux == 0}">
											<jsp:include page="recomendacionEmpty.jsp" />
										</c:when>
										<c:otherwise>
											<jsp:include page="recomendacionEmptyNoFirst.jsp" />
										</c:otherwise>
									</c:choose>
									
									<c:set var="countAux" value="${countAux + 1}"/>
								</c:if>
							</c:forEach>
						</c:forEach>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			</div>
			
			<div class="row mt-5">
				<div class="col-md-12 mt-5">
					<p class="font-weight-bold h3-responsive text-center">Anexo fotográfico</p>
				</div>
			</div>
				
			<form class="md-form">
				<div id="imgExistentes" class="row">
					<c:forEach items="${listImg}" var="opc" varStatus="loop">
						<div class="col-md-3 cardImg" data="${opc.idImg}">
							<!-- Card -->
							<div class="card card-image" style="background-image: url(${opc.url});">
								<!-- Content -->
								<div class="text-white text-center d-flex align-items-center py-5 px-4">
								    <div>
								    </div>
								</div>
								<div class="card-footer" style="border:none;">
									<a href="${opc.url}" target="_blank" class="btn btn-blue btn-sm float-left">${opc.nombre}</a>
									<a class="btnCloseImg"><i class="fas fa-trash-alt text-white float-right mt-3"></i></a>
								</div>
							</div>
							<!-- Card -->
						</div>
					</c:forEach>
				</div>
				<c:if test="${isCliente != 1}">
					<div class="row">
						<div class="col-md-11">
							<div class="file-field">
								<div class="btn btn-primary btn-sm float-left">
									<span>Elegir archivo</span>
									<input id="image01" class="inputImg" type="file" accept="image/jpeg, image/png">
								</div>
								<div class="file-path-wrapper">
									<input class="file-path validate" type="text" placeholder="Elige tu archivo">
								</div>
							</div>
						</div>
						<div class="col-md-1">
							<a id="btnAdd"><i class="fas fa-plus"></i></a>
						</div>
					</div>
					<div id="divFiles">
						<div class="row">
							<div class="col-md-11">
								<div class="file-field">
									<div class="btn btn-primary btn-sm float-left">
										<span>Elegir archivo</span>
										<input type="file" class="inputImg" accept="image/jpeg, image/png">
									</div>
									<div class="file-path-wrapper">
										<input class="file-path validate" type="text">
									</div>
								</div>
							</div>
							<div class="col-md-1">
								<a class="btnClose"><i class="fas fa-trash-alt"></i></a>
							</div>
						</div>
					</div>
				</c:if>
			</form>
			
		</div>
	</form>
	<div class="row">
		<div class="col-md-12 printHide d-flex justify-content-center">
			<c:if test="${isCliente == 1}">
				<a href="${ urlFinal }/lista-ponderados?idSolicitud=${ idSolicitud }" class="btn btn-info"> Regresar </a>	
			</c:if>
			<button id="btnSavePdf" class="btn btn-pink" id="btn-save" onclick="postSaveCampos()">Guardar</button>
			<button id="btnPrintPdf" type="button" class="btn btn-primary" onclick="fPrintPantalla()" disabled="disabled">Imprimir</button>
<!-- 			<button type="button" class="btn btn-primary" onclick="printHtml2()">Imprimir</button> -->
		</div>
	</div>
</section>




<section id="formPrint">
	<div class="page-header" style="text-align: center">
		<div class="row row-header">
			<div class="col-md-10" >
				<h3 class="text-center"> </h3>
			</div>
			<div class="col-md-2">
				<img class="img-fluid" src="<%=request.getContextPath()%>/img/iconTmx.png" alt="Sample image" width="90" height="90">
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-center" style="color:#01579b !important;">TOKIO MARINE COMPAÑÍA DE SEGUROS S.A. DE C.V.</h5>
		</div>
	</div>
	
<div class="page">
	<div class="row">
		<div class="col-md-12">
			<img class="img-center" src="<%=request.getContextPath()%>/img/Imagen1.png" width="700" height="350">
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="col-md-2" style="background-color: #4285f4 !important;padding: 10px;">
<%-- 			<p id="printFecha" class="text-center" style="color: white !important;margin: 0;">${ponderado.fecha}</p> --%>
			<p id="printFecha" class="text-center" style="color: white !important;margin: 0;">${fechaDoc}</p>
		</div>
		<div class="col-md-10" style="background-color: #4285f4cf !important;padding: 10px;">
			<p class="text-center" style="color: white !important;margin: 0;">PREVENCIÓN DE RIESGOS EN TRANSPORTE.</p>
		</div>
	</div>
	
	<div class="row mt-4">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Reporte de Evaluación:</h5>
			<p id="printReporte" class="text-center">${evaluacion}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Elaborado para:</h5>
			<p class="text-center">${nombreAsegurado}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Dirección:</h5>
			<p id="pDireccion" class="text-center">${direccion}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Números telefónicos:</h5>
			<p id="ptel" class="text-center">${telefonos}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Correo electrónico:</h5>
			<p id="pMail" class="text-center">${email}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Contactos:</h5>
			<p id="pContacto" class="text-center">${contactos}</p>
		</div>
	</div>

	<div class="row mt-1">
		<div class="col-md-12">
			<p class="text-bold">Distribución:</p>
			<p>- ${nombreAsegurado}</p>
			<p>- TMX - ${tipNegocio}</p>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<h5 class="text-bold text-center">Elaborado por:</h5>
			<p class="text-center">${nombreEvaluador}</p>
			<p class="text-center">Tel: (01 55) 5278 2100</p>
			<p class="text-center"><a href="mailto:prevencion@tokiomarine.com.mx">prevencion@tokiomarine.com.mx</a></p>
		</div>
	</div>
	
	<div class="row divNewPage">
		<div class="col-md-12">
			<h5 class="text-bold text-center">ÍNDICE</h5>
		</div>
		
		<div class="col-md-12 mt-5">
			<a class="text-justify mt-5" href="#cap-1" style="font-size: 20px; margin-left: 100px;">1.- Objetivo / Alcance </a>
		</div>
		<div class="col-md-12">
			<a class="text-justify" href="#cap-2" style="font-size: 20px; margin-left: 100px;">2.- Informe de Evaluación</a>
		</div>
		<div class="col-md-12">
			<a class="text-justify" href="#cap-3" style="font-size: 20px; margin-left: 100px;">3.- Resultado de Evaluación</a>
		</div>
		<div class="col-md-12">
			<a class="text-justify" href="#cap-4" style="font-size: 20px; margin-left: 100px;">4.- Conclusiones</a>
		</div>
		<div class="col-md-12">
			<a class="text-justify" href="#cap-5" style="font-size: 20px; margin-left: 100px;">5.- Recomendaciones</a>
		</div>
		<div class="col-md-12">
			<a class="text-justify" href="#cap-6" style="font-size: 20px; margin-left: 100px;">6.- Anexo Fotográfico</a>
		</div>
		
<!-- 		<div class="col-md-12 mt-5"> -->
<!-- 			<h5 class="text-justify mt-5">1.- Objetivo / Alcance...........................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<h5 class="text-justify"    >2.- Informe de Evaluación....................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<h5 class="text-justify"    >3.- Resultado de Evaluación................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<h5 class="text-justify"    >4.- Conclusiones..................................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<h5 class="text-justify"    >5.- Recomendaciones..........................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<h5 class="text-justify"    >6.- Anexo Fotográfico...........................................................................................................<span class="page-number"></span> </h5> -->
<!-- 		</div> -->
		
<!-- 		<div class="table-of-contents"> -->
<!-- 			<ul> -->
<!-- 				<li><a href="#cap-6">6.- Anexo Fotográfico</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
		
	</div>
	
	<div id="cap-1" class="row divNewPage">
		<div class="col-md-12 auxAltura0">
			<h5 class="text-bold text-center">OBJETIVO:</h5>
			<p class="text-justify">Realizar una Evaluación de Riesgos en Transporte que nos permita conocer el porcentaje de confianza de los proveedores dedicados a la operación de distribución y transporte de mercancías de nuestro asegurado.</p>
			<p id="pObjetivo" class="text-justify">${objetivo}</p>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12 auxAltura0">
			<h5 class="text-bold text-center">ALCANCE:</h5>
			<p class="text-justify">Con base en la Evaluación realizada por el área de Prevención de Riesgos en Transporte para nuestro cliente ${nombreAsegurado}; a continuación, se describe el cumplimiento de los criterios analizados para conocer el porcentaje de confianza para la operación de distribución de motocicletas propiedad de nuestro asegurado.</p>
			<p id="pAlcance" class="text-justify">${alcance}</p>
		</div>
	</div>

	<div id="cap-2" class="row mt-5 divNewPage">
		<div class="col-md-12">
			<h5 style="color:#01579b !important;">INFORME DE EVALUACIÓN.</h5>
		</div>
	</div>
	
	<c:forEach items="${cuestionario}" var="opc" varStatus="loop">
	<div class="auxAltura">
	
		<div class="row">	
			<div class="col-md-1" style="border: solid 1px;color: #669cf6 !important;">
			</div>
			<div class="col-md-11" style="background-color: #4285f4cf !important;padding: 10px;">
				<p style="color: white !important;margin: 0;" class="tTit">${opc.descripcion} </p>
			</div>
		</div>
		<div class="row" style="border: solid 1px;color: #669cf6 !important;">
			<div class="col-md-12">
				<p>El proveedor mostro evidencias documentales y registros vigentes de:</p>
			</div>
			<div class="col-md-12 respClass${loop.index} ${resPondeHide1}">
				<br>
				
				<c:set var="total" value="${0}"/>
				<c:set var="count" value="${0}"/>
				
				<c:forEach items="${opc.listSubtema}" var="subOpc" varStatus="subLoop">
					<c:forEach items="${subOpc.listRespuesta}" var="pregOpc" varStatus="pregLoop">						
						
						<c:if test = "${pregOpc.evidencia == true}">
							<p>${pregOpc.descripcion}</p>
						</c:if>						
						
						<c:set var="count" value="${count + 1}"/>
						<c:choose>
						    <c:when test="${pregOpc.respuesta == 1}">
						        <c:set var="ponde" value="${0}" />
						    </c:when>    
						    <c:when test="${pregOpc.respuesta == 2}">
						        <c:set var="ponde" value="${25}" />
						    </c:when> 
						    <c:when test="${pregOpc.respuesta == 3}">
						        <c:set var="ponde" value="${50}" />
						    </c:when> 
						    <c:when test="${pregOpc.respuesta == 4}">
						        <c:set var="ponde" value="${75}" />
						    </c:when> 
						    <c:when test="${pregOpc.respuesta == 5}">
						        <c:set var="ponde" value="${99}" />
						    </c:when> 
						</c:choose>
						<c:set var="total" value="${total + ponde}" /> 
					</c:forEach>
					<c:set var="totalMax" value="${99 * count}" />
				</c:forEach>
				<c:set var="confianza" value="${(total / totalMax) * 100}" />
				<br>
			</div>
			<div class="col-md-12">
				<p class="pDato pDato_${opc.idTema} text-justify" data="${opc.idTema}">${infoLeg}</p>
			</div>
		</div>
		<div class="row" style="border: solid 1px;color: #669cf6 !important;">
			<div class="col-md-9">
			</div>
			<div class="col-md-3">
				<p>Cumplimiento: <span class="tCalif" porcen="${opc.porcentaje}" cTotal="${total}" cTotalMax="${totalMax}" data="${loop.index}"><fmt:formatNumber type = "number" maxFractionDigits = "0" value = "${confianza}" /></span> %</p>
			</div>
			<input type="hidden" class="cTotal" value="${total}">
			<input type="hidden" class="cTotalMax" value="${totalMax}">
		</div>
		
	</div>	
	</c:forEach>
	
	
	<div id="cap-3" class="row mt-5 divNewPage">
		<div class="col-md-12">
			<h5 style="color:#01579b !important;">RESULTADO DE EVALUACIÓN.</h5>
			<p style="text-align: justify;">La siguiente gráfica radial muestra el porcentaje de cumplimiento de cada uno de los criterios evaluados por TMX, así mismo se muestra el resultado general del nivel de confianza de la organización; lo que nos permite mostrar a nuestro asegurado el resultado actual de <span id="txt_Print"></span> para el servicio de distribución de productos y mercancías propiedad de ${nombreAsegurado}.</p>
		</div>
	</div>
	
<!-- 	<div class="row mt-5 auxAltura"> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<div class="row mt-5"> -->
<!-- 				<div class="col-md-12" style="background-color: #4285f4cf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;"> MATRIZ DE EVALUACIÓN </p> -->
<!-- 				</div> -->
				
<!-- 				<div class="col-md-4" style="background-color: #72a5fbcf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">ELEMENTOS EVALUADOS EN LA OPERACIÓN</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2" style="background-color: #72a5fbcf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">% DE IMPORTANCIA</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2" style="background-color: #72a5fbcf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">MÁXIMA CALIFICACIÓN</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2" style="background-color: #72a5fbcf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">CALIFICACIÓN ALCANZADA</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2" style="background-color: #72a5fbcf !important;padding: 10px;border: solid 1px;"> -->
<!-- 					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">% DE CONFIANZA</p> -->
<!-- 				</div> -->
				
<!-- 			</div>	 -->
			
<!-- 			<div id="contenResumen"> -->
<!-- 				Contenido llenado desde JS -->
<!-- 			</div> -->

<!-- 			<div class="row .califFinal"> -->
<!-- 				<div class="col-md-4"> -->
<!-- 					<p></p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2 text-center"> -->
<!-- 					<p>VALORES TOTALES</p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2 text-center"> -->
<!-- 					<p id="pMax"></p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2 text-center" style="border: solid 1px;"> -->
<!-- 					<p id="pObt"></p> -->
<!-- 				</div> -->
<!-- 				<div class="col-md-2 text-center" style="background-color: #72a5fbcf !important; border: solid 1px;"> -->
<!-- 					<p id="pTot"></p> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	<div class="row mt-5 d-flex justify-content-center">
		<div class="col-md-8 divCanvas">
			<canvas id="radarChart"></canvas>
		</div>
	</div>
	
	<div class="row mt-5">
		<div class="col-md-12" style="background-color: #4285f4cf !important;padding: 10px;border: solid 1px;">
			<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">" ESCALA DE RIESGOS POR TMX "</p>
		</div>
		<div class="col-md-10 escalas escala1" style="border: solid 1px;">
			<p>Proveedor de Autotransporte con nulos controles de seguridad y alta probabilidad de siniestralidad.</p>
		</div>
		<div class="col-md-2 escalas escala1" style="border: solid 1px;">
			<p>0 - 40%</p>
		</div>
		<div class="col-md-10 escalas escala2" style="border: solid 1px;">
			<p>Proveedor de Autotransporte con bajos controles de seguridad y probables incidencias de siniestros.</p>
		</div>
		<div class="col-md-2 escalas escala2" style="border: solid 1px;">
			<p>41 - 60%</p>
		</div>
		<div class="col-md-10 escalas escala3" style="border: solid 1px;">
			<p>Proveedor de Autotransporte con medianos controles de seguridad con riesgos controlables.</p>
		</div>
		<div class="col-md-2 escalas escala3" style="border: solid 1px;">
			<p>61 - 80%</p>
		</div>
		<div class="col-md-10 escalas escala4" style="border: solid 1px;">
			<p>Proveedor de Autotransporte con altos controles de seguridad, baja incidencia de siniestralidad.</p>
		</div>
		<div class="col-md-2 escalas escala4" style="border: solid 1px;">
			<p>81 - 99%</p>
		</div>
	</div>
	
	<div id="rowGrafica" class="row mt-5 d-flex justify-content-center ">
<!-- 		<div class="col-md-1"> -->
<!-- 		</div> -->
		<div class="col-md-8">
			<canvas id="horizontalBar" class="divCanvasBar"></canvas>
		</div>
		<div class="col-md-3">
		</div>
	</div>
	
	<div id="cap-4" class="row mt-5 divNewPage auxAltura2">
		<div class="col-md-12">
			<h5 style="color:#01579b !important;">CONCLUSIONES:</h5>
			<p style="text-align: justify;">Como resultado de nuestra evaluación, se puede concluir que el nivel de riesgo del proveedor  ${nombreTransporte}  es <span id="print_conclu2"></span>  La administración de los factores humanos, tecnológicos y organizacionales es <span id="print_conclu3"></span> para la operación de ${nombreAsegurado}.</p>
			<br>
			<p id="pConclu4" style="text-align: justify;"><span id="print_conclu4"></span></p>
			<br>
			<p style="text-align: justify;">Sugerimos, sin embargo, llevar a cabo las siguientes recomendaciones a fin de incrementar los niveles de seguridad en el transporte de mercancías.</p>
			<br>
			<p style="text-align: justify;">“La expedición del presente reporte no garantiza que los siniestros dejen de ocurrir, por lo que el cumplimiento de las recomendaciones y observaciones aquí plasmadas tampoco implica una obligación o compromiso para Tokio Marine Compañía de Seguros, S. A. de C. V.  La inspección y/o evaluación se llevó a cabo en las condiciones de tiempo y espacio al momento de la visita y conforme a la información proporcionada por el evaluado, dichas condiciones pueden variar de un momento a otro.</p>
			<br>
			<p style="text-align: justify;">Será competencia exclusiva del Asegurado, que el proveedor demuestre en todo momento que su operación se apega a estándares de seguridad conforme a lo recomendado en éste reporte.”</p>
			<br>
		</div>
	</div>
	<div class="row auxAltura2">	
		<div class="col-md-12">
			<h5 style="color:#01579b !important;">PRIORIDAD DE LAS RECOMENDACIONES:</h5>
			<br>
			<p style="text-align: justify;">La prioridad A, B y C de las recomendaciones que sugiere TMX:</p>
			<p style="text-align: justify;">A = Aquellas de especial importancia para la seguridad que requieren acción y/o implementación urgente.</p>
			<p style="text-align: justify;">B = Aquellas que requieren un mejoramiento continuo para elevar los estándares de seguridad.</p>
			<p style="text-align: justify;">C = Aquellas que requieren de un análisis e inversión para su implementación en un período de 360 días, y que ayudarán a tener medios adecuados de Control.</p>
			<br>
			<p style="text-align: justify;">La enumeración de las recomendaciones se interpreta de la siguiente forma: “19-01-01: A”. Cada par de dígitos de izquierda a derecha indican: el año en que se realizó la visita, el mes correspondiente al año en que se realizó la visita, el número de recomendación y la letra indica la prioridad sugerida.</p>
			<br>
		</div>
	</div>
	<div class="row auxAltura2">
		<div class="col-md-12">
			<h5 style="color:#01579b !important;">PLAZO DE IMPLEMENTACIÓN </h5>
		</div>
		<div class="col-md-4 divPunto" style="border: solid 1px;">
			<p class="text-center marginNone">3 meses</p>
		</div>
		<div class="col-md-1 divPunto" style="border: solid 1px;">
			<a class="marginNone"><i class="fas fa-circle iRed"></i></a>
		</div>
		<div class="col-md-7"></div>
		<div class="col-md-4 divPunto" style="border: solid 1px;">
			<p class="text-center marginNone">6 meses</p>
		</div>
		<div class="col-md-1 divPunto" style="border: solid 1px;">
			<a class="marginNone"><i class="fas fa-circle iYellow"></i></a>
		</div>
		<div class="col-md-7"></div>
		<div class="col-md-4 divPunto" style="border: solid 1px;">
			<p class="text-center marginNone">12 meses</p>
		</div>
		<div class="col-md-1 divPunto" style="border: solid 1px;">
			<a class="marginNone"><i class="fas fa-circle iGreen"></i></a>
		</div>
		<div class="col-md-7"></div>
	</div>
	
	<div id="printRecomenda">
		<c:choose>
			<c:when test="${flagData == 1}">
				<c:forEach items="${listRecomenda}" var="opc" varStatus="loop">
					<c:set var="auxNewPage" value="${ loop.index == 0 ? '' : 'd-none' }" scope="request" />
					<c:set var="printIndex" value="${loop.index}" scope="request" />
<%-- 					<c:set var="temaDinamico" value="${opc.tema}" scope="request" /> --%>
<%-- 					<c:set var="preguntaDinacimo" value="${opc.pregunta}" scope="request" /> --%>
					<jsp:include page="printRecomendacion.jsp" />
				</c:forEach>
				
			</c:when>
			<c:otherwise>
				<c:set var="countPrint" value="${0}"/>
				<c:forEach items="${cuestionario}" var="opc" varStatus="loop">
					<c:forEach items="${opc.listSubtema}" var="subOpc" varStatus="subLoop">
						<c:forEach items="${subOpc.listRespuesta}" var="pregOpc" varStatus="pregLoop">
							<c:if test = "${pregOpc.evidencia == false}">
							
								<c:set var="printIndex" value="${countPrint}" scope="request" />
								<c:set var="auxNewPage" value="${ countPrint == 0 ? '' : 'd-none' }" scope="request" />
								
								<jsp:include page="printRecomendacion.jsp" />
								
								<c:set var="countPrint" value="${countPrint + 1}"/>
							
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	
		<%--
		<div class="divPrintRecomenda auxAltura2">
			<div class="row mt-5">
				<div id="cap-5" class="col-md-12">
					<h5 style="color:#01579b !important;">RECOMENDACIONES.</h5> 
				</div>
				<div class="col-md-2 divBorder" style="background-color: #4285f4cf !important;padding: 10px;border: solid 1px;">
					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">Recomendación</p>
				</div>
				<div class="col-md-4 divBorder" style="background-color: #4285f4cf !important;padding: 10px;border: solid 1px;">
					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">Área de Mejora</p>
				</div>
				<div class="col-md-6 divBorder" style="background-color: #4285f4cf !important;padding: 10px;border: solid 1px;">
					<p class="text-center" style="color: white !important;margin: 0;font-weight: bold;">Descripción</p>
				</div>
				<div class="col-md-2 divBorder" style="border: solid 1px;">
					<p class="textFormato0 text-center">19-06-01: A</p>
					<p class="text-center">Plazos de Implementación:</p>
					<p id="strPlazo0" class="text-center">${strPlazo}</p>
				</div>
				<div class="col-md-4 divBorder" style="border: solid 1px;">
					<p class="text-center">PROGRAMA DE CAPACITACIÓN</p>
					<p class="text-center">Responsables de la Implementación:</p>
					<p id="txtResponsable1-0" class="text-center">${strRespon}</p>
					<p id="txtResponsable2-0" class="text-center">${strRespon}</p>
					<p id="txtResponsable3-0" class="text-center">${strRespon}</p>
				</div>
				<div class="col-md-6 divBorder" style="border: solid 1px;">
					<p id="pTxtRecomendaciones0" class="text-center">${recomendaciones}</p>
				</div>
			</div>
		</div>
		--%>
	</div>
	
	<article id="cap-6">
		<div class="row mt-5 divNewPage">
			<div class="col-md-12">
				<h5 style="color:#01579b !important;">ANEXO FOTOGRÁFICO:</h5>
			</div>
		</div>
	</article>
	
	<div id="rowImgContent" class="row mt-2">
		<c:if test="${isCliente == 1}">
			<c:forEach items="${listImg}" var="opc" varStatus="loop">
				<div class="col-md-6 mt-3">
					<img src="${opc.url}" class="img-rounded" alt="Cinque Terre">
				</div>
			</c:forEach>
		</c:if>
	</div>

</div>



<!-- 	<footer id="footer"> -->
<%-- 		<p class="font-weight-bold h3-responsive text-center" style="color: grey !important; margin: 0px;">PARA USO EXCUSIVO DE ${nombreAsegurado}</p> --%>
<!-- 		<p class="small" style="color: grey !important; margin: 0px;">Este reporte es de carácter informativo, refleja condiciones observadas durante la visita, analiza y expone a usted posibles riesgos en su cadena logística, sin embargo, no es posible determinar la totalidad de los mismos, por lo cual pueden existir omisiones que no representarán en su caso un motivo para responsabilizar al personal que lo elabora de futuros siniestros. El presente reporte no le informa sobre probables violaciones a disposiciones legales nacionales e internacionales. Este reporte no es una póliza de seguro, ni representa extensión de garantía alguna sobre la posibilidad de reducir riesgos si se cumplen con algunas de las sugerencias descritas en el mismo. Ninguno de los empleados o terceros que han intervenido en la visita y elaboración del presente reporte, podrán considerarse responsables por daños a titulares de los bienes o de terceros por el simple hecho de realizar la visita y el presente reporte.</p>  -->
<!-- 	</footer> -->
		
		
</section>

<section id="formPrintHeaderFotter">
	<div class="page-footer">
		<p class="font-weight-bold h3-responsive text-center" style="color: grey !important; margin: 0px;">PARA USO EXCUSIVO DE ${nombreAsegurado}</p>
		<p class="small" style="color: grey !important; margin: 0px;">Este reporte es de carácter informativo, refleja condiciones observadas durante la visita, analiza y expone a usted posibles riesgos en su cadena logística, sin embargo, no es posible determinar la totalidad de los mismos, por lo cual pueden existir omisiones que no representarán en su caso un motivo para responsabilizar al personal que lo elabora de futuros siniestros. El presente reporte no le informa sobre probables violaciones a disposiciones legales nacionales e internacionales. Este reporte no es una póliza de seguro, ni representa extensión de garantía alguna sobre la posibilidad de reducir riesgos si se cumplen con algunas de las sugerencias descritas en el mismo. Ninguno de los empleados o terceros que han intervenido en la visita y elaboración del presente reporte, podrán considerarse responsables por daños a titulares de los bienes o de terceros por el simple hecho de realizar la visita y el presente reporte.</p> 
	</div>
</section>

<!-- Central Modal Medium Success -->
<div class="modal" id="centralModalSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-notify modal-success modal-dialog-centered" role="document">
	<!--Content-->
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header">
				<p class="heading lead">Éxito</p>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true" class="white-text">&times;</span>
				</button>
			</div>

			<!--Body-->
			<div class="modal-body">
				<div class="text-center text-success">
					<i class="fas fa-check fa-4x mb-3 animated zoomInDown animation-delay-5"></i>
				</div>
			</div><!--  -->
			<!--Footer-->
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-success" data-dismiss="modal">Continuar</button>
<!--         <button type="button" class="btn btn-success">Get it now <i class="far fa-gem ml-1 white-text"></i></button> -->
<!--         <button type="button" class="btn btn-outline-success waves-effect" data-dismiss="modal">No, thanks</button> -->
			</div>
		</div>
	<!--/.Content-->
	</div>
</div>
<!-- Central Modal Medium Success-->

<!-- MODAL CONFIRMAR -->
<div class="modal" id="modalConfirma" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
	<!--Content-->
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header blue-gradient text-white">
				<h3 class="heading lead"> ATENCIÓN </h3>
				
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true" class="white-text">&times;</span>
				</button>
			</div>

			<!--Body-->
			<div class="modal-body">
				<div class="row rowEditTemas">
					<div class="col-md-12 text-center text-primary font-weight-bold">
						<h3>Reporte llenado anteriormente</h3>
					</div>

				</div>

			</div><!--  -->
			<!--Footer-->
			<div class="modal-footer justify-content-center blue-gradient">
				<button type="button" class="btn btn-pink" style="display: none;">Cancelar</button>
				<button onclick="llenaRespuestas();" type="button" class="btn btn-blue">Aceptar</button>
			</div>
		</div>
	<!--/.Content-->
	</div>
</div>
<!-- MODAL CONFIRMAR -->

<div id="etiquetas" hidden="true">
	<input type="hidden" id="postSavePdf" value="${postSavePdf}">
	<input type="hidden" id="postSaveTxtPdf" value="${postSaveTxtPdf}">
	<input type="hidden" id="postSaveImg" value="${postSaveImg}">
	<input type="hidden" id="postGetTxtTema" value="${getTxtTema}">
	<input type="hidden" id="postGetListRecomendacion" value="${getListRecomendacion}">
	
	<input type="hidden" id="idSolicitud" value="${idSolicitud}">
	<input type="hidden" id="idResultado" value="${idResultado}">
	<input type="hidden" id="proveedorId" value="${proveedorId}">
	<input type="hidden" id="idVinculoSolicitud" value="${idVinculoSolicitud}">
	<input type="hidden" id="ponderadoImpresoBaseId" value="${ponderadoImpresoBaseId}">
	<input type="hidden" id="fDateAux" value="${fDateAux}">
	
</div>

<script type="text/javascript">
	var nombreTransporte = "${nombreTransporte}";
	var nombreAsegurado = "${nombreAsegurado}";
	var flagData = "${flagData}";
	var flagCliente = "${isCliente}";
	var auxSizeG = 0;
	var fechaMinima = "${fechaMinima}";
</script>

<script src="<%=request.getContextPath()%>/js/objetos.js?v=${versionP}"></script>
<script src="<%=request.getContextPath()%>/js/main.js?v=${versionP}"></script>

<style type="text/css">
    
    .incomplete {
        color: red;
    }
</style>