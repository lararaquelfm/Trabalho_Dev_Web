package utils;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Utils {

    private Utils() {

    }

    public static String gerarSHA256(String senha) {
        try {
            byte[] hash = MessageDigest.getInstance("SHA-256").digest(senha.getBytes("UTF-8"));
            return new BigInteger(1, hash).toString(16);
        } catch (NoSuchAlgorithmException ex) {
            return null;
        } catch (UnsupportedEncodingException ex) {
            return null;
        }
    }
    
    public static final String UPLOAD_PATH = System.getProperty("user.home") + File.separator + "arquivos_ecommerce" + File.separator + "imagens";

}
