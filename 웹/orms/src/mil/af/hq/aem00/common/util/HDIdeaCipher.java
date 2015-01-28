// Decompiled by DJ v3.6.6.79 Copyright 2004 Atanas Neshkov  Date: 2012-01-06 오전 11:29:35
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   HDIdeaCipher.java

package mil.af.hq.aem00.common.util;

import java.io.PrintStream;

public class HDIdeaCipher
{

    public HDIdeaCipher()
    {
        tempShorts = new int[4];
    }

    public static void setKey(byte key[])
    {
        int k1;
        for(k1 = 0; k1 < 8; k1++)
            encryptKeys[k1] = (key[2 * k1] & 0xff) << 8 | key[2 * k1 + 1] & 0xff;

        int offset = 0;
        int i = 0;
        for(; k1 < 52; k1++)
        {
            i++;
            encryptKeys[i + 7 + offset] = (encryptKeys[(i & 7) + offset] << 9 | encryptKeys[(i + 1 & 7) + offset] >> 7) & 0xffff;
            offset += i & 8;
            i &= 7;
        }

        k1 = 0;
        int k2 = 51;
        int t1 = mulinv(encryptKeys[k1++]);
        int t2 = -encryptKeys[k1++] & 0xffff;
        int t3 = -encryptKeys[k1++] & 0xffff;
        decryptKeys[k2--] = mulinv(encryptKeys[k1++]);
        decryptKeys[k2--] = t3;
        decryptKeys[k2--] = t2;
        decryptKeys[k2--] = t1;
        for(int j = 1; j < 8; j++)
        {
            t1 = encryptKeys[k1++];
            decryptKeys[k2--] = encryptKeys[k1++];
            decryptKeys[k2--] = t1;
            t1 = mulinv(encryptKeys[k1++]);
            t2 = -encryptKeys[k1++] & 0xffff;
            t3 = -encryptKeys[k1++] & 0xffff;
            decryptKeys[k2--] = mulinv(encryptKeys[k1++]);
            decryptKeys[k2--] = t2;
            decryptKeys[k2--] = t3;
            decryptKeys[k2--] = t1;
        }

        t1 = encryptKeys[k1++];
        decryptKeys[k2--] = encryptKeys[k1++];
        decryptKeys[k2--] = t1;
        t1 = mulinv(encryptKeys[k1++]);
        t2 = -encryptKeys[k1++] & 0xffff;
        t3 = -encryptKeys[k1++] & 0xffff;
        decryptKeys[k2--] = mulinv(encryptKeys[k1++]);
        decryptKeys[k2--] = t3;
        decryptKeys[k2--] = t2;
        decryptKeys[k2--] = t1;
    }

    public String encrypt(String plainTextStr)
    {
        if(plainTextStr.length() <= 8)
            return encryptBlock(plainTextStr);
        StringBuffer buffer = new StringBuffer();
        int blockLen = (plainTextStr.length() - 1) / 8 + 1;
        for(int i = 0; i < blockLen; i++)
            if(i + 1 == blockLen)
                buffer.append(encryptBlock(plainTextStr.substring(i * 8)));
            else
                buffer.append(encryptBlock(plainTextStr.substring(i * 8, (i + 1) * 8)));

        return buffer.toString();
    }

    public String decrypt(String cipherTextStr)
    {
        if(cipherTextStr.length() <= 11)
            return decryptBlock(cipherTextStr);
        StringBuffer buffer = new StringBuffer();
        int blockLen = cipherTextStr.length() / 11;
        for(int i = 0; i < blockLen; i++)
            buffer.append(decryptBlock(cipherTextStr.substring(i * 11, (i + 1) * 11)));

        return buffer.toString();
    }

