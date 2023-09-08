package com.tokio.prevencion.pdfponderados73.commands;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolder;
import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLAppService;
import com.liferay.document.library.kernel.service.DLFileEntryLocalServiceUtil;
import com.liferay.document.library.kernel.service.DLFolderLocalServiceUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCResourceCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tokio.prevencion.pdfponderados73.constants.PdfPonderadosPortlet73PortletKeys;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name="+ PdfPonderadosPortlet73PortletKeys.PDFPONDERADOSPORTLET73,
"mvc.command.name=/prevencion/saveImg" }, service = MVCResourceCommand.class)

public class SaveImgResouceCommand extends BaseMVCResourceCommand{
	@Reference
	private DLAppService _dlAppService;
	protected void doServeResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws Exception {
		
		UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
		long idGroup = PortalUtil.getScopeGroupId(resourceRequest);
		ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFolder.class.getName(), resourceRequest);
		/**
		 * Estos permisos son para poder subir archivos
		 * La generacion de carpetas no los requieren pero los archivos si
		 */
		serviceContext.setAddGroupPermissions(true);
		serviceContext.setAddGuestPermissions(true);
		
		JsonObject response = new JsonObject();
		JsonArray arrayUrlImg  = new JsonArray();
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		String baseUrl = themeDisplay.getPortalURL();
		

		DLFolder fPrevencion = DLFolderLocalServiceUtil.getFolder(idGroup, DLFolderConstants.DEFAULT_PARENT_FOLDER_ID,
				"Prevencion");
		
		DLFolder fDocumentos = DLFolderLocalServiceUtil.getFolder(idGroup, fPrevencion.getFolderId(),
				"ReportesEvaluacion");

		String ponderadoImpresoBaseId = ParamUtil.getString(resourceRequest, "ponderadoImpresoBaseId");
		long idFolderImg = getIdFoler(idGroup, fDocumentos.getFolderId(), ponderadoImpresoBaseId);
		
		
		if( idFolderImg == 0 ){
			System.err.println("FOLDER NO EXISTE");
			Folder folder = _dlAppService.addFolder(idGroup, fDocumentos.getFolderId(), ponderadoImpresoBaseId, "Imagenes", serviceContext);
			idFolderImg = folder.getFolderId();
			
			System.out.println(" se creo el folder con id : " + idFolderImg);
		}else{
			System.err.println("FOLDER EXISTE");		
			System.out.println("folder con id : " + idFolderImg);
		}

		int countImg = 0;
		int sizeImgExiste = ParamUtil.getInteger(resourceRequest, "sizeImgExiste");

		for (int i = 0; i < sizeImgExiste; i++) {
			JsonObject curUrl = new JsonObject();
			long idImg = ParamUtil.getLong(resourceRequest, "imgExiste"+i);
			FileEntry curImgExiste = _dlAppService.getFileEntry(idImg);
			curImgExiste.getContentStream();
			
			FileEntry documentoSub = _dlAppService.addFileEntry(idGroup, idFolderImg, curImgExiste.getFileName(), curImgExiste.getMimeType(), "img"+countImg, "img"+countImg, "hi", curImgExiste.getContentStream(), curImgExiste.getSize(), serviceContext);
			String urlDoc = baseUrl + "/documents/" + documentoSub.getGroupId() + "/" + documentoSub.getFolderId() + "/" + documentoSub.getFileName() + "/" + documentoSub.getUuid();
			curUrl.addProperty("url", urlDoc);
			
			arrayUrlImg.add(curUrl);
			countImg++;
		}
		

		int sizeListaImg = ParamUtil.getInteger(resourceRequest, "sizeListaImg");
		for (int i = 0; i < sizeListaImg; i++) {
			JsonObject curUrl = new JsonObject();
			String fileName = uploadRequest.getFileName( "img"+i );
			File file = uploadRequest.getFile( "img"+i );
			String mimeType = uploadRequest.getContentType( "img"+i );
			
			FileEntry documentoSub = _dlAppService.addFileEntry(idGroup, idFolderImg, fileName, mimeType, "img"+countImg, "img"+countImg, "hi", file, serviceContext);
			String urlDoc = baseUrl + "/documents/" + documentoSub.getGroupId() + "/" + documentoSub.getFolderId() + "/" + documentoSub.getFileName() + "/" + documentoSub.getUuid();
			curUrl.addProperty("url", urlDoc);
			
			arrayUrlImg.add(curUrl);
			countImg++;
		}
		
		response.add("listUrl", arrayUrlImg);
		
		PrintWriter writer = resourceResponse.getWriter();
		writer.write(response.toString());
		
	}
	
	private long getIdFoler(long idGroup, long parentId, String nameFolder){
		try {
			DLFolder fImg = DLFolderLocalServiceUtil.getFolder(idGroup, parentId, nameFolder);
			List<DLFileEntry> listImg = DLFileEntryLocalServiceUtil.getFileEntries(idGroup, fImg.getFolderId());
			for (DLFileEntry dlFileEntry : listImg) {
				_dlAppService.deleteFileEntry(dlFileEntry.getFileEntryId());
			}
			return fImg.getFolderId();
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
}
