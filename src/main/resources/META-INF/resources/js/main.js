var auxSelAnio = "";
var auxSelMes = "";
$( document ).ready(function() {
    console.log( "Listo PDF!" );
    
    var hoy = new Date($.now);
    $('.validaTxtDate').pickadate({
        format: 'dd-mm-yyyy',
        formatSubmit: 'dd-mm-yyyy',
        min: -60
    });
    $('.datepicker').pickadate({
        format: 'dd-mm-yyyy',
        formatSubmit: 'dd-mm-yyyy',
        selectYears: 80,
        max: [hoy.getFullYear(), (hoy.getMonth() + 1), hoy.getDate()]
    });
    
    
    $('#divFiles').on('click', '.btnClose', function () {
    	$(this).parent().parent().remove();
    });
    
    $('#imgExistentes').on('click', '.btnCloseImg', function () {
    	$(this).parent().parent().parent().remove();
    });

    $('#divRecomendaciones').on('click', '.closeRecomend', function () {
    	var auxDel = $(this).attr('data');
    	$(".divPrintRecomenda[data='"+auxDel+"']").remove();
    	$(this).parent().parent().parent().parent().remove();
	});
    
    var arrTitulos = [ ];
	$.each( $('.tTit'), function( key, value ) {
		arrTitulos.push( $(this).text() );
	});
	
	var arrRes = [ ];
	var punTot = 0;
	var arrPun = [ ];
	var punMaxTot  = 0;
	var arrPunMax = [ ];
	var arrPorcen = [ ];
	$.each( $('.tCalif'), function( key, value ) {
		arrRes.push( $(this).text() );
		
		arrPun.push( $(this).attr('cTotal') );
		punTot = punTot + parseInt( $(this).attr('cTotal') );
		
		arrPunMax.push( $(this).attr('cTotalMax') );
		punMaxTot = punMaxTot + parseInt( $(this).attr('cTotalMax') );

		arrPorcen.push( $(this).attr('porcen') );
	});
	
	$.each( $('.porcTema'), function( key, value ) {
	});
    
	
	$.each( arrTitulos, function( key, value ) {
		var auxBackgraundColor = (arrRes[key] <= 50) ? 'colorRedBack' : '';
		$('#contenResumen').append(`
				<div class="row .califTema">
					<div class="col-md-4 text-justify `+auxBackgraundColor+`" style="border: solid 1px;">
						<p>`+arrTitulos[key]+`</p>
					</div>
					<div class="col-md-2 text-center `+auxBackgraundColor+`" style="border: solid 1px;">
						<p>`+arrPorcen[key]+`%</p>
					</div>
					<div class="col-md-2 text-center `+auxBackgraundColor+`" style="border: solid 1px;">
						<p>`+arrPunMax[key]+`</p>
					</div>
					<div class="col-md-2 text-center `+auxBackgraundColor+`" style="border: solid 1px;">
						<p>`+arrPun[key]+`</p>
					</div>
					<div class="col-md-2 text-center `+auxBackgraundColor+`" style="border: solid 1px;">
						<p>`+arrRes[key]+`%</p>
					</div>
				</div>
		`);
	});
	$('#pObt').text(punTot);
	$('#pMax').text(punMaxTot);
	
	
    /*llenaCampos();*/
    /*********************************************************************/
    var arrTitulos = [ ];
	$.each( $('.tTit'), function( key, value ) {
		arrTitulos.push( $(this).text() );
	});

	var arrRes = [ ];
	$.each( $('.tCalif'), function( key, value ) {
		arrRes.push( $(this).text() );
	});
    
    
	var punTot = 0;
	$.each( $('.cTotal'), function( key, value ) {
		punTot = punTot + parseInt($(this).val());
	});

	var punMaxTot  = 0;
	$.each( $('.cTotalMax'), function( key, value ) {
		punMaxTot = punMaxTot + parseInt($(this).val());
	});
	
	var porcTot = Math.round((punTot / punMaxTot) * 100);
	$('#pTot').text(porcTot+'%');
	
    /*********************************************************************/
  	/***radar***/
    var ctxR = document.getElementById("radarChart").getContext('2d');
    var myRadarChart = new Chart(ctxR, {
    	type: 'radar',
    	data: {
		    labels: arrTitulos,
		    datasets: [{
			    label: "Resumen",
			    data: arrRes,
			    backgroundColor: [
			    	'rgba(105, 0, 132, .2)',
			    ],
			    borderColor: [
			    	'rgba(200, 99, 132, .7)',
			    ],
			    borderWidth: 2
		    }]
    	},
    	options: {
    		responsive: true,
    		scale: {
    		    ticks: {
    		        beginAtZero: true,
    		        max: 100,
    		        min: 0,
    		        stepSize: 25
    		    },
    		    pointLabels:{
        			fontSize : 14
        		}
    		}
    	}
    	
    	
    	
    });
    
    
    var arrValHorizontal = [0, porcTot, 0];
    new Chart(document.getElementById("horizontalBar"), {
    	"type": "horizontalBar",
    	"data": {
    		/*"labels": [" "],*/
    		"labels": [" ", " ", " "],
    		"datasets": [{
    			"label": "PORCENTAJE DE CONFIANZA",
    			/*"data": [porcTot],*/
    			"data": arrValHorizontal,
    			"height":300,
    			"fill": false,
    			/*"backgroundColor": ["rgba(255, 99, 132, 0.2)"],*/
    			"backgroundColor": ["rgba(140, 182, 252, 0.8)", "rgba(140, 182, 252, 0.8)", "rgba(140, 182, 252, 0.8)"],
    			/*"borderColor": ["rgb(255, 99, 132)"],*/
    			"borderColor": ["rgb(102, 156, 247)", "rgb(102, 156, 247)", "rgb(102, 156, 247)"],
    	"borderWidth": 1
    	}]
    	},
    	"options": {
    		"scales": {
    			"xAxes": [{
    				"ticks": {
    					"beginAtZero": true,
    					"steps": 25,
    					"stepSize": 25,
    					"max" : 100
    				},
    				"scaleLabel": {
    					"labelString": '---------- REQUIERE MEJORAS --------------------- REQUIERE MEJORAS ------------------------- ACEPTABLE --------------------------------- CONFIABLE -----------------',
    					"display": true,
    				}
    			}]
    		}
    	}
    });
    
    
    /*********************************************************************/
    auxSelAnio = $('#selAnio0').clone();
    auxSelMes = $('#selMes0').clone();
    
    $('#date_fecha').val( $('#fDateAux').val() ) ;
    
    comparaEscala(porcTot);
    comparaConfianza();
    findTextoTemas();
    auxSizeG = $('.rowRecomendacion').length;
    compruebaCliente();
    
    /*
    if( flagData == "1" ){
    	$("#modalConfirma").modal("show");
    }
    */
    
    $("#formPrint").css("display", "none");
    $("#formPrintHeaderFotter").css("display", "none");
    
});


