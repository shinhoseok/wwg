/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.Base64.java
 * Description        : base64에관련된 다수의 기능을 제공하는 클래스.
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : 이금용
 * Updated content    : 패키지명 변경
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
 
/**
 * fast Base64 encoder/decoder
 *     
 */
 
public class Base64 {
    /**
     * 6비트 변환 테이블
     */
    protected static final char[] alphabet = { 
 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', // 0 to 7 
 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', // 8 to 15 
 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', // 16 to 23 
 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', // 24 to 31 
 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', // 32 to 39 
 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', // 40 to 47 
 'w', 'x', 'y', 'z', '0', '1', '2', '3', // 48 to 55 
 '4', '5', '6', '7', '8', '9', '+', '/'  // 56 to 63 
    };
 
    /**
     * 알파벳 역변환 테이블
     */
    protected static final int[] decodeTable = {
 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 0 to 9
 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 10 to 19
 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 20 to 29
 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 30 to 39
 -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, // 40 to 49
 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, // 50 to 59
 -1, -1, -1, -1, -1,  0,  1,  2,  3,  4, // 60 to 69
  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, // 70 to 79
 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, // 80 to 89
 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, // 90 to 99
 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, // 100 to 109
 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, // 110 to 119
 49, 50, 51                              // 120 to 122
    };
 
    public static char[] encode(String s) { 
    	return encode(s.getBytes()); 
    } 
 
    /**
     * convert bytes into a BASE64 encoded string
     */
    public static char[] encode(byte[] bytes) {
		 int sixbit;
		 
		 // 전체 문자열 길이는 3바이트를 6비트씩 표현하므로 3으로 나눈 다음
		 // 4를 곱하면 된다. 3으로 나누어 떨어지지 않으면 4 바이트가 추가된다.
		 // (Base64는 뒷 부분을 =으로 채워 전체 길이를 4의 배수로 만든다.)
		 char[] output
		     = new char[((bytes.length - 1) / 3 + 1) * 4]; 
		 
		 int outIndex = 0; 
		 int i = 0; 
		 
		 while ((i + 3) <= bytes.length) { 
		     // 3 바이트(24비트)를 6비트씩 자른 다음
		     // 해당하는 값을 알파벳 테이블에서 찾는다.
		 
		     // 첫번째 6비트 (6비트)
		     sixbit = (bytes[i] & 0xFC) >> 2;
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 두번째 6비트 (2비트, 4비트)
		     sixbit = ((bytes[i] & 0x3) << 4)
		  + ((bytes[i + 1] & 0xF0) >> 4);
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 세번째 6비트 (4비트, 2비트)
		     sixbit = ((bytes[i + 1] & 0xF) << 2)
		  + ((bytes[i + 2] & 0xC0) >> 6);
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 네번째 6비트 (6비트)
		     sixbit = bytes[i + 2] & 0x3F;
		     output[outIndex++] = alphabet[sixbit];
		 
		     i += 3;
		 } 
		 
		 if (bytes.length - i == 2) { // 2 바이트가 남은 경우 처리
		     // 2 바이트(16비트)를 6비트씩 자른 다음
		     // 해당하는 값을 알파벳 테이블에서 찾는다.
		 
		     // 첫번째 6비트 (6비트)
		     sixbit = (bytes[i] & 0xFC) >> 2;
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 두번째 6비트 (2비트, 4비트)
		     sixbit = ((bytes[i] & 0x3) << 4)
		  + ((bytes[i + 1] & 0xF0) >> 4);
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 세번째 6비트 (4비트, 0비트)
		     sixbit = (bytes[i + 1] & 0xF) << 2;
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 네번째 6비트 (남는 부분은 =으로 채운다.)
		     output[outIndex++] = '=';
		 } else if (bytes.length - i == 1) { // 1바이트가 남은 경우 처리
		     // 1 바이트(8비트)를 6비트씩 자른 다음
		     // 해당하는 값을 알파벳 테이블에서 찾는다.
		 
		     // 첫번째 6비트 (6비트)
		     sixbit = (bytes[i] & 0xFC) >> 2;
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 두번째 6비트 (2비트, 0비트)
		     sixbit = (bytes[i] & 0x3) << 4;
		     output[outIndex++] = alphabet[sixbit];
		 
		     // 세번째 6비트 (남는 부분은 =으로 채운다.)
		     output[outIndex++] = '=';
		     // 네번째 6비트 (남는 부분은 =으로 채운다.)
		     output[outIndex++] = '=';
		 }
		 
		 return output;
    } 
 
