package com.noriteo.delinori.common.config;

import com.noriteo.delinori.board.config.BoardRootConfig;
import com.noriteo.delinori.common.security.config.SecurityConfig;
import com.noriteo.delinori.member.config.MemberRootConfig;
import com.noriteo.delinori.notice.config.NoticeRootConfig;
import com.noriteo.delinori.qna.config.QnaRootConfig;
import com.noriteo.delinori.saleboard.config.SaleBoardRootConfig;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
@Import({SaleBoardRootConfig.class,
        BoardRootConfig.class,
        MemberRootConfig.class,
        NoticeRootConfig.class,
        QnaRootConfig.class,
        SecurityConfig.class
})
public class RootConfig {

    @Bean //mybatis 연결
    public SqlSessionFactory sqlSessionFactory() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource());
        return sqlSessionFactoryBean.getObject();
    }
    @Bean
    public DataSource dataSource(){
        HikariConfig config = new HikariConfig();

        config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

        config.setJdbcUrl("jdbc:log4jdbc:mysql://106.241.252.51:1524/delinori");
        config.setUsername("delinori");
        config.setPassword("delinoripw");
        config.setMaximumPoolSize(3);
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;
//        HikariConfig config = new HikariConfig();
//
//        config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
//
//        config.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/springdb");
//        config.setUsername("springuser");
//        config.setPassword("springuser");
//        HikariDataSource dataSource = new HikariDataSource(config);
//        return dataSource;

    }

    @Bean
    public TransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }

}
