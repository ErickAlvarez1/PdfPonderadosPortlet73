<%@ include file="/init.jsp" %>

<div class="rowRecomendacion">
	<div class="row mt-5">
		<div class="col-md-11 mt-5">
			<p class="font-weight-bold h3-responsive text-center">Plazos de Implementación.</p>
		</div>
		<div class="col-md-1">
			<p class="font-weight-bold h3-responsive text-center"><a class="closeRecomend" data="${auxIndex}"><i class="fas fa-trash-alt"></i></a></p>
		</div>
	</div>
	
	<div id="rdoPlazo${auxIndex}" class="row d-flex justify-content-around">
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio" style="text-align: center;">
				<input type="radio" class="form-check-input rdoPla" data="${auxIndex}" id="opc-${auxIndex}-1-1" name="group-${auxIndex}-1" value="1" ${strPlazo1}>
				<label class="custom-control-label" for="opc-${auxIndex}-1-1">3 meses</label>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio ">
				<input type="radio" class="form-check-input rdoPla" data="${auxIndex}" id="opc-${auxIndex}-1-2" name="group-${auxIndex}-1" value="2" ${strPlazo2}>
				<label class="custom-control-label" for="opc-${auxIndex}-1-2">6 meses</label>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio">
				<input type="radio" class="form-check-input rdoPla" data="${auxIndex}" id="opc-${auxIndex}-1-3" name="group-${auxIndex}-1" value="3" ${strPlazo3}>
				<label class="custom-control-label" for="opc-${auxIndex}-1-3">12 meses</label>
			</div>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col-md-12 mt-3">
			<p class="font-weight-bold h3-responsive text-center">Responsables de la Implementación:</p>
		</div>
	</div>
	<div id="rdoResponsable${auxIndex}" class="row d-flex justify-content-around">
		<div class="col-md-2 text-center">
		
			<div class="form-check">
				<input type="checkbox" class="form-check-input check1" id="opc-${auxIndex}-2-1" ${curCheckResponsabe1}/>
				<label class="form-check-label" for="opc-${auxIndex}-2-1">${nombreTransporte}</label>
			</div>
		
		</div>
		<div class="col-md-2 text-center">
		
			<div class="form-check">
				<input type="checkbox" class="form-check-input check2" id="opc-${auxIndex}-2-2" ${curCheckResponsabe2}/>
				<label class="form-check-label" for="opc-${auxIndex}-2-2">${nombreAsegurado}</label>
			</div>
		
		</div>
		<div class="col-md-2 text-center">
			<div class="form-check">
				<input type="checkbox" class="form-check-input check3" id="opc-${auxIndex}-2-3" ${curCheckResponsabe3}/>
				<label class="form-check-label" for="opc-${auxIndex}-2-3">TMX (Seguimiento)</label>
			</div>
		
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="col-md-12 mt-3">
			<p class="font-weight-bold h5-responsive text-center">Prioridad de las recomendaciones</p>
		</div>
	</div>
	
	<div id="rdoTipoReco" class="row d-flex justify-content-around">
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio toolcustom" style="text-align: center;">
				<input type="radio" class="form-check-input rdoTipo" data="${auxIndex}" id="opc-${auxIndex}-3-1" name="group-${auxIndex}-3" value="1" ${curPrioridad1}>
				<label class="custom-control-label" for="opc-${auxIndex}-3-1">A</label>
				<span class="tooltext">Aquellas de especial importancia para la seguridad que requieren acción y/o implementación urgente</span>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio toolcustom">
				<input type="radio" class="form-check-input rdoTipo" data="${auxIndex}" id="opc-${auxIndex}-3-2" name="group-${auxIndex}-3" value="2" ${curPrioridad2}>
				<label class="custom-control-label" for="opc-${auxIndex}-3-2">B</label>
				<span class="tooltext"> Aquellas que requieren un mejoramiento continuo para elevar los estándares de seguridad</span>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<div class="custom-control custom-radio toolcustom">
				<input type="radio" class="form-check-input rdoTipo" data="${auxIndex}" id="opc-${auxIndex}-3-3" name="group-${auxIndex}-3" value="3" ${curPrioridad3}>
				<label class="custom-control-label" for="opc-${auxIndex}-3-3">C</label>
				<span class="tooltext">Aquellas que requieren de un análisis e inversión para su implementación en un período de 360 días, y que ayudarán a tener medios adecuados de Control</span>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate var="year" value="${now}" pattern="yyyy" />
			<fmt:formatDate var="yearId" value="${now}" pattern="yy" />
			<div class="md-form form-group" style="margin-top:0px;">
				<select id="selAnio${auxIndex}" name="selAnio${auxIndex}" class="mdb-select classSelAnio">
					<option value="${yearId}" ${yearId == curAnio ? 'selected' : ''}>${year}</option>
					<option value="${yearId + 1}" ${(yearId+1) == curAnio ? 'selected' : ''}>${year + 1}</option>
				</select>
				<label for="selAnio${auxIndex}">Año</label>
			</div>
		</div>
		<div class="col-md-2 text-center">
			<div class="md-form form-group" style="margin-top:0px;">
				<select id="selMes${auxIndex}" name="selMes${auxIndex}" class="mdb-select classSelMes">
					<option value="01" ${curMes == 01 ? 'selected' : ''}>Enero</option>
					<option value="02" ${curMes == 02 ? 'selected' : ''}>Febrero</option>
					<option value="03" ${curMes == 03 ? 'selected' : ''}>Marzo</option>
					<option value="04" ${curMes == 04 ? 'selected' : ''}>Abril</option>
					<option value="05" ${curMes == 05 ? 'selected' : ''}>Mayo</option>
					<option value="06" ${curMes == 06 ? 'selected' : ''}>Junio</option>
					<option value="07" ${curMes == 07 ? 'selected' : ''}>Julio</option>
					<option value="08" ${curMes == 08 ? 'selected' : ''}>Agosto</option>
					<option value="09" ${curMes == 09 ? 'selected' : ''}>Septiembre</option>
					<option value="10" ${curMes == 10 ? 'selected' : ''}>Octubre</option>
					<option value="11" ${curMes == 11 ? 'selected' : ''}>Noviembre</option>
					<option value="12" ${curMes == 12 ? 'selected' : ''}>Diciembre</option>
				</select>
				<label for="selMes${auxIndex}">Mes</label>
			</div>
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="col-md-12 mt-3">
<!-- 			<p class="font-weight-bold h3-responsive text-center temaRecomenda">Recomendaciones (No mostró evidencia)</p> -->
			<p class="font-weight-bold h3-responsive text-center temaRecomenda">${curTemaRecomenda}</p>
			<p class="font-weight-bold h5-responsive text-center pregRecomenda">${curPreguntaRecomenda}</p>
		</div>
		<div class="col-md-12">
			<div class="md-form" style="margin-top: 0px;">
				<c:choose>
					<c:when test="${isCliente != 1}">
						<textarea id="txt_recomEvid${auxIndex}" name="txt_recomEvid" class="txtAreaCustom" rows="3" placeholder="Texto libre" maxlength="1000">${curRecomendacionTxt}</textarea>
					</c:when>
					<c:otherwise>
						<div>
							${curRecomendacionTxt}
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

</div>