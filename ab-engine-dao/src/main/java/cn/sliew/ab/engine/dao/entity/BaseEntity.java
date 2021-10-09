package cn.sliew.ab.engine.dao.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BaseEntity {

    /**
     * id。唯一主键
     */
    private Long id;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 修改人
     */
    private String modifier;

    /**
     * 是否删除。false: 未删除, true: 已删除
     * mybatis 自动将 tinyint 类转换成 boolean 类型，在数据库中 0: 未删除, 1: 已删除
     */
    private boolean deleted;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 更新时间
     */
    private Date gmtModified;
}