    /**
     * Base64로 인코딩된 문자열을 원래의 바이트 배열로 되돌린다.
     */
    public static byte[] decode(String encoded) {
		 byte[] decoded = null;
		 int decodedLength = (encoded.length() / 4 * 3);
		 int invalid = 0;
		 
		 if (encoded.length() % 4 != 0) {
		     System.err.println("It's not BASE64 encoded string.");
		     return null;
		 }
		 if (encoded.charAt(encoded.length() - 2) == '=') { // 마지막 2 바이트가 무효
		     invalid = 2;
		 } else if (encoded.charAt(encoded.length() - 1) == '=') { // 마지막 1 바이트가 무효
		     invalid = 1;
		 }
		 decodedLength -= invalid;
		 decoded = new byte[decodedLength];
		 
		 int i = 0, di = 0;
		 int sixbit0, sixbit1, sixbit2, sixbit3;
		 
		 for (; i < encoded.length() - 4; i += 4) {
		     sixbit0 = decodeTable[encoded.charAt(i)];
		     sixbit1 = decodeTable[encoded.charAt(i + 1)];
		     sixbit2 = decodeTable[encoded.charAt(i + 2)];
		     sixbit3 = decodeTable[encoded.charAt(i + 3)];
		 
		     decoded[di++] = (byte) ((sixbit0 << 2) + ((sixbit1 & 0x30) >> 4));
		     decoded[di++] = (byte) (((sixbit1 & 0xF) << 4) + ((sixbit2 & 0x3C) >> 2));
		     decoded[di++] = (byte) (((sixbit2 & 0x3) << 6) + sixbit3);
		 }
		 
		 // 마지막 사이클
		 switch (invalid) {
		 case 0 : // 3 바이트 모두 유효
		     sixbit0 = decodeTable[encoded.charAt(i)];
		     sixbit1 = decodeTable[encoded.charAt(i + 1)];
		     sixbit2 = decodeTable[encoded.charAt(i + 2)];
		     sixbit3 = decodeTable[encoded.charAt(i + 3)];
		 
		     decoded[di++] = (byte) ((sixbit0 << 2) + ((sixbit1 & 0x30) >> 4));
		     decoded[di++] = (byte) (((sixbit1 & 0xF) << 4) + ((sixbit2 & 0x3C) >> 2));
		     decoded[di++] = (byte) (((sixbit2 & 0x3) << 6) + sixbit3);
		     break;
		 
		 case 1 : // 2 바이트만 유효
		     sixbit0 = decodeTable[encoded.charAt(i)];
		     sixbit1 = decodeTable[encoded.charAt(i + 1)];
		     sixbit2 = decodeTable[encoded.charAt(i + 2)];
		 
		     decoded[di++] = (byte) ((sixbit0 << 2) + ((sixbit1 & 0x30) >> 4));
		     decoded[di++] = (byte) (((sixbit1 & 0xF) << 4) + ((sixbit2 & 0x3C) >> 2));
		     break;
		 
		 case 2 : // 1 바이트만 유효
		     sixbit0 = decodeTable[encoded.charAt(i)];
		     sixbit1 = decodeTable[encoded.charAt(i + 1)];
		 
		     decoded[di++] = (byte) ((sixbit0 << 2) + ((sixbit1 & 0x30) >> 4));
		     break;
		 }
		 
		 // assert decoded.length == di;
		 return decoded;
    } 
 

 
    /**
     * 두 바이트 배열의 내용이 같은지 여부를 비교
     */
    static boolean bytesEquals(byte[] b1, byte[] b2) {
		 if (b1.length != b2.length) {
		     return false;
		 }
		 
		 for (int i = b1.length - 1; i >= 0; i--) {
		     if (b1[i] != b2[i]) {
		  return false;
		     }
		 }
		 return true;
    }



}
