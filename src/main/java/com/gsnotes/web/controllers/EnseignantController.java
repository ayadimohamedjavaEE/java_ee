package com.gsnotes.web.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boudaa.tools.ExcelHandler;
import com.boudaa.tools.ExcelHandlerException;
import com.boudaa.tools.FileManagerHelper;
import com.gsnotes.bo.*;
import com.gsnotes.bo.Module;
import com.gsnotes.exceptionhandlers.AppModelException;
import com.gsnotes.services.ICheckerService;
import com.gsnotes.services.IEnseignantService;
import com.gsnotes.services.IEtudiantService;
import com.gsnotes.services.IInscriptionAnnuelleService;
import com.gsnotes.services.IInscriptionModuleService;
import com.gsnotes.web.models.UserAndAccountInfos;

@Controller
@RequestMapping("/prof")
public class EnseignantController {
	
	@Autowired
	private IEnseignantService sEnseignantService;
	
	@Autowired
	private HttpSession httpSession;
	
	@Autowired
	private ICheckerService CheckerService;
	
	
    @Autowired
    private IEtudiantService etudiantService;
    @Autowired
    private IInscriptionAnnuelleService inscriptionAnnuelleService;
    @Autowired
    private IInscriptionModuleService inscriptionModuleService;
	
	
	private UserAndAccountInfos getUserAccount() {
		// On vérifie si les infors de l'utilisateur sont déjà dans la session
		
		UserAndAccountInfos userInfo = (UserAndAccountInfos) httpSession.getAttribute("userInfo");

		if (userInfo == null) {

			// On obtient l'objet representant le compte connecté (Objet UserPrincipal
			// implémentant UserDetails)
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

			// On cast vers notre objet UserPrincipal
			Compte userAccount = ((UserPrincipal) principal).getUser();

			Utilisateur u = userAccount.getProprietaire();

			String roleName = userAccount.getRole().getNomRole();

			userInfo = new UserAndAccountInfos(u.getIdUtilisateur(), userAccount.getIdCompte(), userAccount.getLogin(),
					u.getNom(), u.getPrenom(), u.getEmail(), roleName);

			// On le stocke dans la session
			httpSession.setAttribute("userInfo", userInfo);
		}

		return userInfo;

	}
	
	
	@PostMapping("/import")
	public String importExcell(Model model, @RequestParam("name") MultipartFile file, RedirectAttributes redirectAttributes) throws AppModelException, ExcelHandlerException 
	
	{
		Module module = CheckerService.isValid(file, getUserAccount());
  		
		if(module==null)
		{
			
		
			model.addAttribute("message","Erreur ! Module Introuvable ");
			
					return "prof/userHomePage";
		}
		else {
			
			List<ArrayList<Object>> list = ExcelHandler.readFromExcel(FileManagerHelper.getAbsolutePathProject() + "/TEMP/" + file.getOriginalFilename(), 0);
	        
			String session = ((String)list.get(1).get(3)).toLowerCase();

	        System.out.println(list.size());
	        
	        Long id;
	        
	        
	        List<InscriptionModule> listInscriptionModule = new ArrayList<>();
	        
	        
	        List<Double> notes = new ArrayList<>();
	        
	        
	        for(int i=3; i<list.size(); i++) 
	        {
	        	if(list.get(i).size() == 0)
	                continue;
	            id = ((Double) list.get(i).get(0)).longValue();
	            System.out.println(id);
	            Etudiant etd = etudiantService.getEtudiantById(id);
	            System.out.println(etd);


	            InscriptionAnnuelle inscriptionAnnuelle = inscriptionAnnuelleService.getByEtdiantAndAnne(etd, ((String) list.get(0).get(5)).trim());
	            System.out.println(inscriptionAnnuelle);
	    
	            InscriptionModule inscriptionModule = inscriptionModuleService.getByInscriptionAnnuelleAndModule(inscriptionAnnuelle, module);
	            System.out.println("i-----------");
	            
	            listInscriptionModule.add(inscriptionModule);
	            notes.add((Double) list.get(i).get(list.get(i).size() -2));
	            
	            
	            
	            
	            
	            
	            
	            
	        }

	       

	        // Stocker dans la session 
	        
	        double grade = session.equals("normale") ? listInscriptionModule.get(0).getNoteSN() : listInscriptionModule.get(0).getNoteSR();
	        if(grade != -3) {
	            httpSession.setAttribute("listInscriptionModule", listInscriptionModule);
	            httpSession.setAttribute("notes", notes);
	            httpSession.setAttribute("session", session);
	            return "prof/ask";
	        }
	        

	        int i=0;
	        for(InscriptionModule inscriptionModule: listInscriptionModule) {
	            if(session.equals("normale")) {
	                inscriptionModule.setNoteSN(notes.get(i++));
	            } else {
	                inscriptionModule.setNoteSR(notes.get(i++));
	            }
	            inscriptionModuleService.save(inscriptionModule);
	        }

	        model.addAttribute("message", "les notes du module "+module+" ont été uploader avec success");
			
			
			
			return "prof/userHomePage";
		}
	}
	
	@GetMapping("/import")
    public String processImport(@RequestParam(value="ask", required=false) Integer sure, Model model) {
        if(sure == null)
            return "/prof/userHomePage";
        if(sure == 1) {
            List<InscriptionModule> listInscriptionModule = (List<InscriptionModule>) httpSession.getAttribute("listInscriptionModule");
            List<Double> notes = (List<Double>) httpSession.getAttribute("notes");
            String session = (String) httpSession.getAttribute("session");
            int i=0;
            for(InscriptionModule inscriptionModule: listInscriptionModule) {
                if (session.equals("normale")) {
                    inscriptionModule.setNoteSN(notes.get(i++));
                } else {
                    inscriptionModule.setNoteSR(notes.get(i++));
                }
                inscriptionModuleService.save(inscriptionModule);
            }
        }
        model.addAttribute("message", "les notes ont été uploader avec success");
        
        return "/prof/userHomePage";
	}
	
	
	

}
