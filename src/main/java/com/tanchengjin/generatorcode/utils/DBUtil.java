package com.tanchengjin.generatorcode.utils;

import com.tanchengjin.generatorcode.core.entity.Field;
import com.tanchengjin.generatorcode.core.entity.FieldType;
import com.tanchengjin.generatorcode.core.entity.TableInfo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DBUtil {
    private static DBUtil instance;

    private Connection connection;

    private Statement statement;

    private static final String url = "jdbc:mysql://localhost:3306/blog?serverTimezone=PRC&useInformationSchema=true";

    public static final String showFullColumnTypeSql = "show full columns from %s;";

    public static final String toSql = "show create table %s;";

    public static final String descSql = "desc %s;";

    public static final String constructSql = "select * from information_schema.COLUMNS where TABLE_SCHEMA = '%s' and TABLE_NAME = '%s'";

    private DBUtil() {

    }

    public static DBUtil getInstance() {
        if (instance == null) {
            instance = new DBUtil();
            instance.init();
        }
        return instance;
    }

    private void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog?serverTimezone=PRC&useInformationSchema=true", "root", "root");
            if (connection != null) {
                instance.connection = connection;
                this.statement = connection.createStatement();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 通过JDBC METAData获取表信息
     *
     * @param tableName 表名
     * @return
     */
    public TableInfo getTableInfoBYMetaData(String tableName) {
        TableInfo tableInfo = new TableInfo();
        try {
            DatabaseMetaData metaData = statement.getConnection().getMetaData();
            ResultSet tables = metaData.getTables(null, null, "%", new String[]{"TABLE"});

            while (tables.next()) {
                tableInfo.setTableName(tables.getString("TABLE_NAME"));
                System.out.println(tables.getString("TABLE_SCHEM"));
                System.out.println(tables.getString("TABLE_NAME"));
                tableInfo.setTableType(tables.getString("TABLE_TYPE"));
                System.out.println(tables.getString("REMARKS"));
                tableInfo.setComment(tables.getString("REMARKS"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableInfo;
    }

    /**
     * 获取所有表的信息
     *
     * @return list
     * @deprecated
     */
    public List<TableInfo> getAllTableInfo() {
        ArrayList<TableInfo> tableInfos = new ArrayList<TableInfo>();
        try {
            Statement statement = connection.createStatement();
            ResultSet show_tables = statement.executeQuery("show tables");
            while (show_tables.next()) {
                TableInfo tableInfo = new TableInfo();
                String tableName = show_tables.getString(1);
                tableInfo.setTableName(tableName);
                List<Field> fieldList = getFieldByTableName(tableName);
                tableInfo.setFieldList(fieldList);
                String DDL = getDDL(tableName);
                tableInfo.setDDL(DDL);
                tableInfo.setComment(getTableComment(DDL));
                tableInfo.setPrimaryKey(getPrimaryKeyField(fieldList).getName());
                tableInfos.add(tableInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableInfos;
    }

    public TableInfo getTableInfo(String tableName) {
        return this.getTableInfo(tableName, null);
    }

    /**
     * @param tableName 表名
     * @param prefix    要去除的表前缀
     * @return TableInfo
     */
    public TableInfo getTableInfo(String tableName, String prefix) {
        TableInfo tableInfo = new TableInfo();
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tableRet = metaData.getTables(null, "%", tableName, new String[]{"TABLE"});


            if (tableRet == null) {
                System.out.println("数据表不存在");
                return tableInfo;
            }

            while (tableRet.next()) {
                String tn = tableRet.getString("TABLE_NAME");
                tableInfo.setTableName(tn);
                tableInfo.setName(wipeOffPrefix(tn, prefix));
                tableInfo.setPrefix(prefix);
                tableInfo.setTableType(tableRet.getString("TABLE_TYPE"));
                List<Field> fieldList = getFieldByTableName(tn);
                tableInfo.setFieldList(fieldList);
                String DDL = getDDL(tn);
                tableInfo.setDDL(DDL);
                tableInfo.setComment(getTableComment(DDL));
                //设置主键
                tableInfo.setPrimaryKey(getPrimaryKeyField(fieldList).getName());
                //设置主键字段
                tableInfo.setPrimaryKeyField(getPrimaryKeyField(fieldList));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tableInfo;
    }

    private String wipeOffPrefix(String tableName, String prefix) {
        String t = tableName;
        if (prefix != null && !prefix.isEmpty() && tableName.startsWith(prefix)) {
            t = tableName.substring(prefix.length(), tableName.length());
        }
        return t;
    }

    //获取表中所有字段信息
    public List<Field> getFieldByTableName(String tableName) {
        ArrayList<Field> fields = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery(String.format(showFullColumnTypeSql, tableName));
            while (resultSet.next()) {
                Field field = new Field();
                //列名
                field.setName(resultSet.getString("Field"));
                //类型
                field.setType(resultSet.getString("Type"));
                //注释
                field.setComment(resultSet.getString("Comment"));
                //是否可为空
                field.setNullable("YES".equals(resultSet.getString("Null")));
                //是否主键
                field.setPrimaryKey(resultSet.getString("KEY").equals("PRI"));
                //映射java类型
                field.setFieldType(getJavaType(resultSet.getString("Type")));
                fields.add(field);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fields;
    }

    /**
     * 获取数据库建表语句
     *
     * @param tableName table name
     * @return String
     */
    public String getDDL(String tableName) {

        String DDL = null;
        try {
            ResultSet resultSet = statement.executeQuery(String.format(toSql, tableName));
            if (resultSet != null && resultSet.next()) {
                DDL = resultSet.getString(2);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return DDL;
    }

    private Field getPrimaryKeyField(List<Field> fields) {
        Field f = new Field();
        for (Field field : fields) {
            if (field.isPrimaryKey()) f = field;
        }
        return f;

    }

    private void destroy() {
        try {
            if (connection != null) connection.close();
            if (statement != null) statement.close();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    /**
     * 在DDL中得到该表的注释
     *
     * @param ddl DDL
     * @return String
     */
    public String getTableComment(String ddl) {
        String comment = "";
        if (ddl.isEmpty()) return comment;
        String cds = "COMMENT='";
        int i = ddl.indexOf(cds);
        if (i >= 1) {
            String substring = ddl.substring(i + cds.length());
            comment = substring.substring(0, substring.length() - 1);
        }
        return comment;
    }


    /**
     * 获取Java类型
     *
     * @param type jdbc源类型
     * @return FieldType
     */
    private FieldType getJavaType(String type) {
        FieldType fieldType = new FieldType();
        fieldType.setSource(type);
        type = type.toUpperCase();

        fieldType.setLength(getFieldLength(type));
        fieldType.setUnsigned(checkUnsigned(type));

        type = type.toUpperCase();

        if (type.startsWith("VARCHAR") || type.startsWith("TEXT")) {
            fieldType.setJavaType("String");
            fieldType.setFullJavaType("java.lang.String");
            String s = JDBCType.VARCHAR.name();
            if (type.startsWith("TEXT")) s = JDBCType.LONGVARCHAR.name();
            fieldType.setJdbcType(s);
            return fieldType;
        } else if (type.startsWith("CHAR")) {
            fieldType.setJavaType("String");
            fieldType.setFullJavaType("java.lang.String");
            fieldType.setJdbcType(JDBCType.CHAR.name());
        } else if (type.startsWith("INT") || type.startsWith("TINYINT")) {
            fieldType.setJavaType("Integer");
            fieldType.setFullJavaType("java.lang.Integer");
            fieldType.setRawJavaType("int");
            String s = JDBCType.INTEGER.name();
            if (type.startsWith("TINYINT")) s = JDBCType.TINYINT.name();
            fieldType.setJdbcType(s);
        } else if (type.startsWith("BIGINT")) {
            fieldType.setJavaType("Long");
            fieldType.setFullJavaType("java.lang.Long");
            fieldType.setRawJavaType("long");
            fieldType.setJdbcType(JDBCType.BIGINT.name());
        } else if (type.startsWith("DECIMAL")) {
            fieldType.setJavaType("BigDecimal");
            fieldType.setFullJavaType("java.math.BigDecimal");
            fieldType.setJdbcType(JDBCType.DECIMAL.name());
        } else if (type.startsWith("FLOAT")) {
            fieldType.setJavaType("Float");
            fieldType.setFullJavaType("java.lang.Float");
            fieldType.setRawJavaType("java.lang.float");
            fieldType.setJdbcType(JDBCType.FLOAT.name());
        } else if (type.startsWith("DOUBLE")) {
            fieldType.setJavaType("Double");
            fieldType.setFullJavaType("java.lang.double");
            fieldType.setRawJavaType("double");
            fieldType.setJdbcType(JDBCType.DOUBLE.name());
        } else if (type.startsWith("DATETIME") || type.startsWith("TIMESTAMP")) {
            fieldType.setJavaType("Date");
            fieldType.setFullJavaType("java.util.Date");
            String s = JDBCType.TIMESTAMP.name();
            fieldType.setJdbcType(s);
        } else if (type.startsWith("SMALLINT")) {
            //sort 2byte
            fieldType.setJavaType("short");
            fieldType.setFullJavaType("java.lang.Short");
            fieldType.setRawJavaType("short");
            fieldType.setJdbcType(JDBCType.SMALLINT.name());
        } else {
            throw new RuntimeException("未匹配到的类型: " + type);
        }
        return fieldType;
    }

    /**
     * @param t int(10) or int(10) unsigned
     * @return Integer
     */
    private Integer getFieldLength(String t) {
        Integer length = null;
        Pattern p1 = Pattern.compile("\\w+.\\((\\d+)\\)");
        //设置字段长度
        Matcher len = p1.matcher(t);
        if (len.find()) {
            length = Integer.valueOf(len.group(1));
        }
        return length;
    }

    /**
     * 是否无符号
     *
     * @param t int(10) or int(10) unsigned
     * @return boolean
     */
    public Boolean checkUnsigned(String t) {
        Boolean r = null;
        Pattern p2 = Pattern.compile("^.*?(unsigned|UNSIGNED)$");
        //有无符号
        Matcher m2 = p2.matcher(t);
        if (m2.find()) {
            r = true;
        }
        return r;
    }

    public static void main(String[] args) {
//        Boolean aBoolean = DBUtil.getInstance().checkUnsigned("int(1) UNSIGNED");
//        System.out.println(aBoolean);
//        String blog_articles = DBUtil.getInstance().getDDL("admin_menu");
//        System.out.println(blog_articles);
//        String tableComment = DBUtil.getInstance().getTableComment(blog_articles);
//        System.out.println(tableComment);
//        DBUtil.getInstance().getTableInfo("blog_articles");

    }

}
