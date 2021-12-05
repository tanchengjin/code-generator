package com.tanchengjin.generatorcode;

public class ProcessTest {
    public static void main(String[] args) {
        int total = 100;
        for (int i = 0; i < total; i++) {
            System.out.println(printProcess(total,i+1));
            try {
                Thread.sleep(200);
            }catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }

    public static String printProcess(int total,int finish)
    {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("\rloading[");
        for (int i = 0; i < total; i++) {
            if(i>finish)
            {
                stringBuffer.append("");
            }else if(i == finish)
            {
                stringBuffer.append(">");
            }else{
                stringBuffer.append("=");
            }
        }

        stringBuffer.append("]"+finish+"%");
        return stringBuffer.toString();
    }
}
