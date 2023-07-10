package com.infol.nztest.util.emay;

import java.util.HashMap;
import java.util.Map;
import com.infol.nztest.util.emay.eucp.inter.http.v1.dto.request.SmsSingleRequest;
import com.infol.nztest.util.emay.eucp.inter.http.v1.dto.response.SmsResponse;
import com.infol.nztest.util.emay.util.AES;
import com.infol.nztest.util.emay.util.GZIPUtils;
import com.infol.nztest.util.emay.util.JsonHelper;
import com.infol.nztest.util.emay.util.http.EmayHttpClient;
import com.infol.nztest.util.emay.util.http.EmayHttpRequestBytes;
import com.infol.nztest.util.emay.util.http.EmayHttpResponseBytes;
import com.infol.nztest.util.emay.util.http.EmayHttpResponseBytesPraser;
import com.infol.nztest.util.emay.util.http.EmayHttpResultCode;

public class SMS {	
	// appId		
	private static String appId = "EUCP-EMY-SMS1-0W7HE";//请联系销售，或者在页面中 获取
	// 密钥
	private static String secretKey = "91C52F4B69CF76BF";//请联系销售，或者在页面中 获取
	// 接口地址
	private static String host = "bjmtn.b2m.cn";//请联系销售获取
	// 加密算法
	private static String algorithm = "AES/ECB/PKCS5Padding";
	// 编码
	private static String encode = "UTF-8";
	// 是否压缩
	private static boolean isGzip = false; 
		
	/**
	 * 发送单条短信
	 * @param isGzip 是否压缩
	 */
	public static boolean setSingleSms(String mobile, String content) {		
		SmsSingleRequest pamars = new SmsSingleRequest();
		pamars.setContent(content);		
		pamars.setMobile(mobile);
		ResultModel result = request(appId, secretKey, algorithm, pamars, "http://" + host + "/inter/sendSingleSMS", isGzip, encode);
		System.out.println("result code :" + result.getCode());
		if("SUCCESS".equals(result.getCode())){
			SmsResponse response = JsonHelper.fromJson(SmsResponse.class, result.getResult());
			if (response != null) {
				System.out.println("data : " + response.getMobile() + "," + response.getSmsId() + "," + response.getCustomSmsId());
			}
			return true;		
		} else {
			return false;					
		}
	}
	
	
	/**
	 * 公共请求方法
	 */
	public static ResultModel request(String appId,String secretKey,String algorithm,Object content, String url,final boolean isGzip,String encode) {
		Map<String, String> headers = new HashMap<String, String>();
		EmayHttpRequestBytes request = null;
		try {
			headers.put("appId", appId);
			headers.put("encode", encode);
			String requestJson = JsonHelper.toJsonString(content);
			System.out.println("result json: " + requestJson);
			byte[] bytes = requestJson.getBytes(encode);
			System.out.println("request data size : " + bytes.length);
			if (isGzip) {
				headers.put("gzip", "on");
				bytes = GZIPUtils.compress(bytes);
				System.out.println("request data size [com]: " + bytes.length);
			}
			byte[] parambytes = AES.encrypt(bytes, secretKey.getBytes(), algorithm);
			System.out.println("request data size [en] : " + parambytes.length);
			request = new EmayHttpRequestBytes(url, encode, "POST", headers, null, parambytes);
		} catch (Exception e) {
			System.out.println("加密异常");
			e.printStackTrace();
		}
		EmayHttpClient client = new EmayHttpClient();
		String code = null;
		String result = null;
		try {
			EmayHttpResponseBytes res = client.service(request, new EmayHttpResponseBytesPraser());
			if(res == null){
				System.out.println("请求接口异常");
				return new ResultModel(code, result);
			}
			if (res.getResultCode().equals(EmayHttpResultCode.SUCCESS)) {
				if (res.getHttpCode() == 200) {
					code = res.getHeaders().get("result");
					if (code.equals("SUCCESS")) {
						byte[] data = res.getResultBytes();
						System.out.println("response data size [en and com] : " + data.length);
						data = AES.decrypt(data, secretKey.getBytes(), algorithm);
						if (isGzip) {
							data = GZIPUtils.decompress(data);
						}
						System.out.println("response data size : " + data.length);
						result = new String(data, encode);
						System.out.println("response json: " + result);
					}
				} else {
					System.out.println("请求接口异常,请求码:" + res.getHttpCode());
				}
			} else {
				System.out.println("请求接口网络异常:" + res.getResultCode().getCode());
			}
		} catch (Exception e) {
			System.out.println("解析失败");
			e.printStackTrace();
		}
		ResultModel re = new ResultModel(code, result);
		return re;
	}

}

