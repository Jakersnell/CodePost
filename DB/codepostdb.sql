DROP SCHEMA IF EXISTS `codepostdb`;

CREATE SCHEMA IF NOT EXISTS `codepostdb` DEFAULT CHARACTER SET utf8;


USE `codepostdb`;

DROP TABLE IF EXISTS `codepostdb`.`post`;

CREATE TABLE IF NOT EXISTS `codepostdb`.`post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(30) NOT NULL,
  `title` varchar(60) NOT NULL,
  `description` varchar(350) DEFAULT NULL,
  `code_snippet` text,
  `language`
  set
('RUST', 'JAVA', 'PYTHON') NOT NULL,
    `created_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;

SET SQL_MODE = '';
DROP USER IF EXISTS application;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'application' IDENTIFIED BY 'application';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'application';


INSERT INTO
  `post`
VALUES
  (
    1,
    'jakersnell',
    'Hello, World! in rust!',
    NULL,
    'fn main() {\n  println!(\"Hello, World!\");\n}',
    'RUST',
    '2023-12-03 12:20:51',
    '2023-12-03 12:20:51'
  ),
(
    2,
    'Jake',
    'Test Post',
    'Test Post Python.',
    'def hello_world():\r\n        print(\"Hello, World!\")\r\n\r\nhello_world()',
    'PYTHON',
    '2023-12-03 16:55:05',
    '2023-12-03 16:55:05'
  ),
(
    3,
    'Jake',
    'Test Post',
    'Test Post Rust.',
    'fn&nbsp;return_string(string:&nbsp;&amp;str)&nbsp;-&gt;&nbsp;String&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string.to_owned()\r\n}',
    'RUST',
    '2023-12-03 16:56:48',
    '2023-12-03 16:56:48'
  ),
(
    7,
    'Jake',
    'Replacing html specific characters with entities',
    'Below is some code I used to replace html characters with entities to prevent mis-use and code format/highlighting errors.',
    'package com.codepost.utils;\r\n\r\nimport java.util.HashMap;\r\n\r\npublic class CharMapper {\r\n\r\n	private static HashMap<Character, String> defaultMappings = new HashMap<>();\r\n\r\n	static {\r\n		String[][] htmlEntities = { { \" \", \"nbsp\" }, { \"<\", \"lt\" }, { \">\", \"gt\" }, { \"&\", \"amp\" }, { \"\\\"\", \"quot\" },\r\n				{ \"\'\", \"apos\" }, { \"¢\", \"cent\" }, { \"£\", \"pound\" }, { \"¥\", \"yen\" }, { \"€\", \"euro\" }, { \"©\", \"copy\" },\r\n				{ \"®\", \"reg\" } };\r\n		for (String[] valuePair : htmlEntities) {\r\n			defaultMappings.put(valuePair[0].charAt(0), \"&\" + valuePair[1] + \";\");\r\n		}\r\n	}\r\n\r\n	public static CharMapper htmlEntityMapper() {\r\n		return new CharMapper(new HashMap<>(CharMapper.defaultMappings));\r\n	}\r\n\r\n	private HashMap<Character, String> mappings;\r\n\r\n	public CharMapper(HashMap<Character, String> mappings) {\r\n		this.mappings = mappings;\r\n	}\r\n\r\n	public String process(String snippet) {\r\n		StringBuilder processed = new StringBuilder();\r\n\r\n		for (char c : snippet.toCharArray()) {\r\n			String mapped = mappings.get(c);\r\n\r\n			if (mapped == null) {\r\n				mapped = String.valueOf(c);\r\n			}\r\n\r\n			processed.append(mapped);\r\n		}\r\n\r\n		return processed.toString();\r\n	}\r\n\r\n}',
    'JAVA',
    '2023-12-03 23:28:40',
    '2023-12-03 23:28:40'
  ),
