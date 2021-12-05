package com.tanchengjin.generatorcode.core;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;

public class FreemarkerEngine {
    private String outputDir;
    private Configuration configuration;
    //文件后缀
    private String prefix = ".ftl";

    public FreemarkerEngine(String outputDir, String templateDir) {
        this(outputDir, templateDir, ".ftl");
    }

    public FreemarkerEngine(String outputDir, String templateDir, String prefix) {
        setPrefix(prefix);
        setOutputDir(outputDir);
        this.configuration = new Configuration(Configuration.VERSION_2_3_31);
        try {
            this.configuration.setDirectoryForTemplateLoading(new File(templateDir));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void generate(Object o, String template, Writer out) {
        try {
            Template t = this.configuration.getTemplate(template);
            t.process(o, out);
        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        }
    }

    public void generate(Object o, String template, String out) {
        checkStoreDirectory(trim(this.outputDir) + out);
        this.generate(o, template, pathToWriter(trim(this.outputDir) + out));
    }

    private Writer pathToWriter(String p) {
        Writer w = null;
        File file = new File(p);
        try {
            w = new OutputStreamWriter(new FileOutputStream(file));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        return w;
    }

    private boolean checkStoreDirectory(String path) {
        int i = path.lastIndexOf("/");
        String substring = path.substring(0, i);
        File file = new File(substring);
        if (!file.exists()) {
            return file.mkdirs();
        }
        return false;
    }

    private void createOutputDir() {
        File file = new File(this.outputDir);
        System.out.println(file.toString());
        if (!file.exists()) {
            if (!file.mkdirs()) {
                new Exception("output not create:" + outputDir).printStackTrace();
            }
        }
    }

    public String getOutputDir() {
        return outputDir;
    }

    public void setOutputDir(String outputDir) {
        this.outputDir = endsMatch(outputDir, "/") ? outputDir : outputDir + "/";
        File file = new File(this.outputDir);
        if (!file.exists()) {
            boolean mkdirs = file.mkdirs();
            if (!mkdirs) new Exception("output dir create failure").printStackTrace();
        }
    }

    public Configuration getConfiguration() {
        return configuration;
    }

    public void setConfiguration(Configuration configuration) {
        this.configuration = configuration;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    private boolean endsMatch(String s, String t) {
        String substring = s.substring(s.length() - 1);
        return (substring.equals(t));
    }

    private String trim(String v) {
        return endsMatch(v, "/") ? v : v + "/";
    }
}
