package com.tokio.prevencion.pdfponderados73.portlet;

import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolder;
import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLFileEntryLocalServiceUtil;
import com.liferay.document.library.kernel.service.DLFolderLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.model.Role;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.prevencion.pdfponderados73.bean.InfoImg;
import com.tokio.prevencion.pdfponderados73.bean.ListTema;
import com.tokio.prevencion.pdfponderados73.bean.Resultado;
import com.tokio.prevencion.pdfponderados73.bean.Subtema;
import com.tokio.prevencion.pdfponderados73.bean.Tema;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;
import com.tokio.prevencion.prevencionservicebuilder.model.CatPregunta;
import com.tokio.prevencion.prevencionservicebuilder.model.CatSubtemas;
import com.tokio.prevencion.prevencionservicebuilder.model.CatTemas;
import com.tokio.prevencion.prevencionservicebuilder.model.PonderadoImpresoBase;
import com.tokio.prevencion.prevencionservicebuilder.model.Proveedor;
import com.tokio.prevencion.prevencionservicebuilder.model.Recomendacion;
import com.tokio.prevencion.prevencionservicebuilder.model.ResultadoPonderado;
import com.tokio.prevencion.prevencionservicebuilder.model.Solicitud_Servicios_Prevencion_Transporte_Carga;
import com.tokio.prevencion.prevencionservicebuilder.model.TipoPonderado;
import com.tokio.prevencion.prevencionservicebuilder.service.CatPreguntaLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.CatSubtemasLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.CatTemasLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.PonderadoImpresoBaseLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.PonderadoImpresoTextosLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.ProveedorLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.RecomendacionLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.ResultadoPonderadoLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.Solicitud_Servicios_Prevencion_Transporte_CargaLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.TipoPonderadoLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.VinculoPonderadoLocalService;
import com.tokio.prevencion.prevencionservicebuilder.service.VinculoSolicitudLocalService;
import com.tokio.prevencion.prevencionservices.PrevencionServices73;
import com.tokio.prevencion.prevencionservices.bean.CatTransportistas;
import com.tokio.prevencion.prevencionservices.bean.CatalogoResponse;
import com.tokio.prevencion.prevencionservices.bean.ItemCatalogo;
import com.tokio.prevencion.prevencionservices.bean.Transportista;
import com.tokio.prevencion.prevencionservices.constants.PrevencionServiceKey;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author urielfloresvaldovinos
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=PdfPonderadosPortlet73",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class PdfPonderadosPortlet73Portlet extends MVCPortlet {
	
	@Reference
	PrevencionServices73 _PrevencionServices;
	
	@Reference
	RecomendacionLocalService _RecomendacionLocalService;
	
	@Reference
	Solicitud_Servicios_Prevencion_Transporte_CargaLocalService _Solicitud_Servicios_Prevencion_Transporte_CargaLocalService;
	
	@Reference
	VinculoPonderadoLocalService _VinculoPonderadoLocalService;
	
	@Reference
	VinculoSolicitudLocalService _VinculoSolicitudLocalService;
	
	@Reference
	PonderadoImpresoTextosLocalService _PonderadoImpresoTextosLocalService;
	
	@Reference
	PonderadoImpresoBaseLocalService _PonderadoImpresoBaseLocalService;
	
	@Reference
	TipoPonderadoLocalService _TipoPonderadoLocalService;
	
	@Reference
	ProveedorLocalService _ProveedorLocalService;
	
	@Reference
	ResultadoPonderadoLocalService _ResultadoPonderadoLocalService;
	
	@Reference
	CatPreguntaLocalService _CatPreguntaLocalService;
	
	@Reference
	CatSubtemasLocalService _CatSubtemasLocalService;
	
	@Reference
	CatTemasLocalService _CatTemasLocalService;
	
	long tipoPonderado = 0;
	TipoPonderado tipoVigente;
	String strProveedorId = "";
	User usuario;
	List<CatTemas> listTemas;
	long vCuestionario = -1;
	
	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws PortletException, IOException {
		try {
			
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			
			User user = (User) renderRequest.getAttribute(WebKeys.USER);
			
			getUser(renderRequest);
			getTipoPonderado(renderRequest);
			getProveedorId(renderRequest);
			getRespuesta(renderRequest);
			generaTablaRespuesta(renderRequest);
			

			long idSolicitud = 0;
			String auxHide1 = "";
			String auxHide2 = "hidden";

			String idVinculoSolicitudStr = PortalUtil.getOriginalServletRequest(request).getParameter("idVinculoSolicitud");
			long idResultado = 0;
			if (Validator.isNotNull(idVinculoSolicitudStr)) {
				idResultado = Long.parseLong(idVinculoSolicitudStr);//idVinculoSolicitud
				renderRequest.setAttribute("idVinculoSolicitud", idResultado);
			}
			
			String nombreConsultor = "";
			String tipNegocio = "";
			
			String idSolicitudStr = PortalUtil.getOriginalServletRequest(request).getParameter("idSolicitud");
			

			if(Validator.isNotNull(idSolicitudStr)){
				idSolicitud = Long.parseLong(idSolicitudStr);
				
				Solicitud_Servicios_Prevencion_Transporte_Carga curSolicitud = _Solicitud_Servicios_Prevencion_Transporte_CargaLocalService.getSolicitud_Servicios_Prevencion_Transporte_Carga(idSolicitud);
				if(curSolicitud.getConsultor() > 0){
					User userClient = UserLocalServiceUtil.getUser(curSolicitud.getConsultor());
					nombreConsultor = userClient.getFullName();
				}
				

				CatalogoResponse cat_canal = fGetCatalogos(PrevencionServiceKey.CAT_CANAL, user.getFirstName(), PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73);
				List<ItemCatalogo> list_cat_canal = cat_canal.getLista();
				for (ItemCatalogo item : list_cat_canal) {
					if(item.getCodigo().equals(curSolicitud.getCanal())){
						tipNegocio = item.getDescripcion();
					}
				}
				
				auxHide1 = "hidden";
				auxHide2 = "";
			}
			
			if (idResultado > 0){
				
				long ponderado = _VinculoSolicitudLocalService.fetchVinculoSolicitud(idResultado).getIdVinculo();
				long evaluador = _VinculoPonderadoLocalService.fetchVinculoPonderado(ponderado).getIdUsuario();
				User userEvaluador = UserLocalServiceUtil.getUser(evaluador);
				String nombreEvaluador = userEvaluador.getFullName();
				
				renderRequest.setAttribute("nombreEvaluador", nombreEvaluador);
				
				String ponderadoImpresoBaseIdTxt = PortalUtil.getOriginalServletRequest(request).getParameter("ponderadoImpresoBaseId");
				if(Validator.isNotNull(ponderadoImpresoBaseIdTxt)){
					long ponderadoImpresoBaseId = Long.parseLong(ponderadoImpresoBaseIdTxt);
					
//					PonderadoImpresoBase ponderadoBase = _PonderadoImpresoBaseLocalService.findLastByIdResultado(idResultado);
					PonderadoImpresoBase ponderadoBase = _PonderadoImpresoBaseLocalService.fetchPonderadoImpresoBase(ponderadoImpresoBaseId);
					
					System.err.println("ponderadoBase: "+ ponderadoBase);
					
					if( Validator.isNotNull(ponderadoBase) ){
						getImages(renderRequest, ponderadoBase.getPonderadoImpresoBaseId());
						
						sendInfoPonderadoBase(renderRequest, ponderadoBase);
						sendRecomendaciones(renderRequest, ponderadoBase);
						
						renderRequest.setAttribute("flagData", 1);
						
					}else{
						renderRequest.setAttribute("flagData", 0);
					}
					
				}
				
			}
			
			Solicitud_Servicios_Prevencion_Transporte_Carga solicitud = _Solicitud_Servicios_Prevencion_Transporte_CargaLocalService.getSolicitud_Servicios_Prevencion_Transporte_Carga(idSolicitud);
			
			String nombreAsegurado = solicitud.getNombre();
			
			LocalDate fechaMinima = LocalDate.now().minusMonths(2);
			
			
//			renderRequest.setAttribute("idPonderado", idPonderado);
			renderRequest.setAttribute("fechaMinima", fechaMinima);
			renderRequest.setAttribute("auxHide1", auxHide1);
			renderRequest.setAttribute("auxHide2", auxHide2);
			renderRequest.setAttribute("nombreAsegurado", nombreAsegurado);
			renderRequest.setAttribute("idSolicitud", idSolicitud);
			renderRequest.setAttribute("idResultado", idResultado);

			
			renderRequest.setAttribute("nombreConsultor", nombreConsultor);
			renderRequest.setAttribute("tipNegocio", tipNegocio);
			
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			String baseUrl = themeDisplay.getPortalURL();
			String privateGroup = themeDisplay.getPathFriendlyURLPrivateGroup();
			String fiendUrl = themeDisplay.getSiteGroup().getFriendlyURL();
			
			String urlFinal = baseUrl + privateGroup + fiendUrl;
			
			renderRequest.setAttribute("urlFinal", urlFinal);
			
			super.render(renderRequest, renderResponse);
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			SessionErrors.add(renderRequest, "errorDesconocido");
			SessionMessages.add(renderRequest,PortalUtil.getPortletId(renderRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}
	}
	
	
	private CatalogoResponse fGetCatalogos (String codigo, String usuario, String pantalla){
		try{
			return _PrevencionServices.catalogosDetalle(codigo, usuario, pantalla);			
		}
		catch (Exception e) {
			// TODO: handle exception
			return null;
		}
		
	}
	
	private void getUser(RenderRequest renderRequest){
		try {
			ThemeDisplay themeDisplay = (ThemeDisplay)renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			usuario = themeDisplay.getUser();
			List<Role> auxRole = usuario.getRoles();
			for (Role role : auxRole) {
				String nombrerol = role.getDescriptiveName();
				if(nombrerol.equals("TMX-cliente")){
					renderRequest.setAttribute("isCliente", 1);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.err.println("Error Usuario");
			usuario = null;
		}
	}
	
	private void sendInfoPonderadoBase(RenderRequest renderRequest, PonderadoImpresoBase ponderadoBase){
//		String fechaDoc = "";
		
		renderRequest.setAttribute("reporte", ponderadoBase.getReporte());
		renderRequest.setAttribute("direccion", ponderadoBase.getDireccion());
		renderRequest.setAttribute("telefonos", ponderadoBase.getTelefonos());
		renderRequest.setAttribute("email", ponderadoBase.getEmail());
		renderRequest.setAttribute("contactos", ponderadoBase.getContactos());
		renderRequest.setAttribute("objetivo", ponderadoBase.getObjetivo());
		renderRequest.setAttribute("alcance", ponderadoBase.getAlcance());
		renderRequest.setAttribute("resultadoEva", ponderadoBase.getResultadoEva());
		renderRequest.setAttribute("conclu2", ponderadoBase.getConclusion2());
		renderRequest.setAttribute("conclu3", ponderadoBase.getConclusion3());
		renderRequest.setAttribute("conclu4", ponderadoBase.getConclusion4());
		
		renderRequest.setAttribute("ponderadoImpresoBaseId", ponderadoBase.getPonderadoImpresoBaseId());
		
		Date a = ponderadoBase.getModifiedDate();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if(Validator.isNotNull(a)){
//			fechaDoc = dateFormat.format(a);					
			renderRequest.setAttribute("fechaDoc", dateFormat.format(a));
			renderRequest.setAttribute("fechaFormat", ponderadoBase.getModifiedDate());
		}
	}
	
	private void sendRecomendaciones(RenderRequest renderRequest, PonderadoImpresoBase ponderadoBase){
		try 	{
			List<Recomendacion> listRecomenda = _RecomendacionLocalService.findByIdPonderadoBaseId(ponderadoBase.getPonderadoImpresoBaseId());
			renderRequest.setAttribute("listRecomenda", listRecomenda);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.err.println("Error al buscar recomendaciones");
		}
	}
	
	private void getTipoPonderado(RenderRequest renderRequest){
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		String strIdTipo = PortalUtil.getOriginalServletRequest(request).getParameter("idTipo");
		
		if(Validator.isNotNull(strIdTipo)){
			tipoPonderado = Long.parseLong(strIdTipo);
		}else{
			tipoPonderado = 0;
		}
		
		tipoVigente = _TipoPonderadoLocalService.findByTipoAndActive(tipoPonderado);
		
		System.out.println("tipoPonderado: " + tipoPonderado);
		renderRequest.setAttribute("tipoPonderado", tipoPonderado);
		renderRequest.setAttribute("tipoVigente", tipoVigente);

	}
	
	private void getProveedorId(RenderRequest renderRequest){
		HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
		strProveedorId = PortalUtil.getOriginalServletRequest(request).getParameter("proveedorId");
		String nombreTransporte = "";
		
		if(Validator.isNotNull(strProveedorId)){
			if(tipoVigente.getIdTipo() == 10){
				try{
					CatTransportistas ListT = _PrevencionServices.GetTransportistaByCodigo(usuario.getScreenName(), PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73, strProveedorId);
					for (Transportista curTran : ListT.getLista()) {
						nombreTransporte = curTran.getNombre();
						break;
					}
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					System.out.println("Error al recuperar transportista");
				}				
			}else{
				try {
					Proveedor curTran = _ProveedorLocalService.getProveedor(Long.parseLong(strProveedorId));
					nombreTransporte = curTran.getNombre();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
			
			renderRequest.setAttribute("nombreTransporte", nombreTransporte);
			renderRequest.setAttribute("proveedorId", strProveedorId);
		}
		
	}
	
	private void getRespuesta(RenderRequest renderRequest){
		if(Validator.isNotNull(tipoVigente)){
			HttpServletRequest request = PortalUtil.getHttpServletRequest(renderRequest);
			String idRespuestaStr = PortalUtil.getOriginalServletRequest(request).getParameter("vCuestionarioId");
			
			int idRespuesta;
			if(Validator.isNotNull(idRespuestaStr)){
				idRespuesta = Integer.parseInt(idRespuestaStr);

				List<ResultadoPonderado> listRespuesta = _ResultadoPonderadoLocalService.findByIdRespuesta(idRespuesta);
				for (ResultadoPonderado res : listRespuesta) {
					vCuestionario = res.getVCuestionario();
					break;
				}
				
				listTemas = _CatTemasLocalService.getTemas((int)vCuestionario);
				
				renderRequest.setAttribute("idRespuesta", idRespuesta);
				renderRequest.setAttribute("listRespuesta", listRespuesta);
				
			}
			
		}
	}
	
	
	private void generaTablaRespuesta(RenderRequest renderRequest){
		ListTema cuestionario = new ListTema();
		if(Validator.isNotNull(listTemas)){
			List<Tema> curListTema = new ArrayList<>();
			for (CatTemas tema : listTemas) {
				Tema curTema = new Tema();
				curTema.setIdTema(tema.getIdTema());
				curTema.setDescripcion(tema.getDescripcion());
				curTema.setOrden(tema.getOrden());
				curTema.setIdEvaluacion(tema.getIdEvaluacion());
				curTema.setPorcentaje(tema.getPorcentaje());
				
				List<CatSubtemas> listSubtema = _CatSubtemasLocalService.findSubtemasByIdTema(tema.getIdTema());
				List<Subtema> curListSubtema = new ArrayList<>();
				for (CatSubtemas subtema : listSubtema) {
					Subtema curSub = new Subtema();
					curSub.setIdSubtema(subtema.getIdSubtema());
					curSub.setDescripcion(subtema.getDescripcion());
					curSub.setOrden(subtema.getOrden());
					curSub.setIdTema(subtema.getIdTema());
					
					List<CatPregunta> listPregunta = _CatPreguntaLocalService.findByIdsubtema(subtema.getIdSubtema());
					List<Resultado> curListRes = new ArrayList<>();
					for (CatPregunta pregunta : listPregunta) {
						Resultado curRes = new Resultado();
						ResultadoPonderado resultado = _ResultadoPonderadoLocalService.findByIdPregunta(pregunta.getId());
						curRes.setId(resultado.getId());
						curRes.setIdRespuesta(resultado.getIdRespuesta());
						curRes.setIdPonderado(resultado.getIdPonderado());
						curRes.setIdPregunta(resultado.getIdPregunta());
						curRes.setRespuesta(resultado.getRespuesta());
						curRes.setEstatusDoc(resultado.getEstatusDoc());
						curRes.setComentrio(resultado.getComentrio());
						curRes.setIdSolicitud(resultado.getIdSolicitud());
						curRes.setIdTransportista((int)resultado.getIdTransportista());
						curRes.setvResultado((int)resultado.getVResultado());
						curRes.setActivo((resultado.getActivo() == 1 ? true : false));
						curRes.setFechaCreacion(resultado.getFechaCreacion());
						curRes.setvCuestionario((int)resultado.getVCuestionario());
						curRes.setEvidencia(resultado.getEvidencia());
						curRes.setDescripcion(pregunta.getDescripcion());
						
						curListRes.add(curRes);
					}
					curSub.setListRespuesta(curListRes);
					
					curListSubtema.add(curSub);
				}
				curTema.setListSubtema(curListSubtema);
				
				curListTema.add(curTema);
			}
			cuestionario.setListTema(curListTema);
			
			
//			System.err.println("cuestionario.getListTema()");
//			System.err.println(cuestionario.getListTema());
			renderRequest.setAttribute("cuestionario", cuestionario.getListTema());
		}
	}
	
	private void getImages(RenderRequest renderRequest, long ponderadoBaseId) throws PortalException{
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		String baseUrl = themeDisplay.getPortalURL();
		
		try {
			long idGroup = PortalUtil.getScopeGroupId(renderRequest);
			DLFolder fPrevencion = DLFolderLocalServiceUtil.getFolder(idGroup, DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, "Prevencion");
			DLFolder fDocumentos = DLFolderLocalServiceUtil.getFolder(idGroup, fPrevencion.getFolderId(), "ReportesEvaluacion");
			List<DLFileEntry> listFiles = new ArrayList<>();
			if (Validator.isNotNull(DLFolderLocalServiceUtil.getFolder(idGroup, fDocumentos.getFolderId(), ponderadoBaseId+""))){
				DLFolder fImg = DLFolderLocalServiceUtil.getFolder(idGroup, fDocumentos.getFolderId(), ponderadoBaseId+"");			
				listFiles = DLFileEntryLocalServiceUtil.getFileEntries(idGroup, fImg.getFolderId());
			}
			
			
			List<InfoImg> listImg = new ArrayList<>();
			for (DLFileEntry dlFileEntry : listFiles) {
				InfoImg doc = new InfoImg();
				String urlDoc = baseUrl + "/documents/" + dlFileEntry.getGroupId() + "/" + dlFileEntry.getFolderId() + "/" + dlFileEntry.getFileName() + "/" + dlFileEntry.getUuid();
				doc.setNombre(dlFileEntry.getFileName());
				doc.setUrl(urlDoc);
				doc.setIdImg(dlFileEntry.getFileEntryId());
				
				listImg.add(doc);
				
				System.out.println("IMG");
				System.out.println(urlDoc);
			}
			renderRequest.setAttribute("listImg", listImg);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		}
}