    public String encryptBlock(String plainTextStr)
    {
        byte plainText[] = makeCipherBlockBytes(plainTextStr);
        byte cipherText[] = new byte[9];
        for(int i = 0; i < 9; i++)
            cipherText[i] = 0;

        squashBytesToShorts(plainText, 0, tempShorts, 0, 4);
        idea(tempShorts, tempShorts, encryptKeys);
        spreadShortsToBytes(tempShorts, 0, cipherText, 0, 4);
        return encoding(cipherText);
    }

    public String decryptBlock(String cipherTextStr)
    {
        byte cipherText[] = decoding(cipherTextStr);
        byte plainText[] = new byte[8];
        squashBytesToShorts(cipherText, 0, tempShorts, 0, 4);
        idea(tempShorts, tempShorts, decryptKeys);
        spreadShortsToBytes(tempShorts, 0, plainText, 0, 4);
        int i;
        for(i = 0; i < 8 && plainText[i] != 0; i++);
        return new String(plainText, 0, i);
    }

    private byte[] makeCipherBlockBytes(String notQuadrupleTextStr)
    {
        byte text[] = notQuadrupleTextStr.getBytes();
        int len = text.length;
        byte ret[] = new byte[8];
        if(len >= 8)
            len = 8;
        System.arraycopy(text, 0, ret, 0, len);
        for(int i = len; i < 8; i++)
            ret[i] = 0;

        return ret;
    }

    private String encoding(byte text[])
    {
        byte ret[] = new byte[11];
        int shift = 2;
        int j = 0;
        int i = 0;
        ret[j] = (byte)(((text[i] & 0xff) >>> shift) + 48);
        i++;
        for(j = 1; j < 11; j++)
        {
            if((shift += 2) > 8)
            {
                shift = 2;
                i--;
            }
            ret[j] = (byte)(((text[i - 1] & 0xff) << 8 - shift | (text[i] & 0xff) >>> shift) & 0x3f);
            ret[j] += 48;
            i++;
        }

        String retStr = new String(ret);
        return retStr;
    }

    private byte[] decoding(String textStr)
    {
        byte ret[] = new byte[8];
        byte text[] = textStr.getBytes();
        for(int l = 0; l < 11; l++)
            text[l] = (byte)(text[l] - 48);

        int i = 0;
        int shift = 0;
        for(int j = 0; j < 8; j++)
        {
            if((shift += 2) > 7)
            {
                shift = 2;
                i++;
            }
            ret[j] = (byte)(text[i] << shift | text[i + 1] >>> 6 - shift);
            i++;
        }

        return ret;
    }

    private void idea(int inShorts[], int outShorts[], int keys[])
    {
        int x1 = inShorts[0];
        int x2 = inShorts[1];
        int x3 = inShorts[2];
        int x4 = inShorts[3];
        int k = 0;
        for(int round = 0; round < 8; round++)
        {
            x1 = mul(x1 & 0xffff, keys[k++]);
            x2 = x2 + keys[k++] & 0xffff;
            x3 = x3 + keys[k++] & 0xffff;
            x4 = mul(x4 & 0xffff, keys[k++]);
            int t3 = x3;
            x3 ^= x1;
            x3 = mul(x3 & 0xffff, keys[k++]);
            int t2 = x2;
            x2 ^= x4;
            x2 = x2 + x3 & 0xffff;
            x2 = mul(x2 & 0xffff, keys[k++]);
            x3 = x2 + x3 & 0xffff;
            x1 ^= x2;
            x4 ^= x3;
            x2 ^= t3;
            x3 ^= t2;
        }

        outShorts[0] = mul(x1 & 0xffff, keys[k++]) & 0xffff;
        outShorts[1] = x3 + keys[k++] & 0xffff;
        outShorts[2] = x2 + keys[k++] & 0xffff;
        outShorts[3] = mul(x4 & 0xffff, keys[k++]) & 0xffff;
    }

    private static int mul(int a, int b)
    {
        int ab = a * b;
        if(ab != 0)
        {
            int lo = ab & 0xffff;
            int hi = ab >>> 16;
            return (lo - hi) + (lo >= hi ? 0 : 1) & 0xffff;
        }
        if(a != 0)
            return 1 - a & 0xffff;
        else
            return 1 - b & 0xffff;
    }

