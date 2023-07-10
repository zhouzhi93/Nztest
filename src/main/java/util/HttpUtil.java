package util;

import java.io.*;

import java.awt.image.BufferedImage;

import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import javax.imageio.*;
//import org.apache.commons.httpclient.params.HttpMethodParams;
import com.infol.nztest.dao.SqlServerOperator;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.client.HttpClient;


import org.apache.http.entity.FileEntity;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;////jdk1.6
import org.json.JSONObject;

//import sun.misc.BASE64Decoder;
//import sun.misc.BASE64Encoder;

import org.apache.commons.codec.binary.Base64;
public class HttpUtil {
	private static String appid = "NYGLXT";//
	private static String appKey = "a4d522e340574021b2f9c28b15824753";
	//private static String baseUrl = "http://47.94.151.103:39999/thirdApi/";
	private static String baseUrl = "http://221.224.244.117:18080/systemManagementApi/thirdApi/";
	private SqlServerOperator dbo = null;
	public HttpUtil() {
		try {
			dbo = new SqlServerOperator();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static boolean isEmpty(String str) {
		return str==null||"".equals(str.trim());
	}
	/**
	 *@description 根据条形码、身份证、市民卡号获取相关信息
	 *@param String userid 二维码
	 *@param String identity 身份证号
	 *@param String card 市民卡号
	 *@param String serial 读卡设备序列号
	 */
	public String userInfoBy(String userid,String identity,String card,String serial) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		if(!this.isEmpty(userid)) params.put("userId",userid);
		if(!this.isEmpty(identity)) params.put("identity",identity);
		if(!this.isEmpty(card)) params.put("cardNumber",card);
		if(!this.isEmpty(serial)) params.put("readerSerialNo",serial);
		String str = this.post("userInfo",params);
		return this.getMessage(str);
	}
	/**
	 *@description 根据条形码、身份证、市民卡号获取相关信息
	 *@param String userid 二维码
	 *@param String serial 读卡设备序列号
	 */
	public String userInfoByUid(String userid,String serial) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		if(!this.isEmpty(userid)) params.put("userId",userid);
		else throw new Exception("用户ID不能为空");
		if(!this.isEmpty(serial)) params.put("readerSerialNo",serial);
		String str =  this.post("userInfo",params);
		return this.getMessage(str);
	}
	/**
	 *@description 根据条形码、身份证、市民卡号获取相关信息
	 *@param String identity 身份证号
	 *@param String serial 读卡设备序列号
	 */
	public String userInfoByIdentity(String identity,String serial) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		if(!this.isEmpty(identity)) params.put("identity",identity);
		else throw new Exception("身份证号不能为空");
		if(!this.isEmpty(serial)) params.put("readerSerialNo",serial);
		String str = this.post("userInfo",params);
		return this.getMessage(str);
	}
	/**
	 *@description 根据条形码、身份证、市民卡号获取相关信息不用读卡器
	 *@param String identity 身份证号
	 */
	public String userInfoByIdentityNoCard(String identity) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		if(!this.isEmpty(identity)) params.put("identity",identity);
		else throw new Exception("身份证号不能为空");
		//if(!this.isEmpty(serial)) params.put("readerSerialNo",serial);
		String str = this.post("userInfo",params);
		return this.getMessage(str);
	}
	/**
	 *@description 根据条形码、身份证、市民卡号获取相关信息
	 *@param String card 市民卡号
	 *@param String serial 读卡设备序列号
	 */
	public String userInfoBycard(String card,String serial) throws Exception {
		System.out.println("card="+card+">>>serial="+serial);
		Map<String,String> params = new HashMap<String,String>();
		if(!this.isEmpty(card)) params.put("cardNumber",card);
		else throw new Exception("市民卡号不能为空");
		if(!this.isEmpty(serial)) params.put("readerSerialNo",serial);
		String str = this.post("userInfo",params);
		//System.out.println("00000000000--------"+str);
		String result =  this.getMessage(str);
		//System.out.println("1111111--------"+result);
		return result;
	}

	/**
	 *@description 根据人脸照片获取相关信息
	 *@param String face 人脸照片
	 *@param String serial 摄像头设备序列号
	 */
	public String userInfoByFace(String face,String serial) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		//HttpUtil.encodeImgageToBase64(face);
		params.put("faceImg",face);
		if(!this.isEmpty(serial)) params.put("cameraSerialNo",serial);
		String str = this.post("checkFace",params);
		return this.getMessage(str);
	}

	/**
	 *@description 根据身份证图片获取相关信息
	 *@param String idImg 身份证图片
	 *@param String serial 摄像头设备序列号
	 */
	public String userInfoByVideoIdentity(String idImg,String serial) throws Exception {
		Map<String,String> params = new HashMap<String,String>();
		//HttpUtil.encodeImgageToBase64(face);
		params.put("idImg",idImg);
		if(!this.isEmpty(serial)) params.put("cameraSerialNo",serial);
		String str = this.post("checkIdImg",params);
		return this.getMessage(str);
	}

	/**
	 *  打印请求参数
	 *
	 */
	private void printParameters(Map<String,String> map) {
		Iterator its = map.keySet().iterator();
		String key = null;
		System.out.println("----------****************start------------");
		while(its.hasNext()) {
			key = (String)its.next();
			System.out.println(key+"="+(String)map.get(key));
		}
		System.out.println("----------****************stop------------");
	}
	public boolean sales(Map<String,String> map,String ff) throws Exception{
		try {
			File file = ff==null||"".equals(ff)?null:new File(ff);
			//this.printParameters(map);
			String str =  this.postFile("submitOrderInfo",map,file);
			//System.out.println("-----"+str);
			return this.getMessageok(str);
		}  catch(Exception ee){
			ee.printStackTrace();
		}
		return false;
	}

	public boolean department(Map<String,String> map) throws Exception{

		this.printParameters(map);
		String str =  this.post("syncPesticideStore",map);
		System.out.println(str);
		return this.getMessageok(str);
	}
	/**
	 * <p>将文件转成base64 字符串</p>
	 * @param path 文件路径
	 * @return
	 * @throws Exception
	 */
	public static String encodeBase64File(String path) throws Exception {
		File file = new File(path);
		FileInputStream inputFile = new FileInputStream(file);
		byte[] buffer = new byte[(int)file.length()];
		inputFile.read(buffer);
		inputFile.close();
		return new String(encoder.encodeBase64(buffer));
	}
	/**
	 * <p>将base64字符解码保存文件</p>
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */
	public static void decoderBase64File(String base64Code,String targetPath) throws Exception {
		byte[] buffer = encoder.decode(base64Code.getBytes());
		FileOutputStream out = new FileOutputStream(targetPath);
		out.write(buffer);
		out.close();
	}
	/**
	 * <p>将base64字符保存文本文件</p>
	 * @param base64Code
	 * @param targetPath
	 * @throws Exception
	 */
	public static void toFile(String base64Code,String targetPath) throws Exception {
		byte[] buffer = base64Code.getBytes();
		FileOutputStream out = new FileOutputStream(targetPath);
		out.write(buffer);
		out.close();
	}
	public static final String succ = "SUCCESS";

	//调用接口查询
	public static String getMessage(String results) throws Exception {
		JSONObject json = new JSONObject(results);
    	/*JSONArray arr = json.names();
    	Object obj = null;
    	for(int i=0; i<arr.length(); i++) {
    		System.out.print(arr.getString(i));
    		obj = json.get(arr.getString(i));

    		System.out.println(   "      "+obj.getClass());
    	}*/
		//System.out.println(results);
		boolean ok = json.getBoolean("success");
		if(!ok) {
			throw new Exception(json.getString("message"));
		} else {
			String str = null;
			try {
				str = json.getJSONObject("result").toString();
			} catch(Exception e){
				str = "";
			}
			return str;
		}
	}

	public static Boolean getMessageok(String results) throws Exception {
		JSONObject json = new JSONObject(results);
    	/*JSONArray arr = json.names();
    	Object obj = null;
    	for(int i=0; i<arr.length(); i++) {
    		System.out.print(arr.getString(i));
    		obj = json.get(arr.getString(i));

    		System.out.println(   "      "+obj.getClass());
    	}*/
		//System.out.println(results);
		boolean ok = json.getBoolean("success");
		if(!ok) {
			throw new Exception(json.getString("message"));
		} else {
			return ok;
		}
	}

	/**
	 * pose方式请求
	 * @param url
	 * @return {statusCode : "请求结果状态代码", responseString : "请求结果响应字符串"}
	 */
	public static String post(String url, Map<String, String> params) {
		DefaultHttpClient httpclient = new DefaultHttpClient();
		params.put("appId",appid);//事先设置好的
		String sign = new HttpUtil().signature(params);
		params.put("signature",appKey);//数字签名
		HttpPost post = HttpUtil.postForm(HttpUtil.baseUrl+url, params);
//		post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
//		post.addHeader("Content-Type","text/html;charset=UTF-8");
//		post.setHeader("Content-Type","text/html;charset=UTF-8");
		Map reponseMap = invoke(httpclient, post);
		httpclient.getConnectionManager().shutdown();
		return (String)reponseMap.get("response");
	}

	public String postFile(String url,Map<String,String> params,File file) throws Exception {

		params.put("appId",appid);//事先设置好的
		String sign = new HttpUtil().signature(params);
		params.put("signature",appKey);//数字签名
		String BOUNDARY = java.util.UUID.randomUUID().toString();
		MultipartEntity multipartEntity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE, "--------------------"+BOUNDARY, Charset.defaultCharset());
		//multipartEntity.addPart("key",new StringBody("123456",Charset.forName("UTF-8")));
		//multipartEntity.addPart("from",new StringBody("cw",Charset.forName("UTF-8")));

		Set<String> keySet = params.keySet();
		for(String key : keySet) {
			//nvps.add(new BasicNameValuePair(key, params.get(key)));
			multipartEntity.addPart(key,new StringBody(params.get(key),Charset.forName("UTF-8")));
		}

		//FormFieldKeyValuePair
		if(file!=null)multipartEntity.addPart("file", new FileBody(file));
		//InputStream inputStream=new FileInputStream(value);;
		//inputStream=new ByteArrayInputStream("字符串转输入流".getBytes(Charset.forName("UTF-8")));
		//inputStream= IOUtil.newInputStream(ByteBuffer.wrap("字符串".getBytes()));
		//multipartEntity.addPart("image_binary",new InputStreamBody(inputStream,"1.jpg"));
		HttpPost request = new HttpPost(HttpUtil.baseUrl+url);

		request.setEntity(multipartEntity);
		request.addHeader("Content-Type", "multipart/form-data; boundary=--------------------"+BOUNDARY);
		//request.addHeader("Content-Type","image/jpeg");  //视情况而定

		DefaultHttpClient httpClient = new DefaultHttpClient();
		HttpResponse response = httpClient.execute(request);
		InputStream is = response.getEntity().getContent();
		BufferedReader in = new BufferedReader(new InputStreamReader(is));
		StringBuffer buffer = new StringBuffer();
		String line = "";
		while ((line = in.readLine()) != null) {
			buffer.append(line);
		}
		String msg = buffer.toString();
		//System.out.println("发送消息收到的返回："+buffer.toString());
		return new String(msg.getBytes(),"UTF-8");
	}


	/*
	public static String doPostWithFile(String url, Map<String, String> params,String savefileName,String fileName, String param) {
		params.put("appId",appid);//事先设置好的
		String sign = new HttpUtil().signature(params);
		params.put("signature",sign);//数字签名

        String result = "";
          try {
                // 换行符
                final String newLine = "\r\n";
                final String boundaryPrefix = "--";
                // 定义数据分隔线
                String BOUNDARY = "========7d4a6d158c9";
                // 服务器的域名
                URL realurl = new URL(url);
                // 发送POST请求必须设置如下两行
                HttpURLConnection connection = (HttpURLConnection) realurl.openConnection();
                OutputStream out = connection.getOutputStream();
                connection.setDoOutput(true);
                connection.setDoInput(true);
                connection.setUseCaches(false);
                connection.setRequestMethod("POST");
                connection.setRequestProperty("Connection","Keep-Alive");
                connection.setRequestProperty("Charset","UTF-8");
                connection.setRequestProperty("Content-Type","multipart/form-data; boundary=" + BOUNDARY);
                // 头
                String boundary = BOUNDARY;
                // 传输内容
                StringBuffer contentBody =new StringBuffer("--" + BOUNDARY);
                // 尾
                String endBoundary ="\r\n--" + boundary + "--\r\n";

                // 1. 处理普通表单域(即形如key = value对)的POST请求（这里也可以循环处理多个字段，或直接给json）
                //这里看过其他的资料，都没有尝试成功是因为下面多给了个Content-Type
                //form-data  这个是form上传 可以模拟任何类型
                contentBody.append("\r\n")
                .append("Content-Disposition: form-data; name=\"")
                .append("param" + "\"")
                .append("\r\n")
                .append("\r\n")
                .append(param)
                .append("\r\n")
                .append("--")
                .append(boundary);
                String boundaryMessage1 =contentBody.toString();
                //System.out.println(boundaryMessage1);
                out.write(boundaryMessage1.getBytes("utf-8"));

                // 2. 处理file文件的POST请求（多个file可以循环处理）
                contentBody = new StringBuffer();
                contentBody.append("\r\n")
                .append("Content-Disposition:form-data; name=\"")
                .append("file" +"\"; ")   // form中field的名称
                .append("filename=\"")
                .append(fileName +"\"")   //上传文件的文件名，包括目录
                .append("\r\n")
                .append("Content-Type:multipart/form-data")
                .append("\r\n\r\n");
                String boundaryMessage2 = contentBody.toString();
                //System.out.println(boundaryMessage2);
                out.write(boundaryMessage2.getBytes("utf-8"));

                // 开始真正向服务器写文件
                File file = new File(savefileName);
                DataInputStream dis= new DataInputStream(new FileInputStream(file));
                int bytes = 0;
                byte[] bufferOut =new byte[(int) file.length()];
                bytes =dis.read(bufferOut);
                out.write(bufferOut,0, bytes);
                dis.close();
                byte[] endData = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();
                out.write(endData);
                out.flush();
                out.close();

                // 4. 从服务器获得回答的内容
                String strLine="";
                String strResponse ="";
                InputStream in =connection.getInputStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(in));
                while((strLine =reader.readLine()) != null)
                {
                        strResponse +=strLine +"\n";
                }
                System.out.print(strResponse);
                return strResponse;
            } catch (Exception e) {
                System.out.println("发送POST请求出现异常！" + e);
                e.printStackTrace();
            }
          return result;
    }
    */
	public static Map postJson(String url, String json){
		DefaultHttpClient httpclient = new DefaultHttpClient();
		StringEntity s;
		Map reponseMap = null;
		try {
			s = new StringEntity(json.toString(),"utf-8");
			s.setContentEncoding("UTF-8");
			s.setContentType("application/json; charset=utf-8");
			HttpPost post = new HttpPost(url);
			reponseMap = invoke(httpclient, post);
			httpclient.getConnectionManager().shutdown();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reponseMap;

	}

	private static Base64 encoder = new Base64();
	/**
	 * 将网络图片进行Base64位编码
	 *
	 * @param imgUrl
	 *            图片的url路径，如http://.....xx.jpg
	 * @return
	 */
	public static String encodeImgageToBase64(URL imageUrl) {// 将图片文件转化为字节数组字符串，并对其进行Base64编码处理
		ByteArrayOutputStream outputStream = null;
		try {
			BufferedImage bufferedImage = ImageIO.read(imageUrl);
			outputStream = new ByteArrayOutputStream();
			ImageIO.write(bufferedImage, "jpg", outputStream);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		// 对字节数组Base64编码
		//BASE64Encoder encoder = new BASE64Encoder();

		//return encoder.encode(outputStream.toByteArray());// 返回Base64编码过的字节数组字符串
		byte[] bs =  encoder.encodeBase64(outputStream.toByteArray());// 返回Base64编码过的字节数组字符串
		return new String(bs);
	}
	/**
	 * 拼接byte[]类型数据
	 */
	public static byte[] byteMerger(byte[] byte_1, byte[] byte_2,int byteread){
		byte[] byte_3 = new byte[byte_1.length+byteread];
		System.arraycopy(byte_1, 0, byte_3, 0, byte_1.length);
		System.arraycopy(byte_2, 0, byte_3, byte_1.length, byteread);
		return byte_3;
	}
	/**
	 * 将本地图片进行Base64位编码
	 *
	 * @param imgUrl
	 *            图片的url路径，如http://.....xx.jpg
	 * @return
	 */
	/**
	 * 解析base64,并保存到本地
	 */
	public static String encodeWavToBase64(String ff) {// 将图片文件转化为字节数组字符串，并对其进行Base64编码处理

		byte[] totalbyte = new byte[0];
		try {
			FileInputStream inStream = new FileInputStream(new File(ff));
			byte[] buffer = new byte[1204];
			int byteread = 0;
			String total = null;

			while ((byteread = inStream.read(buffer)) != -1) {//拼接流，这样写是保证文件不会被篡改
				totalbyte = byteMerger(totalbyte,buffer,byteread);
			}
			inStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 对字节数组Base64编码
		//BASE64Encoder encoder = new BASE64Encoder();
		//return encoder.encode(outputStream.toByteArray());// 返回Base64编码过的字节数组字符串
		return new String(encoder.encode(totalbyte));
	}

	/**
	 * 将Base64位编码的图片进行解码，并保存到指定目录
	 *
	 * @param base64
	 *            base64编码的图片信息
	 * @return
	 */
	public static void decodeBase64ToImage(String base64, String path,String imgName) {
		//BASE64Decoder decoder = new BASE64Decoder();


		try {
			FileOutputStream write = new FileOutputStream(new File(path
					+ imgName));
			//byte[] decoderBytes = decoder.decodeBuffer(base64);
			byte[] decoderBytes = encoder.decodeBase64(base64.getBytes());
			write.write(decoderBytes);
			write.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static HttpPost postForm(String url, Map<String, String> params){

		HttpPost httpost = new HttpPost(url);
		List<NameValuePair> nvps = new ArrayList <NameValuePair>();
		Set<String> keySet = params.keySet();
		for(String key : keySet) {
			nvps.add(new BasicNameValuePair(key, params.get(key)));
		}
		try {
			System.out.println(nvps.toString());
			httpost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return httpost;
	}

	private static Map invoke(DefaultHttpClient httpclient,HttpUriRequest httpost) {
		Map returnMap = new HashMap();
		HttpResponse response = sendRequest(httpclient, httpost);
//	    System.out.println("return code:"+response.getStatusLine().getStatusCode());
		String body = paseResponse(response);
//		System.out.println(body);
		returnMap.put("statusCode", response.getStatusLine().getStatusCode());	// 请求返回结果状态
		returnMap.put("response", body);
		return returnMap;
	}


	private static HttpResponse sendRequest(DefaultHttpClient httpclient,
											HttpUriRequest httpost) {

		HttpResponse response = null;
		try {
//			httpost.setHeader(new BasicHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"));
//			httpost.setHeader(new BasicHeader("Accept-Encoding", "gzip, deflate, sdch"));
//			httpost.setHeader(new BasicHeader("Accept-Language", "zh-CN,zh;q=0.8,en;q=0.6,zh-TW;q=0.4"));
//			httpost.setHeader(new BasicHeader("Cookie", "gwdshare_firstime=1489107643071; JSESSIONID1=Mz7Lr_ABVzLwt7MtlVT98wD9GVJyNUB_abmjmy3j6kUO4Cw5dyya!262353211; SSOSESSIONID=Xy3TYHZVmn2jjSrpRDk2PWmZvpQ9hx7JJFbmFCnpDy6WWLhd9BNF!341600644; JSESSIONID=tyzLsAgapszalXSkTNZqaM5p7ct2z1Kv840j0RVEA01ybvVbAnCM!-2024187659; _gscs_420267342=89475983q4lmqb48|pv:3; _gscbrs_420267342=1; cookie=36427284; _gscu_420267342=891076426ekv5h16"));
			response = httpclient.execute(httpost);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return response;
	}

	private static String paseResponse(HttpResponse response) {

		HttpEntity entity = response.getEntity();
		String charset = EntityUtils.getContentCharSet(entity);


		String body = null;
		try {
			body = EntityUtils.toString(entity,"UTF-8");
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return body;
	}

	private int[] string2Ascii(String value) {
		StringBuffer sbu = new StringBuffer();
		char[] chars = value.toCharArray();
		int s =    chars.length;
		int[] arr = new int[s];
		for (int i = 0; i < s; i++) {
			arr[i] = (int)chars[i];
		}
		return arr;
	}
	/**
	 *签名规则：
	 *1. 将调参数按参数名ASCII码正序排列
	 *2. 将每个参数格式化为 参数名=参数值 字符串
	 *3. ’&‘ 将每组参数拼接在?起
	 *4. 在最后拼接秘钥
	 *5. 对字符串进?MD5运算，得到签名
	 */
	public String signature(Map<String,String> params) {
		Iterator its = params.keySet().iterator();
		List lst = new ArrayList();
		String key = null, val = null;
		while(its.hasNext()) {
			key = (String)its.next();
			//val = (String)params.get(key);
			lst.add(key);
		}
		String[] sort = this.sortKey(lst);//1
		int i = 0;
		int s = sort.length;
		StringBuilder sb = new StringBuilder();
		for(i=0; i<s; i++) {
			if(i>0)sb.append("&");//3
			sb.append(sort[i]).append("=").append((String)params.get(sort[i]));//2
		}
		sb.append(appKey);

		String str  = sb.toString();
		//System.out.println("拼接字符串:   "+str);

		String md5 =  new SecurityMessage().messageDigest(str);
		//System.out.println("MD5加密字符串:"+ md5);

		return md5;
	}
	/**
	 * 判断two是否大于one
	 *
	 */
	public boolean moreThan(int[] one,int[] two) {
		int a = one.length;
		int b = two.length;
		int c = a>b?b:a;
		int d = -1;

		for(int i=0; i<c; i++) {
			if(two[i]>one[i]) {//后面大于
				d = 1;
				break;
			} else if(two[i]<one[i]){//后面小于
				d = 0;
				break;
			}
		}
		if(d == -1) {//前面都相等
			if(a>b) d=0;
			else if(a<b) d=1;
		}
		return d==1;
	}
	/**
	 *  正序排序序列
	 */
	public int[] sortKey1(List lst) {
		int s = lst==null ? 0 : lst.size();
		String key = null;
		int[] oarr = null;
		int max = -1;
		int[] _max = null;
		int[] sort = new int[s];

		int i=0,j=0, k = s-1, m = (s-s%2)/2;
		for(i=0; i<s; i++) sort[i] = -1;
		for(i=0; i<s-1; i++) {
			max = -1;
			for(j=0; j<s; j++) {
				if(sort[j]!=-1)continue;
				key = (String)lst.get(j);
				if(max==-1) {
					max = j;
					_max = this.string2Ascii(key);
				} else {
					oarr = this.string2Ascii(key);
					//System.out.print(max+" than " + j);
					if(this.moreThan(_max,oarr)) {//当前大于最大值
						_max  = oarr;
						max = j;
						//System.out.println(" true");
					} //else System.out.println(" false");
				}
			}
			sort[max] = k--;
		}
		for(i=0; i<s; i++) {
			if(sort[i] == -1)sort[i] = 0;
		}
		return sort;

	}

	public String[] sortKey(List lst) {
		int s = lst==null ? 0 : lst.size();
		String key = null;
		int[] oarr = null;
		int max = -1, min = -1;
		int[] _max = null, _min = null;
		String[] sort = new String[s];

		int i=0,j=0, k = 0, m = s;//(s-s%2)/2;
		for(i=0; i<m; i++) {
			max = 0;
			min = 0;
			key = (String)lst.get(0);
			oarr = this.string2Ascii(key);
			_max = oarr;
			_min = oarr;
			//System.out.print("i=="+i+">>");
			for(j=1; j<s; j++) {
				//System.out.print("  "+j);
				key = (String)lst.get(j);
				oarr = this.string2Ascii(key);
     			/*if(this.moreThan(_max,oarr)) {//当前大于最大值
     				_max  = oarr;
	     			max = j;
     			}*/
				if(this.moreThan(oarr,_min)) {//当前小于最小值
					_min = oarr;
					min = j;
				}
			}

			sort[k++] = (String)lst.get(min);
			//System.out.println("<><>"+min+">>"+sort[k-1]);
			lst.remove(min);
			s--;
		}
		return sort;

	}
     /*
     public static String uploadFileToOSS(String url,String path,Map map) {
     	try {
		    HttpClient httpclient = new DefaultHttpClient();
			HttpPost httppost = new HttpPost(url);

			List <NameValuePair> params = new ArrayList<NameValuePair>();

			//params.add(new BasicNameValuePair("api_key", key));

			httppost.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));

			MultipartEntity reqEntity = new MultipartEntity();
			reqEntity.addPart("file", new FileBody(file));

			Iterator its = map.keySet().iterator();
            String key = null;
            while(its.hasNext()) {
            	key = (String)its.next();
            	params.add(new BasicNameValuePair(key, (String)map.get(key)));
            }

			httppost.setEntity(reqEntity);

			System.out.println("executing request " + httppost.getRequestLine());
			HttpResponse response = httpclient.execute(httppost);
			HttpEntity resEntity = response.getEntity();

			System.out.println(response.getStatusLine());
			if (resEntity != null) {
			    System.out.println(EntityUtils.toString(resEntity));
			}
			if (resEntity != null) {
			    resEntity.consumeContent();
			}

			httpclient.getConnectionManager().shutdown();
     	} catch(Exception e){
     	}
	}*/
     /*
     public void upload(String localFile,Map map){
        File file = new File(localFile);
        PostMethod filePost = new PostMethod(baseUrl+"submitOrderInfo");
        HttpClient client = new HttpClient();

        try {
            // 通过以下方法可以模拟页面参数提交
            //filePost.setParameter("userName", userName);
            Iterator its = map.keySet().iterator();
            String key = null;
            while(its.hasNext()) {
            	key = (String)its.next();
            	filePost.setParameter(key, (String)map.get(key));
            }

            Part[] parts = { new FilePart(file.getName(), file) };
            filePost.setRequestEntity(new MultipartRequestEntity(parts, filePost.getParams()));

            client.getHttpConnectionManager().getParams().setConnectionTimeout(5000);

            int status = client.executeMethod(filePost);
            if (status == HttpStatus.SC_OK) {
                System.out.println("上传成功");
            } else {
                System.out.println("上传失败");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            filePost.releaseConnection();
        }
    }*/

	private static String readFile(String path)throws Exception {
		File f = new File(path);
		FileReader fr = new FileReader(f);
		java.io.BufferedReader bfr = new java.io.BufferedReader(fr);
		String str = null;
		StringBuilder sb = new StringBuilder();
		while((str = bfr.readLine())!=null) {
			sb.append(str);
		}
		return sb.toString();
	}

	/**
	 根据身份证号或者市?卡号或者?户id（?维码扫码）获取?户信息
	 请求地址：http://47.94.151.103:39999/thirdApi/userInfo 请求?法：POST
	 appId userId identity readerSerialNo signature
	 */
	public static void main(String[] args) throws Exception {
		//发送 GET 请求
		//String s=HttpUtil.sendGet("http://v.qq.com/x/cover/kvehb7okfxqstmc.html?vid=e01957zem6o", "");
		//System.out.println(s);
		HttpUtil  dao = new HttpUtil();
		//String str = dao.userInfoByIdentity("1311111111111111","a1321-3221");
		//String str = dao.userInfoBycard("1311111111111112","777");

		String base64="data:audio/mp3;base64,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";
		String path="d:/";
		String name="1.mp3";
		//dao.decodeBase64ToImage(base64,path,name);
		//System.out.println(str);

		File f = new File("d:/base64.txt");
		FileReader fr = new FileReader(f);
		java.io.BufferedReader bfr = new java.io.BufferedReader(fr);
		String str = null;
		StringBuilder sb = new StringBuilder();
		while((str = bfr.readLine())!=null) {
			sb.append(str);
		}

		str = dao.userInfoByFace(sb.toString(),"555");//D76170044
		System.out.println(str);

/*
 {"updateBy":null,"createTime":"2019-10-21 23:54:49",
 "birthday":null,"sex":null,"updateTime":"2019-10-21 23:54",
 "status":0,"faceToken":null,"apartment":null,"createBy":null,
 "password":null,"clientId":null,"nation":null,"roleList":null,"id":"198735131819642880",
 "identity":"1311111111111111","address":null,"duty":null,"ag
e":null,"name":null,"cardNumber":"1311111111111112","delFlag":0,"mobile":"131111
11111"}
 */


//        //发送 POST 请求
//        String sr=HttpUtil.sendPost("http://www.toutiao.com/stream/widget/local_weather/data/?city=%E4%B8%8A%E6%B5%B7", "");
//        JSONObject json = JSONObject.fromObject(sr);
//        System.out.println(json.get("data"));
	}
}