var auxHtml = `
<div class="row">
	<div class="col-md-11">
		<div class="file-field">
			<div class="btn btn-primary btn-sm float-left">
				<span>Elegir archivo</span>
				<input type="file" class="inputImg" accept="image/jpeg, image/png">
			</div>
			<div class="file-path-wrapper">
				<input class="file-path validate" type="text" placeholder="Elige tu archivo">
			</div>
		</div>
	</div>
	<div class="col-md-1">
		<a class="btnClose"><i class="fas fa-trash-alt"></i></a>
	</div>
</div>
`;

$( "#btnAdd" ).click(function() {
	$("#divFiles").append(auxHtml);
});


/*var auxSizeG = 1;*/
function fAddRecomendacion(){
	auxSizeG++;
	$("#divRecomendaciones").append(`
		<div class="rowRecomendacion">
			<div class="row mt-5">
				<div class="col-md-11 mt-5">
					<p class="font-weight-bold h3-responsive text-center">Plazos de Implementación.</p>
				</div>
				<div class="col-md-1">
					<p class="font-weight-bold h3-responsive text-center"><a class="closeRecomend" data="`+auxSizeG+`"><i class="fas fa-trash-alt"></i></a></p>
				</div>
			</div>
			<div id="rdoPlazo`+auxSizeG+`" class="row d-flex justify-content-around">
				<div class="col-md-2 text-center">
					<div class="custom-control custom-radio" style="text-align: center;">
						<input type="radio" class="form-check-input rdoPla" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-1-1" name="group-`+auxSizeG+`-1" value="1">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-1-1">3 meses</label>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="custom-control custom-radio ">
						<input type="radio" class="form-check-input rdoPla" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-1-2" name="group-`+auxSizeG+`-1" value="2">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-1-2">6 meses</label>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="custom-control custom-radio">
						<input type="radio" class="form-check-input rdoPla" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-1-3" name="group-`+auxSizeG+`-1" value="3">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-1-3">12 meses</label>
					</div>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-md-12 mt-3">
					<p class="font-weight-bold h3-responsive text-center">Responsables de la Implementación:</p>
				</div>
			</div>
			<div id="rdoResponsable`+auxSizeG+`" class="row d-flex justify-content-around">
				<div class="col-md-2 text-center">
					<div class="form-check">
						<input type="checkbox" class="form-check-input check1" id="opc-`+auxSizeG+`-2-1" />
						<label class="form-check-label" for="opc-`+auxSizeG+`-2-1">`+nombreTransporte+`</label>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="form-check">
						<input type="checkbox" class="form-check-input check2" id="opc-`+auxSizeG+`-2-2" />
						<label class="form-check-label" for="opc-`+auxSizeG+`-2-2">`+nombreAsegurado+`</label>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="form-check">
						<input type="checkbox" class="form-check-input check3" id="opc-`+auxSizeG+`-2-3" />
						<label class="form-check-label" for="opc-`+auxSizeG+`-2-3">TMX (Seguimiento)</label>
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
						<input type="radio" class="form-check-input rdoTipo" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-3-1" name="group-`+auxSizeG+`-3" value="1">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-3-1">A</label>
						<span class="tooltext">Aquellas de especial importancia para la seguridad que requieren acción y/o implementación urgente</span>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="custom-control custom-radio toolcustom">
						<input type="radio" class="form-check-input rdoTipo" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-3-2" name="group-`+auxSizeG+`-3" value="2">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-3-2">B</label>
						<span class="tooltext"> Aquellas que requieren un mejoramiento continuo para elevar los estándares de seguridad</span>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="custom-control custom-radio toolcustom">
						<input type="radio" class="form-check-input rdoTipo" data="`+auxSizeG+`" id="opc-`+auxSizeG+`-3-3" name="group-`+auxSizeG+`-3" value="3">
						<label class="custom-control-label" for="opc-`+auxSizeG+`-3-3">C</label>
						<span class="tooltext">Aquellas que requieren de un análisis e inversión para su implementación en un período de 360 días, y que ayudarán a tener medios adecuados de Control</span>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="md-form form-group" style="margin-top:0px;">
						<select id="selAnio`+auxSizeG+`" name="selAnio`+auxSizeG+`" class="mdb-select classSelAnio">
							`+auxSelAnio.html()+`
						</select>
						<label for="selAnio`+auxSizeG+`">Año</label>
					</div>
				</div>
				<div class="col-md-2 text-center">
					<div class="md-form form-group" style="margin-top:0px;">
						<select id="selMes`+auxSizeG+`" name="selMes`+auxSizeG+`" class="mdb-select classSelMes">
							`+auxSelMes.html()+`
						</select>
						<label for="selMes`+auxSizeG+`">Mes</label>
					</div>
				</div>
			</div>
			
			<div class="row mt-3">
				<div class="col-md-12 mt-3">
					<p class="font-weight-bold h3-responsive text-center temaRecomenda">Recomendación General</p>
				</div>
				<div class="col-md-12">
					<div class="md-form" style="margin-top: 0px;">
						<textarea id="txt_recomEvid`+auxSizeG+`" name="txt_recomEvid" class="txtAreaCustom" rows="3" placeholder="Texto libre"></textarea>
					</div>
				</div>
			</div>
		</div>
	`);
	
	$("#printRecomenda").append(`
		<div class="divPrintRecomenda auxAltura2" data="`+auxSizeG+`">
			<div class="row mt-5">
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
					<p class="textFormato`+auxSizeG+` text-center">19-06-01: A</p>
					<p class="text-center">Plazos de Implementación:</p>
					<p id="strPlazo`+auxSizeG+`" class="text-center"></p>
				</div>
				<div class="col-md-4 divBorder" style="border: solid 1px;">
					<p id="printRecTema`+auxSizeG+`" class="text-center recomendaTema">PROGRAMA DE CAPACITACIÓN</p>
					<p class="text-center">Responsables de la Implementación:</p>
					<p class="text-center" id="txtResponsable1-`+auxSizeG+`"></p>
					<p class="text-center" id="txtResponsable2-`+auxSizeG+`"></p>
					<p class="text-center" id="txtResponsable3-`+auxSizeG+`"></p>
				</div>
				<div class="col-md-6 divBorder" style="border: solid 1px;">
					<p id="printRecPreg`+auxSizeG+`" class="text-center printPreg"></p>
					<p id="pTxtRecomendaciones`+auxSizeG+`" class="text-center"></p>
				</div>
			</div>
		</div>
	`);
}

