package com.jasper.controller;

import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;


@Controller
@RequestMapping("/")
public class Forward {
    private static final Logger logger = LoggerFactory.getLogger(Forward.class);
    @RequestMapping("/index")
    public String index() {
        return "/index";
    }

    @RequestMapping("/dogge")
    @ResponseBody
    public String dogge() {
        boolean flag = Math.random() > 0.5;
        return "{\"flag\":\""+flag+"\"}";
    }

    @ResponseBody
    @RequestMapping(path="/test", method= RequestMethod.POST)
    public String test(@RequestParam("photoPath") String photoPath){
        if (photoPath == null && photoPath.trim().length() < 1) {
            return "{\"code\":\"-1\"}";
        }
        boolean flag = false;
        try {
            String[] args = new String[3];
            args[0] = "python";
            args[1] = "/home/bkxpao/classifier/bin/valid.py";
            args[2] = "--test_path=" + photoPath;
            Process process = Runtime.getRuntime().exec(args);
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"GBK"));
            String line = null;
            String result = null;
            while ((line = in.readLine()) != null) {
                System.out.println(line);
                result = line;
            }
            in.close();
            //java代码中的process.waitFor()返回值为0表示我们调用python脚本成功，
            //返回值为1表示调用python脚本失败，这和我们通常意义上见到的0与1定义正好相反
            int re = process.waitFor();
            if (re != 0 ) {
                return "{\"code\":\"-1\"}";
            }
            flag = "1".equals(result);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{\"code\":\"0\",\"flag\":\""+flag+"\"}";
    }
}