(
    8,
    'Jake',
    'Ray tracer core logic',
    'Core logic in a ray-tracer I wrote in rust.',
    '&nbsp;&nbsp;&nbsp;&nbsp;pub&nbsp;fn&nbsp;render(&amp;self,&nbsp;max_depth:&nbsp;u8,&nbsp;samples:&nbsp;u32)&nbsp;-&gt;&nbsp;Vec&lt;u8&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;output&nbsp;=&nbsp;Vec::new();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;Iterate&nbsp;over&nbsp;pixels,&nbsp;starting&nbsp;at&nbsp;the&nbsp;bottom&nbsp;left&nbsp;corner&nbsp;of&nbsp;the&nbsp;image\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for&nbsp;x&nbsp;in&nbsp;0..self.camera.image_width&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;Which&nbsp;orientation&nbsp;of&nbsp;x&nbsp;&amp;&nbsp;y&nbsp;iteration&nbsp;is&nbsp;best,&nbsp;is&nbsp;this&nbsp;causing&nbsp;pixel&nbsp;inversion?\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for&nbsp;y&nbsp;in&nbsp;0..self.camera.image_height&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;Monte&nbsp;carlo&nbsp;method&nbsp;sampling&nbsp;for&nbsp;ray&nbsp;effects&nbsp;on&nbsp;current&nbsp;pixel.\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;colors&nbsp;=&nbsp;Vec::new();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for&nbsp;_sample_&nbsp;in&nbsp;0..samples&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;ray&nbsp;=&nbsp;self.camera.gen_ray(x,&nbsp;y);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;let&nbsp;Some(color)&nbsp;=&nbsp;self.render_ray(ray,&nbsp;max_depth,&nbsp;samples)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;colors.push(color);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;Average&nbsp;samples&nbsp;together,&nbsp;push&nbsp;bytes.\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Color::average(colors).out().map(|byte|&nbsp;output.push(byte));\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;pub&nbsp;fn&nbsp;render_ray(&amp;self,&nbsp;ray:&nbsp;Ray3,&nbsp;depth:&nbsp;u8,&nbsp;samples:&nbsp;u32)&nbsp;-&gt;&nbsp;Option&lt;Color&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;result_color:&nbsp;Option&lt;Color&gt;&nbsp;=&nbsp;None;\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;depth&nbsp;!=&nbsp;0&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;let&nbsp;Some((object,&nbsp;point,&nbsp;normal,&nbsp;distance))&nbsp;=&nbsp;self.trace_ray(&amp;ray)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;return_colors&nbsp;=&nbsp;Vec::new();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return_colors.append(&amp;mut&nbsp;self.direct_shading(object,&nbsp;point,&nbsp;normal));\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return_colors\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.append(&amp;mut&nbsp;self.indirect_shading(&amp;ray,&nbsp;object,&nbsp;point,&nbsp;normal,&nbsp;depth));\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;averaging&nbsp;colors\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;!return_colors.is_empty()&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result_color&nbsp;=&nbsp;Some(Color::average(return_colors));\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result_color\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;fn&nbsp;direct_shading(&amp;self,&nbsp;object:&nbsp;&amp;Object,&nbsp;point:&nbsp;Vector3,&nbsp;normal:&nbsp;Vector3)&nbsp;-&gt;&nbsp;Vec&lt;Color&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;return_colors&nbsp;=&nbsp;Vec::new();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for&nbsp;light&nbsp;in&nbsp;self.world.lights()&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;distance&nbsp;=&nbsp;light.position.distance_to(point);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;shadow_ray&nbsp;=&nbsp;Ray3::new(light.position,&nbsp;light.position&nbsp;-&nbsp;point);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;trace_ray(&amp;shadow_ray,&nbsp;self.world,&nbsp;self.t_min,&nbsp;distance).is_none()&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;light_color&nbsp;=&nbsp;light.color&nbsp;*&nbsp;light.intensity&nbsp;*&nbsp;inv_sqr(distance);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.material\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.direct_shade(light_color,&nbsp;shadow_ray.direction,&nbsp;normal)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.map(|shaded_color|&nbsp;return_colors.push(shaded_color));\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return_colors\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;fn&nbsp;indirect_shading(\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;self,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ray:&nbsp;&amp;Ray3,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object:&nbsp;&amp;Object,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;point:&nbsp;Vector3,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;normal:&nbsp;Vector3,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;depth:&nbsp;u8,\r\n&nbsp;&nbsp;&nbsp;&nbsp;)&nbsp;-&gt;&nbsp;Vec&lt;Color&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;return_colors&nbsp;=&nbsp;Vec::new();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.material()\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.reflect(ray.direction,&nbsp;point,&nbsp;normal)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.map(|out_ray|&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;render_ray(out_ray,&nbsp;self.world,&nbsp;self.t_min,&nbsp;self.t_max,&nbsp;depth&nbsp;-&nbsp;1).map(|color|&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.material\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.indirect_shade(color)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.map(|shaded_color|&nbsp;return_colors.push(shaded_color))\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;});\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;});\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return_colors\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;pub&nbsp;fn&nbsp;trace_ray(&amp;self,&nbsp;ray:&nbsp;&amp;Ray3)&nbsp;-&gt;&nbsp;Option&lt;(&amp;&apos;a&nbsp;Object,&nbsp;Vector3,&nbsp;Vector3,&nbsp;f64)&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;distance&nbsp;=&nbsp;self.t_max;\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;mut&nbsp;result:&nbsp;Option&lt;(&amp;&apos;a&nbsp;Object,&nbsp;Vector3,&nbsp;Vector3,&nbsp;f64)&gt;&nbsp;=&nbsp;None;\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for&nbsp;object&nbsp;in&nbsp;self.world.objects()&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;let&nbsp;Some(t)&nbsp;=&nbsp;object.geometry().check_intersect(ray,&nbsp;self.t_min,&nbsp;distance)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;point&nbsp;=&nbsp;ray.at(t);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;let&nbsp;normal&nbsp;=&nbsp;object.geometry().opposing_normal(&amp;point,&nbsp;&amp;ray.direction);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;distance&nbsp;=&nbsp;ray.origin.distance_to(point);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert_eq!(distance,&nbsp;t);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result&nbsp;=&nbsp;Some((&amp;object,&nbsp;point,&nbsp;normal,&nbsp;distance))\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result\r\n&nbsp;&nbsp;&nbsp;&nbsp;}',
    'RUST',
    '2023-12-03 23:35:10',
    '2023-12-03 23:35:10'
  ),
