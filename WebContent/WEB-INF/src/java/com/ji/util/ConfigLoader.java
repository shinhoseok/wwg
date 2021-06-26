package com.ji.util;

import java.io.IOException;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import egovframework.rte.fdl.property.impl.EgovPropertyServiceImpl;

/**
 * JH test
 * @author Administrator
 *
 */
public class ConfigLoader {
	private static ConfigLoader configInstance = null;
	private String configFileName = "egovframework/spring/context-properties.xml";
	private static EgovPropertyServiceImpl config = null;

	
	private ConfigLoader() throws IOException {
		String[] configLocation = new String[]{configFileName};
		
		ApplicationContext context = new ClassPathXmlApplicationContext(configLocation);
		config = (EgovPropertyServiceImpl)context.getBean("propertiesService");

		
		System.out.println("config :: ["+config+"]");
	}
	
	public static ConfigLoader getInstance() {
		if (configInstance == null) {
			try {
				configInstance = new ConfigLoader();
			} catch (IOException e) {
				System.out.println("ConfigLoader ERROR");
			}
		}
		return configInstance;
	}
	
	public static EgovPropertyServiceImpl getConfig() {
		try {
			if (config == null) {
				throw new IOException("Config is not loaded.");
			}
		} catch (IOException e) {
			System.out.println("EgovPropertyServiceImpl ERROR");
		}
		
		return config;
	} 
}
