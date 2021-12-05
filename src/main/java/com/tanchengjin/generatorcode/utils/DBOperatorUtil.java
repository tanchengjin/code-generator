package com.tanchengjin.generatorcode.utils;

import com.tanchengjin.generatorcode.core.entity.Field;
import com.tanchengjin.generatorcode.core.entity.TableInfo;

import java.sql.*;
import java.util.List;

@Deprecated
public class DBOperatorUtil {
    public static final String showFullColumnTypeSql = "show full columns from %s;";

    private static final String toSql = "show create table %s;";

    private static final String descSql = "desc %s;";

    public static final String constructSql = "select * from information_schema.COLUMNS where TABLE_SCHEMA = '%s' and TABLE_NAME = '%s'";


    public static DatabaseMetaData getMeta() throws SQLException {
//        Connection connection = DBUtil.getInstance().getConnection();
//        return connection.getMetaData();
        return null;
    }



    //    public static List<TableInfo> getTables() throws SQLException {
//        ResultSet tables = getMeta().getTables(getConnection().getCatalog(), null, null, new String[]{"TABLE"});
//        ArrayList<TableInfo> tableInfos = new ArrayList<>();
//        while (tables.next()) {
//            TableInfo t = new TableInfo();
//            t.setTableName(tables.getString("TABLE_NAME"));
//            t.setTableType(tables.getString("TABLE_TYPE"));
//            t.setTableCat(tables.getString("TABLE_CAT"));
//            t.setComment(tables.getString("REMARKS"));
//            t.setTypeCat(tables.getString("TYPE_CAT"));
//            t.setTypeName(tables.getString("TYPE_NAME"));
//            tables.getString("TYPE_NAME");
//            tableInfos.add(t);
//        }
//        return tableInfos;
//    }
    public static List<TableInfo> getTables() throws SQLException {
//        Connection connection = DBUtil.getInstance().getConnection();

//        Statement statement = connection.createStatement();
//        ResultSet resultSet = statement.executeQuery(String.format(constructSql, "blog", "blog_articles"));
//        ArrayList<TableInfo> tableInfos = new ArrayList<>();
//        while (resultSet.next()) {
//            System.out.println(resultSet.toString());
//        }
//        while (tables.next()) {
//            TableInfo t = new TableInfo();
//            t.setTableName(tables.getString("TABLE_NAME"));
//            t.setTableType(tables.getString("TABLE_TYPE"));
//            t.setTableCat(tables.getString("TABLE_CAT"));
//            t.setComment(tables.getString("REMARKS"));
//            t.setTypeCat(tables.getString("TYPE_CAT"));
//            t.setTypeName(tables.getString("TYPE_NAME"));
//            tables.getString("TYPE_NAME");
//            tableInfos.add(t);
//        }
//        return tableInfos;
        return null;
    }

    public static List<Field> getFieldInfo() {
        return null;
    }
}
