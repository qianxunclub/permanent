-- 创建数据库
create schema permanent;

create table platform
(
    `id`            int auto_increment primary key,
    `platform`      varchar(20)  not null comment '授权服务类型：QQ,WECHAT,WEIBO等',
    `open_id`       varchar(100) null comment 'openId',
    `token`         varchar(100) null comment 'access_token',
    `expires_in`    varchar(100) null,
    `refresh_token` varchar(100) null,
    `create_at`     timestamp default NOW() comment '创建时间',
    `update_at`     timestamp    null comment '更新时间',
    UNIQUE KEY `platform_unique` (`platform`, open_id)
) comment '第三方应用授权信息';


create table customers
(
    `id`         int auto_increment primary key,
    `username`   varchar(50)  not null comment '用户名',
    `password`   varchar(100) null comment '密码',
    `phone`      varchar(20)  null comment '手机号码',
    `email`      varchar(100) null comment '电子邮箱',
    `gender`     varchar(10)  null comment '性别',
    `nickname`   varchar(50)  null comment '昵称',
    `avatar_url` varchar(200) null comment '图像',
    `create_at`  timestamp default NOW() comment '创建时间',
    `update_at`  timestamp    null comment '更新时间',
    UNIQUE KEY `customers_unique` (`username`, `phone`, `email`)
) comment '用户信息';

create table customers_binding
(
    `id`           int auto_increment primary key,
    `platform`     varchar(20)  not null comment '授权服务类型：QQ,WECHAT,WEIBO等',
    `customers_id` int not null comment '用户ID',
    `platform_id`  int null comment '第三方授权ID',
    UNIQUE KEY `binding` (`customers_id`, `platform_id`)
) comment '用户信息';

create table subject_categories
(
    `id`              int auto_increment primary key,
    `customers_id`    int         not null comment '用户ID',
    `categories_name` varchar(50) not null comment '分类名称',
    `parent_id`       varchar(50) null comment '父级分类ID',
    `order_number`    int       default 0 comment '排序',
    `create_at`       timestamp default NOW() comment '创建时间',
    `update_at`       timestamp   null comment '更新时间',
    UNIQUE KEY `name` (`customers_id`, `categories_name`)
) comment '题目分类表';

create table question
(
    `id`             int auto_increment primary key,
    `customers_id`   int          not null comment '用户ID',
    `title`          varchar(200) not null comment '问题标题',
    `source_content` text         null comment '输入问题描述',
    `show_content`   text         null comment '转义展示问题描述',
    `answer_id`      int          not null comment '答案ID',
    `create_at`      timestamp default NOW() comment '创建时间',
    `update_at`      timestamp    null comment '更新时间',
    UNIQUE KEY `question` (`customers_id`, `answer_id`)
) comment '问题列表';

create table answer
(
    `id`             int auto_increment primary key,
    `customers_id`   int       not null comment '用户ID',
    `source_content` text      null comment '输入答案描述',
    `show_content`   text      null comment '转义展示答案描述',
    `create_at`      timestamp default NOW() comment '创建时间',
    `update_at`      timestamp null comment '更新时间'
) comment '答案列表';

create table subject_categories_question
(
    `id`                    int auto_increment primary key,
    `customers_id`          int not null comment '用户ID',
    `subject_categories_id` int null comment '题目分类ID',
    `question_id`           int null comment '问题ID',
    `order_number`          int default 0 comment '排序',
    UNIQUE KEY `subject_categories_question` (`customers_id`, `subject_categories_id`, `question_id`)
) comment '题目分类和问题关系表';

