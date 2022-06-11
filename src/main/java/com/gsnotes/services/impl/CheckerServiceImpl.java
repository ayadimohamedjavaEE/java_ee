package com.gsnotes.services.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.boudaa.tools.ExcelHandler;
import com.boudaa.tools.ExcelHandlerException;
import com.boudaa.tools.FileManagerHelper;
import com.gsnotes.bo.*;
import com.gsnotes.bo.InscriptionAnnuelle;
import com.gsnotes.bo.Module;
import com.gsnotes.exceptionhandlers.AppModelException;
import com.gsnotes.services.ICheckerService;
import com.gsnotes.services.IEnseignantService;
import com.gsnotes.web.models.UserAndAccountInfos;

// j'ai utilisé cette classe pour valider l'importation des notes 


@Service
@Transactional
public class CheckerServiceImpl implements ICheckerService {

	private static final String TYPE1 = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

	private static final String TYPE2 = "application/vnd.ms-excel";

	@Autowired
	private IEnseignantService sEnseignantService;

	@Override
	public Module isValid(MultipartFile file, UserAndAccountInfos userAccountInfos) throws AppModelException

	{

		List<ArrayList<Object>> list = null;

		// importation du fichier Excell sur le server

		try {
			String TEMP_FOLDER = FileManagerHelper.getAbsolutePathProject() + "/TEMP/";

			Path dir = Paths.get(TEMP_FOLDER);
			Path path = Paths.get(TEMP_FOLDER + file.getOriginalFilename());

			byte[] bytes = file.getBytes();

			if (!Files.exists(dir)) {
				Files.createDirectories(dir);
			}

			Files.write(path, bytes);

			System.out.println("You successfully uploaded : " + file.getOriginalFilename());

			// lire le fichier

			list = ExcelHandler.readFromExcel(TEMP_FOLDER + file.getOriginalFilename(), 0);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.err.println("Probleme de lecture de l'Excell");
		}

		String moduleName = ((String) list.get(0).get(1));
		String profName = ((String) list.get(1).get(1)).replace("\n", " ");
		String session = (String) list.get(0).get(3);
		String className = (String) list.get(1).get(5);
		String year = (String) list.get(0).get(5);

		int nombreDesElements = (int) list.get(2).size() - 6;

		// Collection<String> listDesElements = new TreeSet<String>();

		/*
		 * for(int i = 0 ; i<nombreDesElements ; i++ ) { listDesElements.add(((String)
		 * list.get(2).get(2+i))); }
		 */
		List<Element> list2 = isValidModule(moduleName, userAccountInfos).getElements();

		List<Element> listDesElements = new ArrayList<>();
		for (int i = 4; i < 4 + nombreDesElements; i++) {
			for (Element element : list2) {
				System.out.println("comparaison : " + (String) list.get(2).get(i) + " || " + element.getCode());
				if (egal(element.getCode(), (String) list.get(2).get(i))) {
					listDesElements.add(element);
				}
			}
		}

		// encapsuler les problemes dans les exceptions
		
		
		if (!isBetween0_20(list))
			throw new AppModelException("Probleme : Les Notes sont incorrects 0.20");

		if (!isExcell(file.getContentType()))
			throw new AppModelException("Probleme : Le fichier n'est pas de type Excell");

		if (!isValidName(profName, userAccountInfos))
			throw new AppModelException("nom et prenom du Prof non Valid ");
		else {
			System.out.println("nom et prenom merigl");
		}

		if (isValidModule(moduleName, userAccountInfos) == null)
			throw new AppModelException("Aucun module repéré par le prof");
		else {
			System.out.println("Valide Module : " + isValidModule(moduleName, userAccountInfos).getTitre());

		}

		if (!isValidNiveau(className, moduleName, userAccountInfos)) {
			throw new AppModelException("La Classe n'est pas valide");

		}

		if (!isValidAnne(year, moduleName, userAccountInfos))
			throw new AppModelException("l'année n'est pas Valid ");

		if (!isValidCoeffMoyenne(list, listDesElements, nombreDesElements))
			throw new AppModelException("Formule non correcte : Moyenne");

		if (!isValidId(list, moduleName, userAccountInfos))
			throw new AppModelException("Les Ids Des Etudiants Ne sont pas corrects ");

		
		
		// La Condition Principale qui assure la conformité du fichier
		
		
		
		
		
		if (isBetween0_20(list) 
				&& isExcell(file.getContentType()) 
				&& isValidName(profName, userAccountInfos)
				&& isValidModule(moduleName, userAccountInfos) != null
				&& isValidNiveau(className, moduleName, userAccountInfos)
				&& isValidAnne(year, moduleName, userAccountInfos)
				&& isValidCoeffMoyenne(list, listDesElements, nombreDesElements)
				&& isValidId(list, moduleName, userAccountInfos))
			return isValidModule(moduleName, userAccountInfos);

		return null;
	}