$( "#addRecomendacion" ).click(function() {
	fAddRecomendacion();
	selectDestroy($('.rowRecomendacion').last().find('select'), false);
	/*restarSelects();*/
});

/*<p class="text-center">Capacitación de manipulación de producto Kawasaki.</p>*/

function llenaCampos(){
	$('#date_fecha').val(ponderado.fecha);
	$('#txt_evaluacion').val(ponderadoTxt.reporteEvaluacion);
	$('#txt_para').val(ponderado.para);
	$('#txt_direccion').val(ponderado.direccion);
	$('#txt_tel').val(ponderado.direccion);
	$('#txt_tel').val(ponderado.noTelefonico);
	$('#txt_email').val(ponderado.mail);
	$('#txt_contacto').val(ponderado.contacto);
	$('#txt_objetivo').val(ponderado.objetivo);
	$('#txt_alcance').val(ponderado.alcance);
	$('#txt_infoLegProve').val(ponderadoTxt.infoLegal);
	$('#txt_contexto').val(ponderadoTxt.contexto);
	$('#txt_GMFV').val(ponderadoTxt.gestionM);
	$('#txt_GRH').val(ponderadoTxt.gestionRH);
	$('#txt_RMFVE').val(ponderadoTxt.restreo);
	$('#txt_CapPersonal').val(ponderadoTxt.capacidad);
	$('#txt_TyL').val(ponderadoTxt.trafico);
	$('#txt_GesRiesgo').val(ponderadoTxt.gestionR);
	$('#txt_SegInstalaciones').val(ponderadoTxt.seguridad);
	$('#txt_').val(ponderado.resEval);
	$('#txt_conclu1').val(ponderadoTxt.conclu1);
	$('#txt_conclu2').val(ponderadoTxt.conclu2);
	$('#txt_conclu3').val(ponderadoTxt.conclu3);
	$('#txt_conclu4').val(ponderado.conclu4);

	$('#txt_recomEvid').val(ponderado.recomendacion);
}

