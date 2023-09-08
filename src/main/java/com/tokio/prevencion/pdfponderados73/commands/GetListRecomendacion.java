package com.tokio.prevencion.pdfponderados73.commands;

import com.google.gson.Gson;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;
import com.tokio.prevencion.prevencionservicebuilder.model.Recomendacion;
import com.tokio.prevencion.prevencionservicebuilder.service.RecomendacionLocalService;

import java.io.PrintWriter;
import java.util.List;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name="+ PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
"mvc.command.name=/prevencion/getListRecomendacion" }, service = MVCResourceCommand.class)

public class GetListRecomendacion extends BaseMVCResourceCommand {
	
	@Reference
	RecomendacionLocalService _RecomendacionLocalService;
	
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		Gson gson = new Gson();
		PrintWriter writer = resourceResponse.getWriter();
		long ponderadoImpresoBaseId = ParamUtil.getLong(resourceRequest, "ponderadoImpresoBaseId");
		System.err.println("ponderadoImpresoBaseId: " + ponderadoImpresoBaseId);
		try {
			List<Recomendacion> listRecomenda = _RecomendacionLocalService.findByIdPonderadoBaseId(ponderadoImpresoBaseId);
			
			String response = gson.toJson(listRecomenda);
			
			writer.write(response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			writer.write("");
		}
	}
}
