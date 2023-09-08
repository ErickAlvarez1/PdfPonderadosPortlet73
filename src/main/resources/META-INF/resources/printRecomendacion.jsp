<%@ include file="/init.jsp" %>

<div class="divPrintRecomenda auxAltura2" data="${printIndex}">
	<div class="row mt-5">
		<div id="cap-5" class="col-md-12 ${auxNewPage}">
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
			<p class="textFormato${printIndex} text-center">19-06-01: A</p>
			<p class="text-center">Plazos de Implementación:</p>
			<p id="strPlazo${printIndex}" class="text-center"></p>
		</div>
		<div class="col-md-4 divBorder" style="border: solid 1px;">
			<p id="printRecTema${printIndex}" class="text-center recomendaTema">PROGRAMA DE CAPACITACIÓN</p>
			<p class="text-center">Responsables de la Implementación:</p>
			<p class="text-center" id="txtResponsable1-${printIndex}"></p>
			<p class="text-center" id="txtResponsable2-${printIndex}"></p>
			<p class="text-center" id="txtResponsable3-${printIndex}"></p>
		</div>
		<div class="col-md-6 divBorder" style="border: solid 1px;">
			<p id="printRecPreg${printIndex}" class="text-center printPreg"></p>
			<p id="pTxtRecomendaciones${printIndex}" class="text-center"></p>
		</div>
	</div>
</div>