function saveCampos(){
	$( ".txtAreaDato" ).each(function( index ) {
		var auxId = $(this).attr('data');
		var auxParafo = $(this).val().split(/\n/g);
		$.each( auxParafo, function( index, value ) {
			$('.pDato_'+auxId).append( '<p style="margin: 0px; text-aling: justify !important;">'+value+'</p>' );			
		});
	});

	$( "#divRecomendaciones .rowRecomendacion" ).each(function( index ) {
		var auxPlazo = $(this).find('input.rdoPla:checked').siblings('label').text();
		var auxSelec = $(this).find('input.rdoPla:checked').attr('data');
		$('#strPlazo'+auxSelec).text(auxPlazo);

		var auxPlazo = $(this).find('input.rdoResp:checked').siblings('label').text();
		$('#txtResponsable'+auxSelec).text(auxPlazo);
		
		var auxRecomenda = $(this).find('textarea.txtAreaCustom').val();
		$('#pTxtRecomendaciones'+auxSelec).text(auxRecomenda);
		
		if( $(this).find('input.check1').is(':checked') ){
			$('#txtResponsable1-'+auxSelec).text( $(this).find('input.check1').siblings('label').text() );
		}
		if( $(this).find('input.check2').is(':checked') ){
			$('#txtResponsable2-'+auxSelec).text( $(this).find('input.check2').siblings('label').text() );
		}
		if( $(this).find('input.check3').is(':checked') ){
			$('#txtResponsable3-'+auxSelec).text( $(this).find('input.check3').siblings('label').text() );
		}
		
		var formatoR = $(this).find('select.classSelAnio').val() +'-'+$(this).find('select.classSelMes').val() +'-'+ (index+1)+':'+ $(this).find('input.rdoTipo:checked').siblings('label').text();
		$('.textFormato'+auxSelec).text(formatoR);
		
		var auxTemaDinamico = $(this).find('p.temaRecomenda').text();
		$('#printRecTema'+auxSelec).text(auxTemaDinamico);
		
		var auxPregDinamico = $(this).find('p.pregRecomenda').text();
		$('#printRecPreg'+auxSelec).text(auxPregDinamico);
		
	});
	
	
	ponderado.fecha = $('#date_fecha').val();
	$('#printFecha').text(ponderado.fecha);
	ponderado.reporte = $('#txt_evaluacion').val();
	$('#printReporte').text(ponderado.reporte);
	ponderado.direccion = $('#txt_direccion').val();
	$('#pDireccion').text(ponderado.direccion);
	ponderado.noTelefonico = $('#txt_tel').val();
	$('#ptel').text(ponderado.noTelefonico);
	ponderado.mail = $('#txt_email').val();
	$('#pMail').text(ponderado.mail);
	ponderado.contacto = $('#txt_contacto').val();
	$('#pContacto').text(ponderado.contacto);
	ponderado.objetivo = $('#txt_objetivo').val();
	$('#pObjetivo').text(ponderado.objetivo);
	ponderado.alcance = $('#txt_alcance').val();
	$('#pAlcance').text(ponderado.alcance);
	ponderado.resEval = $('#txt_').val();
	$('#txt_Print').text( ponderado.resEval );
	ponderado.conclu2 = $('#txt_conclu2').val();
	$('#print_conclu2').text( ponderado.conclu2 );
	ponderado.conclu3 = $('#txt_conclu3').val();
	$('#print_conclu3').text( ponderado.conclu3 );
	ponderado.conclu4 = $('#txt_conclu4').val();
	$('#print_conclu4').text( ponderado.conclu4 );
	
	ponderado.idSolicitud = $('#idSolicitud').val();
	ponderado.idResultado = $('#idResultado').val();
	ponderado.proveedorId = $('#proveedorId').val();
	ponderado.idVinculoSolicitud = $('#idVinculoSolicitud').val();
	
	$('#info textarea').prop('disabled','true');
	$('#info input').prop('disabled','true');
	$('#info select').prop('disabled','true');
	$('#btnAdd').addClass('d-none');	
	$('#addRecomendacion').addClass('d-none');	
	$('.btnClose').addClass('d-none');
	$('.closeRecomend').addClass('d-none');
	$('.btnCloseImg').addClass('d-none');
	
	/*comprubaPaginas();*/
}

