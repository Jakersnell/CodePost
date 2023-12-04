package com.codepost.utils;

import java.util.HashMap;

public class CharMapper {

	private static HashMap<Character, String> defaultMappings = new HashMap<>();

	static {
		String[][] htmlEntities = { { " ", "nbsp" }, { "<", "lt" }, { ">", "gt" }, { "&", "amp" }, { "\"", "quot" },
				{ "'", "apos" }, { "¢", "cent" }, { "£", "pound" }, { "¥", "yen" }, { "€", "euro" }, { "©", "copy" },
				{ "®", "reg" } };
		for (String[] valuePair : htmlEntities) {
			defaultMappings.put(valuePair[0].charAt(0), "&" + valuePair[1] + ";");
		}
	}

	public static CharMapper htmlEntityMapper() {
		return new CharMapper(new HashMap<>(CharMapper.defaultMappings));
	}

	private HashMap<Character, String> mappings;

	public CharMapper(HashMap<Character, String> mappings) {
		this.mappings = mappings;
	}

	public String process(String snippet) {
		StringBuilder processed = new StringBuilder();

		for (char c : snippet.toCharArray()) {
			String mapped = mappings.get(c);

			if (mapped == null) {
				mapped = String.valueOf(c);
			}

			processed.append(mapped);
		}

		return processed.toString();
	}

}