	public boolean isBetween0_20(List<ArrayList<Object>> list) throws AppModelException {

		List<Double> listDoubles = new ArrayList<Double>();

		for (int i = 3; i < list.size(); i++) {

			if (Double.compare((double) list.get(i).get(4), Double.valueOf(0)) == 1
					&& Double.compare(Double.valueOf(20), (double) list.get(i).get(4)) == 1)

			{

				//model.addAttribute("check","kolchi mrigl 0");
				// listDoubles.add((double) list.get(i).get(4));
			}

			else {

				return false;

			}

		}
		System.out.println(" Tous les notes sont entre 0 et 20 ");
		return true;
	}

	// Tester le type du fichier 
	
	
	public boolean isExcell(String type) throws AppModelException {

		
		
		if (TYPE1.equals(type) || TYPE2.equals(type)) {
			// validate file type
			System.out.println(" le fichier est un excell ");
			return true;
		}

		else {

			return false;
		}

	}

	// définir une méthode de comparaison de String 
	
	
	private String comparer(String str) {
		return str.replace("\n", "").replace(" ", "").toLowerCase();
	}

	private boolean egal(String s1, String s2) {
		return comparer(s1).equals(comparer(s2));
	}

	// Check du Header 
	
	
	private boolean isValidHeader(List<ArrayList<Object>> list) {
		
		if (list.get(0).size() != 6 || list.get(1).size() != 6) {

			System.out.println("Header not valid format");

		} else {
			System.out.println("Header size is valid ");
		}

		// Vérifier la structure du Header 
		
		
		String[][] ligne1 = new String[][] 
				{ { "Module", "Semestre", "Année" },
				{ "Enseignant", "Session", "Classe" } };
		
		String[] perfectRow2 = new String[] { "ID", "CNE", "NOM", "PRENOM" };

		
		
		for (int i = 0; i < 2; i++) {
			for (int j = 0; j < 3; j++) {
				if (!egal(ligne1[i][j], (String) list.get(i).get(j * 2))) {

					System.out.println("Format  Incorrect  " + ligne1[i][j]);
					return false;
				} else {
					System.out.println("Le header est Valide");
				}
			}
		}
		for (int i = 0; i < 4; i++) {
			if (!egal(perfectRow2[i], (String) list.get(3).get(i))) {
				// throw exception
				System.out.println("Format  Incorrect  " + perfectRow2[i]);
				return false;
			}
		}
		if (!egal((String) list.get(3).get(list.get(3).size() - 1), "Moyenne")
				|| !egal((String) list.get(2).get(list.get(2).size() - 2), "Validation")) {
			System.out.println("Format  Incorrect  ");
			return false;
		}

		return true;
	}
	
	
	// Tester la validité du Nom du prof de la session avec celle qui existe sur le fichier excell 

	public boolean isValidName(String profName, UserAndAccountInfos userAccountInfos) {

		

		if ((userAccountInfos.getPrenom() + " " + userAccountInfos.getNom()).equals(profName)) {

			// System.out.println("nom et prenom merigl");

			return true;
		}

		else {

			// throw new AppModelException("nom et prenom du Prof non Valid ");

			return false;

		}

	}
	
	// Check du module qui existe dans le fichier si il appartient a la liste des modules enseigné par le prof 

	public Module isValidModule(String moduleName, UserAndAccountInfos userAccountInfos)