function validaCampos(){
	
	let completos = true;
	
	let auxSizeListaImg = 0;
	let auxSizeImgExiste = 0;
	
	$('.inputImg').each(function( index ) {
		if( $( this )[0].files[0] != undefined ){
			auxSizeListaImg++;
		}
	});
	
	$('.cardImg').each(function( index ) {
		auxSizeImgExiste++;
	});
	
	console.log(auxSizeListaImg + auxSizeImgExiste);
	
	if((auxSizeListaImg + auxSizeImgExiste) < 3){
		completos = false;
	}
	
	$.each($('.rowRecomendacion'), function (index, data){
		var plazo = $(this).find('input.rdoPla:checked').val();
		
		$(this).find('input.rdoPla').parent().addClass('incomplete');		
		if($(this).find('input.rdoPla').is(':checked')){
			$(this).find('input.rdoPla').parent().removeClass('incomplete');	
		}
		else{
			completos = false;
		}
		
		$(this).find('input.check1').addClass('is-invalid');
		if($(this).find('input.check1').is(':checked')){
			$(this).find('input.check1').removeClass('is-invalid');
		}
		else{
			completos = false;
		}
		
		$(this).find('input.check2').addClass('is-invalid');
		if($(this).find('input.check2').is(':checked')){
			$(this).find('input.check2').removeClass('is-invalid');
		}
		else{
			completos = false;
		}
		
		$(this).find('input.check3').addClass('is-invalid');
		if($(this).find('input.check3').is(':checked')){
			$(this).find('input.check3').removeClass('is-invalid');
		}
		else{
			completos = false;
		}
		
		$(this).find('input.rdoTipo').parent().addClass('incomplete');		
		if($(this).find('input.rdoTipo').is(':checked')){
			$(this).find('input.rdoTipo').parent().removeClass('incomplete');	
		}
		else{
			completos = false;
		}
		
		
		var recomendacion = $(this).find('textarea.txtAreaCustom').val();
		var tema = $(this).find('.temaRecomenda').text();
		var pregunta = $(this).find('.pregRecomenda').text();
		
		
	});
	
	$(".txtInLine").each(function( index ) {
		
		$(this).css("border", "solid 2px #FF0000");
		$(this).addClass('invalid');
		
		if($(this).val() != ""){
			$(this).removeAttr('style');
			$(this).removeClass('invalid');
		}
		else{
			completos = false;
		}
		console.log($(this).val());
	});
	
	$(".validaTxt").each(function( index ) {
		$(this).addClass('invalid');
		
		if($(this).val() != ""){
			$(this).removeClass('invalid');
		}
		else{
			completos = false;
		}
		
		console.log($(this).val());
	});
	
	$(".txtAreaCustom").each(function( index ) {
		$(this).addClass('form-control');
		$(this).addClass('is-invalid');
		
		if($(this).val() != ""){
			$(this).removeClass('form-control');
			$(this).removeClass('is-invalid');
		}
		else{
			completos = false;
		}
		
		console.log($(this).val());
	});
	
	
	
	
	return completos;
	
	
}

