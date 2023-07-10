package util;

import java.security.MessageDigest;
import java.lang.StringBuffer;

public class SecurityMessage {
    public SecurityMessage(){}

    private String byto2hex2(byte[] bin){
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < bin.length; ++i) {
            int x = bin[i] & 0xFF, h = x >>> 4, l = x & 0x0F;
            buf.append((char) (h + ((h < 10) ? '0' : 'a' - 10)));
            buf.append((char) (l + ((l < 10) ? '0' : 'a' - 10)));
        }
        return buf.toString();
    }
    /**
     * @deprecated：数据MD5加密
     * @param myinfo String
     * @return String
     */
    public String messageDigest(String myinfo) {
        byte[] digesta = null;
        try{
            MessageDigest algb=MessageDigest.getInstance("MD5");
            algb.update(myinfo.getBytes("UTF-8"));
            digesta = algb.digest();
        } catch (Exception e) {
        }
        return byto2hex2(digesta);
    }

    public static void main(String[] args) {
        SecurityMessage sm = new SecurityMessage();
        System.out.println(sm.messageDigest("0000"));
        //System.out.println(sm.messageDigest("count=5"));
        //System.out.println(sm.messageDigest("19810830"));
    }

}