(
    9,
    'Jake',
    'Python Django Request handler',
    '',
    'from&nbsp;django.shortcuts&nbsp;import&nbsp;render,&nbsp;redirect\r\nfrom&nbsp;django.contrib&nbsp;import&nbsp;messages\r\nfrom&nbsp;.forms&nbsp;import&nbsp;UserRegisterForm,&nbsp;UserUpdateForm,&nbsp;ProfileUpdateForm\r\nfrom&nbsp;django.views.generic&nbsp;import&nbsp;DetailView\r\nfrom&nbsp;django.contrib.auth.decorators&nbsp;import&nbsp;login_required\r\nfrom&nbsp;.models&nbsp;import&nbsp;Profile\r\n#&nbsp;Create&nbsp;your&nbsp;views&nbsp;here.\r\n\r\ndef&nbsp;register_view(request):\r\n&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;request.method&nbsp;==&nbsp;&apos;POST&apos;:\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;form&nbsp;=&nbsp;UserRegisterForm(request.POST)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;form.is_valid():\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;form.save()\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;username&nbsp;=&nbsp;form.cleaned_data.get(&apos;username&apos;)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;messages.success(request,&nbsp;&apos;Your&nbsp;account&nbsp;is&nbsp;now&nbsp;active!&apos;)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;redirect(&apos;user-login&apos;)\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;else:\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;form&nbsp;=&nbsp;UserRegisterForm()\r\n&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;render(request,&nbsp;&apos;users/register.html&apos;,&nbsp;{&apos;form&apos;:&nbsp;form})\r\n\r\n\r\n@login_required\r\ndef&nbsp;myprofile_view(request):\r\n&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;render(request,&nbsp;&apos;users/myprofile.html&apos;)\r\n\r\n\r\n@login_required\r\ndef&nbsp;edit_myprofile_view(request):\r\n&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;request.method&nbsp;==&nbsp;&apos;POST&apos;:\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u_form&nbsp;=&nbsp;UserUpdateForm(request.POST,&nbsp;instance=request.user)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p_form&nbsp;=&nbsp;ProfileUpdateForm(request.POST,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;request.FILES,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;instance=request.user.profile)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;u_form.is_valid()&nbsp;and&nbsp;p_form.is_valid():\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u_form.save()\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p_form.save()\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;redirect(&apos;user-myprofile&apos;)\r\n\r\n&nbsp;&nbsp;&nbsp;&nbsp;u_form&nbsp;=&nbsp;UserUpdateForm(instance=request.user)\r\n&nbsp;&nbsp;&nbsp;&nbsp;p_form&nbsp;=&nbsp;ProfileUpdateForm(instance=request.user.profile)\r\n&nbsp;&nbsp;&nbsp;&nbsp;context&nbsp;=&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&apos;u_form&apos;:&nbsp;u_form,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&apos;p_form&apos;:&nbsp;p_form,\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;render(request,&nbsp;&apos;users/edit_myprofile.html&apos;,&nbsp;context)\r\n\r\n\r\nclass&nbsp;ProfileView(DetailView):\r\n&nbsp;&nbsp;&nbsp;&nbsp;model&nbsp;=&nbsp;Profile\r\n&nbsp;&nbsp;&nbsp;&nbsp;template_name&nbsp;=&nbsp;&apos;users/profile.html&apos;\r\n&nbsp;&nbsp;&nbsp;&nbsp;context_object_name&nbsp;=&nbsp;&apos;profile&apos;\r\n&nbsp;&nbsp;&nbsp;&nbsp;',
    'PYTHON',
    '2023-12-03 23:45:27',
    '2023-12-03 23:45:27'
  );