function postSaveCampos(){
	showLoader();
	
	if(validaCampos()){
		saveCampos();
		var auxPrueba = "txtPrueba";
		var ponderadoImpresoBaseId = "";
		
		
		/******/
		var arrRecomendacion = [];
		$.each( $('.rowRecomendacion') , function (index, data){
			
			var plazo = $(this).find('input.rdoPla:checked').val();
			var responsable1 = $(this).find('input.check1').is(':checked');
			var responsable2 = $(this).find('input.check2').is(':checked');
			var responsable3 = $(this).find('input.check3').is(':checked');
			var prioridad = $(this).find('input.rdoTipo:checked').val();
			var anio = $(this).find('select.classSelAnio').val();
			var mes = $(this).find('select.classSelMes').val();
			var orden = index+1;
			var recomendacion = $(this).find('textarea.txtAreaCustom').val();
			var tema = $(this).find('.temaRecomenda').text();
			var pregunta = $(this).find('.pregRecomenda').text();
			
			var curRecomendacion = new objRecomendacion (plazo, responsable1, responsable2, responsable3, prioridad, anio, mes, orden, recomendacion, tema, pregunta) ;
			arrRecomendacion.push(curRecomendacion);
		});
		/******/
		/***GuardaInformacionFormulario***/
		
		$.post($("#postSavePdf").val(), ponderado)
		.done(function (data) {
			$('#btnPrintPdf').attr('disabled',false);
			$('#btnSavePdf').attr('disabled',true);
			comprubaPaginas();
			
			var respuestaJson = JSON.parse(data);
			ponderadoImpresoBaseId = respuestaJson._ponderadoImpresoBaseId;
			
			var dataT = new FormData();
			var sizeListaTema = 0;
			$('.txtAreaDato').each(function( index ) {
				dataT.append( "tema"+index, $( this ).val() );
				sizeListaTema++;
			});
			dataT.append( "sizeListaTema", sizeListaTema );
			dataT.append( "ponderadoImpresoBaseId", ponderadoImpresoBaseId );
			dataT.append( "arrRecomendacion", JSON.stringify ( arrRecomendacion ) );
			
			$.ajax( {
				url : $("#postSaveTxtPdf").val(), 
				data : dataT, 
				processData : false, 
				contentType : false, 
				type : 'POST',
				async: false,
				success : function(data) {
					$("#centralModalSuccess").modal("show");
					
					/***** Guardado Imagenes *****/
					var dataF = new FormData();
					dataF.append( "nombreFile", "nombreFile" );	
					var sizeListaImg = 0;
					$('.inputImg').each(function( index ) {
						if( $( this )[0].files[0] != undefined ){
							dataF.append( "img"+sizeListaImg, $( this )[0].files[0] );
							sizeListaImg++;
						}
					});
					var sizeImgExiste = 0;
					$('.cardImg').each(function( index ) {
						dataF.append( "imgExiste"+index, $( this ).attr('data') );
						sizeImgExiste++;
					});
					dataF.append( "sizeListaImg", sizeListaImg );	
					dataF.append( "sizeImgExiste", sizeImgExiste );	
					dataF.append( "ponderadoImpresoBaseId", ponderadoImpresoBaseId );	
					$.ajax( {
						url : $('#postSaveImg').val(), 
						data : dataF, 
						processData : false, 
						contentType : false, 
						type : 'POST',
						async: false,
						success : function(data) {
							hideLoader();
							if( !valIsNullOrEmpty(data) ){
								var jsonResp = JSON.parse(data);
								$.each(jsonResp.listUrl, function(key, val) {
									console.log(val.url);
									$('#rowImgContent').append(`
										<div class="col-md-6 mt-3">
											<img src="`+val.url+`" class="img-rounded" alt="Cinque Terre">
										</div>
									`);
								});
							}
							
						}
					} );
					/***** Guardado Imagenes *****/
					
					
					hideLoader();
					
				}
			} );
	
			
		});
	
	}
	else {
		hideLoader();
		showMessageError('.navbar', "Los datos no están completos. Se requieren todos los campos y al menos 3 imágenes para generar el reporte", 0);
		$($('.invalid, .is-invalid').not('.validaTxtDate')[0]).focus();
	}
	
}

