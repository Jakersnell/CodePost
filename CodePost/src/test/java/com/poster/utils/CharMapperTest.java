package com.poster.utils;

import static com.codepost.utils.CharMapper.htmlEntityMapper;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.codepost.utils.CharMapper;

class CharMapperTest {

	@Test
	void test_html_entities_are_correctly_mapped() {
		CharMapper processor = htmlEntityMapper();
		String testInput = " <>&\"'¢£¥€©®";
		String testOutput = processor.process(testInput);

		String controlOutput = "&nbsp;&lt;&gt;&amp;&quot;&apos;&cent;&pound;&yen;&euro;&copy;&reg;";

		assertEquals(testOutput, controlOutput);
	}

}