    private static int mulinv(int x)
    {
        if(x <= 1)
            return x;
        int t0 = 1;
        int t1 = 0x10001 / x;
        int y = 0x10001 % x & 0xffff;
        do
        {
            if(y == 1)
                return 1 - t1 & 0xffff;
            int q = x / y;
            x %= y;
            t0 = t0 + q * t1 & 0xffff;
            if(x == 1)
                return t0;
            q = y / x;
            y %= x;
            t1 = t1 + q * t0 & 0xffff;
        } while(true);
    }

    public static void setKey(String keyStr)
    {
        byte key[] = new byte[16];
        byte suppliedKey[] = keyStr.getBytes();
        int len = suppliedKey.length;
        if(len > 16)
            len = 16;
        System.arraycopy(suppliedKey, 0, key, 0, len);
        for(int i = len; i < 16; i++)
            key[i] = 0;

        setKey(key);
    }

    private void squashBytesToShorts(byte inBytes[], int inOff, int outShorts[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
            outShorts[outOff + i] = (inBytes[inOff + i * 2 + 1] & 0xff) << 8 | inBytes[inOff + i * 2] & 0xff;

    }

    private static void spreadShortsToBytes(int inShorts[], int inOff, byte outBytes[], int outOff, int shortLen)
    {
        for(int i = 0; i < shortLen; i++)
        {
            outBytes[outOff + i * 2 + 1] = (byte)(inShorts[inOff + i] >>> 8 & 0xff);
            outBytes[outOff + i * 2] = (byte)(inShorts[inOff + i] & 0xff);
        }

    }

    public String Encode(String plainText)
        throws Exception
    {
        try
        {
            String s = encrypt(plainText);
            return s;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public String transform(int mode, String text)
        throws Exception
    {
        String result = null;
        try
        {
            result = encrypt(text);
        }
        catch(Exception exception) { }
        return result;
    }
    
    public static String replace( String source, String original, String newDelimeter ) {
		int swapIndex;
		if( ( swapIndex = source.indexOf( original ) ) >= 0 ) {
			StringBuffer result = new StringBuffer();
			int lastSwapIndex = 0;
			for( ; swapIndex >= 0; swapIndex = source.indexOf( original, lastSwapIndex ) ) {
				result.append( source.substring( lastSwapIndex, swapIndex ) );
				result.append( newDelimeter );
				lastSwapIndex = swapIndex + original.length();
			}

			if( lastSwapIndex < source.length() )
				result.append( source.substring( lastSwapIndex, source.length() ) );
			return result.toString();
		} else {
			return source;
		}
	}

    public static void main(String args[])
        throws Exception
    {
        /*if(args.length < 1)
        {
            System.err.println("Usage: java crypt.HDIdeaCipher plainText");
            System.exit(1);
        }
        String text = args[0];
        HDIdeaCipher cipher = new HDIdeaCipher();
        String result = cipher.transform(0, text);
        if(result == null)
        {
            System.err.println("key is invalid");
            System.exit(1);
        }
        System.out.println("plain text(" + text + ") -> cipher text(" + result + ")");*/
    	 HDIdeaCipher cipher = new HDIdeaCipher();
        System.out.println(cipher.replace(cipher.encrypt("10-70001051"),"\\","\\\\"));
        System.out.println(cipher.encrypt("10-70001051"));
    }

    private static final int cipherBlockLen = 8;
    private static final int cipherKeyLen = 16;
    private static final int cipherEncodingBlockLen = 11;
    private static int encryptKeys[] = new int[52];
    private static int decryptKeys[] = new int[52];
    private int tempShorts[];
    private static final int ENCRYPTION_MODE = 0;

    static 
    {
        setKey("abcdefghij");
    }
   
}