function strDatosTxt(){
	var dataTxt = "";
	$.each( $('.datoTxt'), function( key, value ) {
		if(key != 0){
			dataTxt=dataTxt+'|';
		}
		dataTxt = dataTxt + $(value).attr('id') + '¨' + $(value).val() + " ";
	});
	return dataTxt;
}

function chkRdodtsContr(rdoBtons) {
    var res = null;
    $.each(rdoBtons, function(index, value) {
        if ($(value).is(':checked')) {
            res = $(value).val();
            return false;
        }
    });
    return res;
}

function comparaEscala(porcTot){
	if(porcTot < 41){
		if(porcTot > 0){
			$('.escala1').addClass('colorRedBack');
		}
	}
	
	if(porcTot < 61){
		if(porcTot > 40){
			$('.escala2').addClass('colorRedBack');
		}
	}

	if(porcTot < 81){
		if(porcTot > 60){
			$('.escala3').addClass('colorRedBack');
		}
	}

	if(porcTot < 100){
		if(porcTot > 80){
			$('.escala4').addClass('colorRedBack');
		}
	}
	
	
}

function comparaConfianza(){
	$( ".tCalif" ).each(function( index ) {
		var auxData = $(this).attr('data');
		if( !valIsNullOrEmpty( $(this).text() ) ){
			var valData = parseInt( $(this).text() );
			if( valData < 75 ){
				$('.respClass'+auxData).addClass('d-none')
			}
		}
	});
}

