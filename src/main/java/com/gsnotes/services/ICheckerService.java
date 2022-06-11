package com.gsnotes.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.gsnotes.bo.Module;
import com.gsnotes.exceptionhandlers.AppModelException;
import com.gsnotes.web.models.UserAndAccountInfos;

public interface ICheckerService {
	
	
	public Module isValid(MultipartFile file,UserAndAccountInfos userAccountInfos) throws AppModelException;
	
	
	

}
