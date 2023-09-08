package com.tokio.prevencion.pdfponderados73.commands;

import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;
import com.tokio.prevencion.prevencionservicebuilder.service.PonderadoImpresoTextosLocalService;

import java.io.PrintWriter;
import java.util.Map;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name="+ PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
"mvc.command.name=/prevencion/getTxtTema" }, service = MVCResourceCommand.class)

public class GetTxtTema extends BaseMVCResourceCommand {
	
	@Reference
	PonderadoImpresoTextosLocalService _PonderadoImpresoTextosLocalService;
	
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		PrintWriter writer = resourceResponse.getWriter();
		long ponderadoImpresoBaseId = ParamUtil.getLong(resourceRequest, "ponderadoImpresoBaseId");
		String txtData = ParamUtil.getString(resourceRequest, "txtData");
		
		try {
			Map<String, String> listTextos = _PonderadoImpresoTextosLocalService.getMapTextosPonderado(ponderadoImpresoBaseId);
			String txtTema = listTextos.get(txtData);
			writer.write(txtTema);
		} catch (Exception e) {
			// TODO: handle exception
			writer.write("");
		}
	}
}