	{
		Enseignant currentProf = sEnseignantService.getEnseignantById(Long.valueOf(10));
		System.out.println(currentProf.getNom());

		// list des modules du prof et check du module

		List<Module> listModules = currentProf.getModules();


		Module currentModule = null;
		for (Module module : listModules) {

			if (egal(module.getTitre(), moduleName))

			{

				currentModule = module;

				return currentModule;
			}

		}

		return null;

	}

	// check niveau ...

	public boolean isValidNiveau(String niveau, String moduleName, UserAndAccountInfos userAccountInfos)

	{

		if (isValidModule(moduleName, userAccountInfos).getNiveau().getAlias().toLowerCase()
				.equals(niveau.toLowerCase()))

		{
			System.out.println("niveau checked ");
			return true;
		}
		return false;

	}
	// check annee ... 

	public boolean isValidAnne(String annee, String moduleName, UserAndAccountInfos userAccountInfos)

	{
		String anneCurrent = isValidModule(moduleName, userAccountInfos).getNiveau().getInscriptions().get(0)
				.getAnnee();

		if (anneCurrent.equals(annee))

		{
			System.out.println("annee validee ");

			return true;
		} else {
			System.out.println("annee non validée ");

		}
		return false;

	}

	

	// check coeff & moyenne

	public boolean isValidCoeffMoyenne(List<ArrayList<Object>> list, List<Element> listDesElements,
			int elementsCountInFile) throws AppModelException {

		for (int i = 4; i < list.size(); i++) {
			double grade = (double) 0;
			double coefSum = (double) 0;
			for (int j = 4; j < 4 + elementsCountInFile; j++) {
				// System.out.println("{" + i + "}" + "{" + j + "}" + " : " + (Double)
				// list.get(i).get(j));
				grade += listDesElements.get(j - 4).getCurrentCoefficient() * (Double) list.get(i).get(j);
				coefSum += listDesElements.get(j - 4).getCurrentCoefficient();
			}
			// error: formula not correct
			grade /= coefSum;
			if (Math.abs(grade - (Double) list.get(i).get(list.get(i).size() - 2)) > 0.01) {

				return false;
			} else if (grade >= 12 && !egal((String) list.get(i).get(list.get(i).size() - 1), "V")) {

				return false;
			}

		}
		System.out.println(" Coeff et moyennee validé ");
		return true;

	}
	

	// check list ID students 

	public boolean isValidId(List<ArrayList<Object>> list, String moduleName, UserAndAccountInfos userAccountInfos)

	{

		List<Long> listIDEtudiantsBD = new ArrayList<Long>();

		List<Long> listIDEtudiantsFichier = new ArrayList<Long>();

		for (InscriptionAnnuelle inscriptionAnnuelle : isValidModule(moduleName, userAccountInfos).getNiveau()
				.getInscriptions()) {
			listIDEtudiantsBD.add(inscriptionAnnuelle.getEtudiant().getIdUtilisateur());
		}

		for (int i = 3; i < list.size(); i++)

		{
			listIDEtudiantsFichier.add(((Double) list.get(i).get(0)).longValue());

		}

		if (Integer.compare(listIDEtudiantsFichier.size(), listIDEtudiantsBD.size()) != 0)

		{

			System.out.println("Probleme de la liste des etudiants size ");
			// return false;

		} else {
			System.out.println("Pas de Probleme dans la liste des etudiants size ");

		}

		System.out.println(listIDEtudiantsBD.size());

		for (int i = 0; i < listIDEtudiantsBD.size(); i++) {

			if (!listIDEtudiantsFichier.contains(listIDEtudiantsBD.get(i))) {
				System.out.println(
						" Probleme d'étudiant d'id  " + listIDEtudiantsBD.get(i) + "  n'existe pas dans la BD ");
				return false;

			}

		}
		System.out.println(" All IDS are checked ");

		return true;

		// check list cin
		/*
		 * for ( int i =3 ; i < list.size()-3; i++)
		 * 
		 * { listIDEtudiantsFichier.get(3-i);
		 * 
		 * }
		 * 
		 * 
		 * 
		 * return false;
		 */

	}
}
