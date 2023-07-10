package util;

import lombok.Data;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 无限级节点模型
 */
@Data
public class Node {
    // 节点对象，没有按照规范封装，直接.属性即可
    private String id;
    private String title;
    private String type;
    private Integer jb;

    List<Node> children = new ArrayList<Node>();
    Map<String, Node> childMap = new LinkedHashMap<String, Node>();

    public Node() {
    }

    public Node(String id, String title, String type) {
        this.id = id;
        this.title = title;
        this.type = type;
    }

    public Node(String id, String title, String type,Integer jb) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.jb = jb;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        return printSelf(this, str);
    }

    public String printSelf(Node n, StringBuilder str) {//输出树的json结构
        List<Node> list = n.children;
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Node node = list.get(i);
                int childeSize = node.children.size();
                String mark = "";
                if (childeSize != 0) {
                    mark = ":";
                }
                str.append("{\"id\":\"" + node.id +"\",\"title\":\""+node.title+"\",\"type\":\""+node.type+"\",\"jb\":\""+node.jb+"\"");
                if("folder".equals(node.type)){
                    str.append(",\"products\":[");
                }
                printSelf(node, str);
                if(!"folder".equals(node.type)){
                    str.append("}");
                }else{
                    str.append("]}");
                }

                if (i + 1 != list.size()) {
                    str.append(",");
                }
            }
        }
        return str.toString();
    }
}
