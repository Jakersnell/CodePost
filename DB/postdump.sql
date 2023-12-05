-- MySQL dump 10.13  Distrib 5.7.39, for osx11.0 (x86_64)
--
-- Host: localhost    Database: codepostdb
-- ------------------------------------------------------
-- Server version	5.7.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(30) NOT NULL,
  `title` varchar(60) NOT NULL,
  `description` varchar(350) DEFAULT NULL,
  `code_snippet` blob,
  `language` set('RUST','JAVA','PYTHON') NOT NULL,
  `created_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'jakersnell','Hello, World! in rust!',NULL,_binary 'fn main() {\n  println!(\"Hello, World!\");\n}','RUST','2023-12-03 12:20:51','2023-12-03 12:20:51'),(3,'Jake','Test Post','Test Post Rust.',_binary 'fn&nbsp;return_string(string:&nbsp;&amp;str)&nbsp;-&gt;&nbsp;String&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string.to_owned()\r\n}','RUST','2023-12-03 16:56:48','2023-12-03 16:56:48'),(7,'Jake','Replacing html specific characters with entities','Below is some code I used to replace html characters with entities to prevent mis-use and code format/highlighting errors. Normally I wouldn\'t even think of posting source code too the website its for, but seeing as this website doesnt have a strict need for security, and that its on github, I thought it would be neat.',_binary 'package com.codepost.utils;\r\n\r\nimport java.util.HashMap;\r\n\r\npublic class CharMapper {\r\n\r\n	private static HashMap<Character, String> defaultMappings = new HashMap<>();\r\n\r\n	static {\r\n		String[][] htmlEntities = { { \" \", \"nbsp\" }, { \"<\", \"lt\" }, { \">\", \"gt\" }, { \"&\", \"amp\" }, { \"\\\"\", \"quot\" },\r\n				{ \"\'\", \"apos\" }, { \"¢\", \"cent\" }, { \"£\", \"pound\" }, { \"¥\", \"yen\" }, { \"€\", \"euro\" }, { \"©\", \"copy\" },\r\n				{ \"®\", \"reg\" } };\r\n		for (String[] valuePair : htmlEntities) {\r\n			defaultMappings.put(valuePair[0].charAt(0), \"&\" + valuePair[1] + \";\");\r\n		}\r\n	}\r\n\r\n	public static CharMapper htmlEntityMapper() {\r\n		return new CharMapper(new HashMap<>(CharMapper.defaultMappings));\r\n	}\r\n\r\n	private HashMap<Character, String> mappings;\r\n\r\n	public CharMapper(HashMap<Character, String> mappings) {\r\n		this.mappings = mappings;\r\n	}\r\n\r\n	public String process(String snippet) {\r\n		StringBuilder processed = new StringBuilder();\r\n\r\n		for (char c : snippet.toCharArray()) {\r\n			String mapped = mappings.get(c);\r\n\r\n			if (mapped == null) {\r\n				mapped = String.valueOf(c);\r\n			}\r\n\r\n			processed.append(mapped);\r\n		}\r\n\r\n		return processed.toString();\r\n	}\r\n\r\n}','JAVA','2023-12-03 23:28:40','2023-12-03 23:28:40'),(8,'Jake','Ray tracer core logic','Core logic in a ray-tracer I wrote in rust.',_binary '    pub fn render(&self, max_depth: u8, samples: u32) -> Vec<u8> {\r\n        let mut output = Vec::new();\r\n        // Iterate over pixels, starting at the bottom left corner of the image\r\n        for x in 0..self.camera.image_width {\r\n            for y in 0..self.camera.image_height {\r\n                // Monte carlo method sampling for ray effects on current pixel.\r\n                let mut colors = Vec::new();\r\n                for _sample_ in 0..samples {\r\n                    let ray = self.camera.gen_ray(x, y);\r\n                    if let Some(color) = self.render_ray(ray, max_depth, samples) {\r\n                        colors.push(color);\r\n                    }\r\n                }\r\n                // Average samples together, push bytes.\r\n                Color::average(colors).out().map(|byte| output.push(byte));\r\n            }\r\n        }\r\n        output\r\n    }\r\n\r\n    pub fn render_ray(&self, ray: Ray3, depth: u8, samples: u32) -> Option<Color> {\r\n        let mut result_color: Option<Color> = None;\r\n        if depth != 0 {\r\n            if let Some((object, point, normal, distance)) = self.trace_ray(&ray) {\r\n                let mut return_colors = Vec::new();\r\n                return_colors.append(&mut self.direct_shading(object, point, normal));\r\n                return_colors\r\n                    .append(&mut self.indirect_shading(&ray, object, point, normal, depth));\r\n                // averaging colors\r\n                if !return_colors.is_empty() {\r\n                    result_color = Some(Color::average(return_colors));\r\n                }\r\n            }\r\n        }\r\n        result_color\r\n    }\r\n\r\n    fn direct_shading(&self, object: &Object, point: Vector3, normal: Vector3) -> Vec<Color> {\r\n        let mut return_colors = Vec::new();\r\n        for light in self.world.lights() {\r\n            let distance = light.position.distance_to(point);\r\n            let shadow_ray = Ray3::new(light.position, light.position - point);\r\n            if trace_ray(&shadow_ray, self.world, self.t_min, distance).is_none() {\r\n                let light_color = light.color * light.intensity * inv_sqr(distance);\r\n                object\r\n                    .material\r\n                    .direct_shade(light_color, shadow_ray.direction, normal)\r\n                    .map(|shaded_color| return_colors.push(shaded_color));\r\n            }\r\n        }\r\n        return_colors\r\n    }\r\n\r\n    fn indirect_shading(\r\n        &self,\r\n        ray: &Ray3,\r\n        object: &Object,\r\n        point: Vector3,\r\n        normal: Vector3,\r\n        depth: u8,\r\n    ) -> Vec<Color> {\r\n        let mut return_colors = Vec::new();\r\n        object\r\n            .material()\r\n            .reflect(ray.direction, point, normal)\r\n            .map(|out_ray| {\r\n                render_ray(out_ray, self.world, self.t_min, self.t_max, depth - 1).map(|color| {\r\n                    object\r\n                        .material\r\n                        .indirect_shade(color)\r\n                        .map(|shaded_color| return_colors.push(shaded_color))\r\n                });\r\n            });\r\n        return_colors\r\n    }\r\n\r\n    pub fn trace_ray(&self, ray: &Ray3) -> Option<(&\'a Object, Vector3, Vector3, f64)> {\r\n        let mut distance = self.t_max;\r\n        let mut result: Option<(&\'a Object, Vector3, Vector3, f64)> = None;\r\n\r\n        for object in self.world.objects() {\r\n            if let Some(t) = object.geometry().check_intersect(ray, self.t_min, distance) {\r\n                let point = ray.at(t);\r\n                let normal = object.geometry().opposing_normal(&point, &ray.direction);\r\n                distance = ray.origin.distance_to(point);\r\n                assert_eq!(distance, t);\r\n                result = Some((&object, point, normal, distance))\r\n            }\r\n        }\r\n        result\r\n    }','RUST','2023-12-03 23:35:10','2023-12-03 23:35:10'),(9,'Jake','Python Django Request handler','',_binary 'from django.shortcuts import render, redirect\r\nfrom django.contrib import messages\r\nfrom .forms import UserRegisterForm, UserUpdateForm, ProfileUpdateForm\r\nfrom django.views.generic import DetailView\r\nfrom django.contrib.auth.decorators import login_required\r\nfrom .models import Profile\r\n# Create your views here.\r\n\r\ndef register_view(request):\r\n    if request.method == \'POST\':\r\n        form = UserRegisterForm(request.POST)\r\n        if form.is_valid():\r\n            form.save()\r\n            username = form.cleaned_data.get(\'username\')\r\n            messages.success(request, \'Your account is now active!\')\r\n            return redirect(\'user-login\')\r\n\r\n    else:\r\n        form = UserRegisterForm()\r\n    return render(request, \'users/register.html\', {\'form\': form})\r\n\r\n\r\n@login_required\r\ndef myprofile_view(request):\r\n    return render(request, \'users/myprofile.html\')\r\n\r\n\r\n@login_required\r\ndef edit_myprofile_view(request):\r\n    if request.method == \'POST\':\r\n        u_form = UserUpdateForm(request.POST, instance=request.user)\r\n        p_form = ProfileUpdateForm(request.POST,\r\n                                   request.FILES,\r\n                                   instance=request.user.profile)\r\n        if u_form.is_valid() and p_form.is_valid():\r\n            u_form.save()\r\n            p_form.save()\r\n            return redirect(\'user-myprofile\')\r\n\r\n    u_form = UserUpdateForm(instance=request.user)\r\n    p_form = ProfileUpdateForm(instance=request.user.profile)\r\n    context = {\r\n        \'u_form\': u_form,\r\n        \'p_form\': p_form,\r\n              }\r\n    return render(request, \'users/edit_myprofile.html\', context)\r\n\r\n\r\nclass ProfileView(DetailView):\r\n    model = Profile\r\n    template_name = \'users/profile.html\'\r\n    context_object_name = \'profile\'\r\n    ','PYTHON','2023-12-03 23:45:27','2023-12-03 23:45:27');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-05 10:16:45