function findTextoTemas(){
	showLoader();
	$('.txtAreaDato').each(function( index ) {
		var auxTextArea = $(this);
		
		var dTema = new FormData();
		dTema.append( "ponderadoImpresoBaseId", $('#ponderadoImpresoBaseId').val() );
		dTema.append( "txtData", "tema"+index );
		
		$.ajax( {
			url : $("#postGetTxtTema").val(), 
			data : dTema, 
			processData : false, 
			contentType : false, 
			type : 'POST',
			async: false,
			success : function(data) {
				if (flagCliente == "1"){
					$(auxTextArea).text(data);
				}
				else{
					$(auxTextArea).val(data);
				}		
			}
		} );
	});
	hideLoader();
}
function findRecomendacion(){
	showLoader();
		
	var dTema = new FormData();
	dTema.append( "ponderadoImpresoBaseId", $('#ponderadoImpresoBaseId').val() );
	
	$.ajax( {
		url : $("#postGetListRecomendacion").val(), 
		data : dTema, 
		processData : false, 
		contentType : false, 
		type : 'POST',
		async: false,
		success : function(data) {
			if( !valIsNullOrEmpty(data) ){
				var jsonResponse = JSON.parse(data);
				$.each(jsonResponse, function(key, val) {
					if(key != 0){
						fAddRecomendacion();
					}
					$('.rowRecomendacion').last().find('input.rdoPla[value="'+ val._plazo +'"]').attr('checked', true);
					$('.rowRecomendacion').last().find('input.check1').attr('checked', val._responsable1);
					$('.rowRecomendacion').last().find('input.check2').attr('checked', val._responsable2);
					$('.rowRecomendacion').last().find('input.check3').attr('checked', val._responsable3);
					$('.rowRecomendacion').last().find('input.rdoTipo[value="'+ val._prioridad +'"]').attr('checked', true);
					$('.rowRecomendacion').last().find('textarea.txtAreaCustom').val(val._recomendacionText);
					
					$('.rowRecomendacion').last().find('select.classSelAnio option').removeAttr('selected');
					$('.rowRecomendacion').last().find('select.classSelAnio option[value='+val._anio+']').attr('selected',true);
					
					$('.rowRecomendacion').last().find('select.classSelMes option').removeAttr('selected');
					$('.rowRecomendacion').last().find('select.classSelMes option[value='+val._mes+']').attr('selected','selected');
					selectDestroy($('.rowRecomendacion').last().find('select'), false);
					
				})
			}
			hideLoader();
		}
	} );

}

function comprubaPaginas(){
	$("#formPrint").css("display", "block");
	
	var maxHeight = 1000;

	var auxHeight0 = 0;
	$('.auxAltura0').each(function( index ) {
		auxHeight0 = auxHeight0 + $(this).height();
		var auxDivAnterior = $(this);
		
		if( auxHeight0 > maxHeight ){
			$(this).addClass('divNewPage');
			auxHeight0 = $(auxDivAnterior).height();
		}
	});
	var auxHeight = 0;
	$('.auxAltura').each(function( index ) {
		auxHeight = auxHeight + $(this).height();
		var auxDivAnterior = $(this);
		
		if( auxHeight > maxHeight ){
			$(this).addClass('divNewPage');
			auxHeight = $(auxDivAnterior).height();
		}
	});
	
	var auxHeight2 = 0;
	$('.auxAltura2').each(function( index ) {
		var auxDivAnterior = $(this);
		auxHeight2 = auxHeight2 + $(auxDivAnterior).height() +100;
		
		if( $(auxDivAnterior).hasClass('divPrintRecomenda') ){
			auxHeight2 = auxHeight2 + 100;
		}
		
		if( auxHeight2 > maxHeight ){
			$(this).addClass('divNewPage');
			auxHeight2 = $(auxDivAnterior).height();
		}
	});
	$("#formPrint").css("display", "none");
}

function fPrintPantalla(){
	showLoader();
	setTimeout(hideLoader(),5000);
	window.print();
}

function selectDestroy(objeto, enabled) {
    $(objeto).prop("disabled", enabled);
    $(objeto).materialSelect('destroy');
    $(objeto).materialSelect();
}
function restarSelects(){
	$('.classSelAnio').materialSelect('destroy');
	$('.classSelAnio').materialSelect();
	$('.classSelMes').materialSelect('destroy');
	$('.classSelMes').materialSelect();
}

function llenaRespuestas(){
	window.scrollTo(0, 0);
	findTextoTemas();
    findRecomendacion();
    $("#modalConfirma").modal("hide");
    
}

function compruebaCliente(){
	if( flagCliente == "1" ){
		saveCampos();
		comprubaPaginas();
		$('#btnSavePdf').attr('disabled', true);
		$('#btnSavePdf').addClass('d-none');
		$('#btnPrintPdf').attr('disabled', false);
	}
}