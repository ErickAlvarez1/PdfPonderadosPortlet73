package com.tokio.prevencion.pdfponderados73.portlet;

import com.google.gson.Gson;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.tokio.prevencion.pdfponderados73.bean.ListRecomendacion;
import com.tokio.prevencion.pdfponderados73.bean.RecomendacionAux;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;
import com.tokio.prevencion.prevencionservicebuilder.model.Recomendacion;
import com.tokio.prevencion.prevencionservicebuilder.service.PonderadoImpresoTextosLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.RecomendacionLocalService;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name="+ PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
"mvc.command.name=/prevencion/saveTxtPdf" }, service = MVCResourceCommand.class)

public class SavePonderadoTxtResourceCommand extends BaseMVCResourceCommand {
	
	@Reference
	RecomendacionLocalService _RecomendacionLocalService;
	
	@Reference
	PonderadoImpresoTextosLocalService _PonderadoImpresoTextosLocalService;
	
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		
		saveTextos(resourceRequest);
		saveRecomendaciones(resourceRequest);
		
		
	}
	
	private void saveTextos(ResourceRequest resourceRequest){
		try{
			long ponderadoImpresoBaseId = ParamUtil.getLong(resourceRequest, "ponderadoImpresoBaseId");
			int sizeListaTema = ParamUtil.getInteger(resourceRequest, "sizeListaTema");
			
			for (int i = 0; i < sizeListaTema; i++) {
				String txtTema = ParamUtil.getString(resourceRequest, "tema"+i);
				_PonderadoImpresoTextosLocalService.addPonderadoImpresoTexto(ponderadoImpresoBaseId, "tema"+i, txtTema);
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("Error al guardar Textos");
		}
	}
	
	private void saveRecomendaciones(ResourceRequest resourceRequest){
		Gson gson = new Gson();
		long ponderadoImpresoBaseId = ParamUtil.getLong(resourceRequest, "ponderadoImpresoBaseId");
		String strListRecomendacion = "{\"listRecomendacion\":" + ParamUtil.getString(resourceRequest, "arrRecomendacion") + "}";
		try {
			ListRecomendacion listaRecomendacion = gson.fromJson(strListRecomendacion, ListRecomendacion.class);
			for (RecomendacionAux recomendacion : listaRecomendacion.getListRecomendacion()) {
				long idRecomendacion = CounterLocalServiceUtil.increment(RecomendacionAux.class.getName() );
				Recomendacion curRecomendacion = _RecomendacionLocalService.createRecomendacion(idRecomendacion);
				curRecomendacion.setPonderadoImpresoBaseId(ponderadoImpresoBaseId);
				curRecomendacion.setPlazo(recomendacion.getPlazo());
				curRecomendacion.setResponsable1(recomendacion.isResponsable1());
				curRecomendacion.setResponsable2(recomendacion.isResponsable2());
				curRecomendacion.setResponsable3(recomendacion.isResponsable3());
				curRecomendacion.setPrioridad(recomendacion.getPrioridad());
				curRecomendacion.setAnio(recomendacion.getAnio());
				curRecomendacion.setMes(recomendacion.getMes());
				curRecomendacion.setOrden(recomendacion.getOrden());
				curRecomendacion.setRecomendacionText(recomendacion.getRecomendacion());
				curRecomendacion.setTema(recomendacion.getTema());
				curRecomendacion.setPregunta(recomendacion.getPregunta());
				
				_RecomendacionLocalService.addRecomendacion(curRecomendacion);
				
			}
			//listRespuesta = gson.fromJson(strListResp, ListRecomendacion.class);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
