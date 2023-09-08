package com.tokio.prevencion.pdfponderados73.portlet;

import com.google.gson.Gson;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;
import com.tokio.prevencion.prevencionservicebuilder.model.PonderadoImpresoBase;
import com.tokio.prevencion.prevencionservicebuilder.model.VinculoPonderado;
import com.tokio.prevencion.prevencionservicebuilder.model.VinculoSolicitud;
import com.tokio.prevencion.prevencionservicebuilder.service.PonderadoImpresoBaseLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.VinculoPonderadoLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.VinculoSolicitudLocalService;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
//import java.util.Date;
import java.util.Date;
import java.util.List;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name="+ PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
"mvc.command.name=/prevencion/savePdf" }, service = MVCResourceCommand.class)

public class SavePdfPonderadoResourseCommand extends BaseMVCResourceCommand {
	
	@Reference
	PonderadoImpresoBaseLocalService _PonderadoImpresoBaseLocalService;
	
	@Reference
	VinculoPonderadoLocalService _VinculoPonderadoLocalService;
	
	@Reference
	VinculoSolicitudLocalService _VinculoSolicitudLocalService;
	
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		try{
			User user = (User) resourceRequest.getAttribute(WebKeys.USER);
			SimpleDateFormat sdfVig = new SimpleDateFormat("dd-MM-yyyy");
			
			String fechaStr = ParamUtil.getString(resourceRequest, "fecha");
			Date fecha = Validator.isNull(fechaStr)? null: sdfVig.parse(fechaStr);
			
//			long idVinculoPonderado = ParamUtil.getLong(resourceRequest, "idVinculoPonderado");
			long idResultado = ParamUtil.getLong(resourceRequest, "idVinculoSolicitud");
			String reporte = ParamUtil.getString(resourceRequest, "reporte");
			String direccion = ParamUtil.getString(resourceRequest, "direccion");
			String telefonos = ParamUtil.getString(resourceRequest, "noTelefonico");
			String email = ParamUtil.getString(resourceRequest, "mail");
			String contactos = ParamUtil.getString(resourceRequest, "contacto");
			String objetivo = ParamUtil.getString(resourceRequest, "objetivo");
			String alcance = ParamUtil.getString(resourceRequest, "alcance");
			String resultadoEva = ParamUtil.getString(resourceRequest, "resEval");
			String conclusion2 = ParamUtil.getString(resourceRequest, "conclu2");
			String conclusion3 = ParamUtil.getString(resourceRequest, "conclu3");
			String conclusion4 = ParamUtil.getString(resourceRequest, "conclu4");
			String idProveedor = ParamUtil.getString(resourceRequest, "proveedorId");
			
			PonderadoImpresoBase ponderadoImpresoBaseId = _PonderadoImpresoBaseLocalService.addPonderadoImpresoBase(idResultado, user.getUserId(), reporte, direccion, telefonos, email, contactos, objetivo, alcance, resultadoEva, conclusion2, conclusion3, conclusion4, fecha);
			
			VinculoSolicitud curVinculo = _VinculoSolicitudLocalService.fetchVinculoSolicitud(idResultado);
			if (Validator.isNotNull(curVinculo)){
				
				curVinculo.setIdImpresoBase(ponderadoImpresoBaseId.getPonderadoImpresoBaseId());
				_VinculoSolicitudLocalService.updateVinculoSolicitud(curVinculo);
				
				VinculoPonderado curvinculoPonderado = _VinculoPonderadoLocalService.fetchVinculoPonderado(curVinculo.getIdVinculo());
				if(Validator.isNotNull(curvinculoPonderado)){
					if( (Validator.isNull(curvinculoPonderado.getHistorialImpresoBase()) || ( curvinculoPonderado.getHistorialImpresoBase() == "" )  )){
						curvinculoPonderado.setHistorialImpresoBase(ponderadoImpresoBaseId.getPonderadoImpresoBaseId()+"");
					}else{
						curvinculoPonderado.setHistorialImpresoBase( curvinculoPonderado.getHistorialImpresoBase()+","+ponderadoImpresoBaseId.getPonderadoImpresoBaseId() );
					}
					_VinculoPonderadoLocalService.updateVinculoPonderado(curvinculoPonderado);
				}
			}
			
			
			List<VinculoPonderado> listVicnuloPonderado = _VinculoPonderadoLocalService.findListByIdProveedor(idProveedor);
			for (VinculoPonderado vinculoPonderado : listVicnuloPonderado) {
				vinculoPonderado.setPonderadoImpresoBaseId(ponderadoImpresoBaseId.getPonderadoImpresoBaseId());
				
				_VinculoPonderadoLocalService.updateVinculoPonderado(vinculoPonderado);
			}
			
			Gson gson = new Gson();
			String jsonString = gson.toJson(ponderadoImpresoBaseId);
			PrintWriter writer = resourceResponse.getWriter();
			writer.write(jsonString);
			
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
