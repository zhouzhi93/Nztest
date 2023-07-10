package util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class NodeUtil {

    //统计明细集长，10101
    static final String tjmxjc = "3,3,3,3,3,3,3,3,3,3";

    public static void main(String[] args) {
        Node node = new Node();//
        initTreeData(node);// 构建树前的初始化平铺数据，模拟数据库查询出的数据

        Map<String, Node> rMap = new LinkedHashMap<String, Node>();// 临时组织数据map

        for (Node thisN : node.children) {
            turnToMap(rMap, thisN);// 将平铺的数据，解析到map中，构建一颗逻辑树
        }

        Node root = new Node();// 结果树
        turnToList(rMap, root);// 递归解析map树，并放入root这个根节点中
        System.out.println("["+root+"]");
        // root既是结果树
    }

    static void turnToMap(Map<String, Node> rMap, Node n) {
        String key = null;
        List<String> keyList = new ArrayList<String>();
        for (int i = 0; i < n.getId().length() / 2; i++) {// 组装code的父级结构
            key = n.getId().substring(0, 2 + (i * 2));
            keyList.add(key);
        }

        String thisKey = null;
        Node tmpNode = null;
        Map<String, Node> tmpMap = rMap;
        for (int i = 0; i < keyList.size(); i++) {
            thisKey = keyList.get(i);
            tmpNode = tmpMap.get(thisKey);
            if (i + 1 == keyList.size()) {
                tmpMap.put(n.getId(), n);// 如果是末级节点，则放入该节点
            } else {
                tmpMap = tmpNode.childMap;// 如果不是末级节点，则将该节点赋值给临时变量
            }
        }
    }

    static void turnToMapByTjmx(Map<String, Node> rMap, Node n) {

        String[] coums = tjmxjc.split(",");
        String key = null;
        List<String> keyList = new ArrayList<String>();

        //有几个级别循环几次
        for (int i = 0; i < n.getJb(); i++) {// 组装code的父级结构
            Integer jbcd = 0;
            for(int j = 0 ; j<=i ; j++){
                Integer temp = Integer.parseInt(coums[j]);
                jbcd+=temp;
            }
            key = n.getId().substring(0, jbcd);
            keyList.add(key);
        }

        String thisKey = null;
        Node tmpNode = null;
        Map<String, Node> tmpMap = rMap;
        for (int i = 0; i < keyList.size(); i++) {
            thisKey = keyList.get(i);
            tmpNode = tmpMap.get(thisKey);
            if (i + 1 == keyList.size()) {
                tmpMap.put(n.getId(), n);// 如果是末级节点，则放入该节点
            } else {
                tmpMap = tmpNode.childMap;// 如果不是末级节点，则将该节点赋值给临时变量
            }
        }
    }

    static void turnToList(Map<String, Node> rMap, Node rn) {
        Set<Entry<String, Node>> eSet = rMap.entrySet();
        Iterator<Entry<String, Node>> mIt = eSet.iterator();
        while (mIt.hasNext()) {
            Entry<String, Node> entry = mIt.next();
            Node node = entry.getValue();
            rn.children.add(node);
            turnToList(node.childMap, node);
        }
    }

    static void initTreeData(Node node) {
        node.children.add(new Node("0001","苹果公司","folder"));
        node.children.add(new Node("00010001","iPhone","item"));
        node.children.add(new Node("00010002","iMac","folder"));
        node.children.add(new Node("0002","农药","folder"));
        node.children.add(new Node("00020001","除草剂","item"));
        node.children.add(new Node("00020002","杀虫剂","folder"));
        node.children.add(new Node("000200020001","农药原药","item"));
        node.children.add(new Node("000200020002","农药助剂","item"));

        node.children.add(new Node("00020003","杀虫剂","item"));
        node.children.add(new Node("000100020001","农药原药","item"));
        node.children.add(new Node("000100020002","农药助剂","item"));
    }

    public String NodeTree(List<Node> nodes){
        Node node = new Node();
        node.children = nodes;

        Map<String, Node> rMap = new LinkedHashMap<String, Node>();// 临时组织数据map

        for (Node thisN : node.children) {
            turnToMap(rMap, thisN);// 将平铺的数据，解析到map中，构建一颗逻辑树
        }

        Node root = new Node();// 结果树
        turnToList(rMap, root);// 递归解析map树，并放入root这个根节点中
        return "["+root+"]";
    }

    public String NodeTreeByTjmx(List<Node> nodes){
        Node node = new Node();
        node.children = nodes;

        Map<String, Node> rMap = new LinkedHashMap<String, Node>();// 临时组织数据map

        for (Node thisN : node.children) {
            turnToMapByTjmx(rMap, thisN);// 将平铺的数据，解析到map中，构建一颗逻辑树
        }

        Node root = new Node();// 结果树
        turnToList(rMap, root);// 递归解析map树，并放入root这个根节点中
        return "["+root+"]";
    }

}